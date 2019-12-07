//
//  displayImageViewController.swift
//  Glam Art Media
//
//  Created by Andrew on 11/29/19.
//  Copyright © 2019 Andrew. All rights reserved.
//

import UIKit

class DisplayImageViewController: UIViewController, UIScrollViewDelegate, UIGestureRecognizerDelegate{
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.minimumZoomScale = 1
        scrollView.maximumZoomScale = 6
        scrollView.bounces = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.delegate = self
        return scrollView
    }()
    
    let mainImageView: UIImageView = {
        let image = UIImage(named: "photo")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let zoomButton: UIButton = {
        let btt = UIButton(type: .system)
        let img = UIImage(systemName: "plus.magnifyingglass")
        btt.setImage(img, for: .normal)
        btt.addTarget(self, action: #selector(zoomInPhoto), for: .touchUpInside)
        btt.translatesAutoresizingMaskIntoConstraints = false
        return btt
    }()
    
    override func viewDidLoad() {
        view.addSubview(scrollView)
        scrollView.addSubview(mainImageView)
        view.addSubview(zoomButton)
        addConstraints()
        initSwiperRecogniser()
    }
    
    func addConstraints(){
        NSLayoutConstraint.activate([
            scrollView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            mainImageView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            mainImageView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            mainImageView.topAnchor.constraint(equalTo: self.view.topAnchor),
            mainImageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            zoomButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20),
            zoomButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            zoomButton.heightAnchor.constraint(equalToConstant: 30),
            zoomButton.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func initSwiperRecogniser(){
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(centerScrollViewContents))
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(centerScrollViewContents))
        rightSwipe.delegate = self
        leftSwipe.delegate = self
        self.scrollView.addGestureRecognizer(rightSwipe)
        self.scrollView.addGestureRecognizer(leftSwipe)
        
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return true
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return mainImageView
    }
    
    @objc func zoomInPhoto(){
        if self.scrollView.minimumZoomScale == self.scrollView.zoomScale{
            scrollView.setZoomScale(self.scrollView.zoomScale * 5, animated: true)
        }else{
            scrollView.setZoomScale(self.scrollView.minimumZoomScale, animated: true)
        }
    }
    
    public func scrollViewDidZoom(_ scrollView: UIScrollView) {
        centerScrollViewContents()
    }

    private var scrollViewVisibleSize: CGSize {
        let contentInset = scrollView.contentInset
        let scrollViewSize = scrollView.bounds.standardized.size
        let width = scrollViewSize.width - contentInset.left - contentInset.right
        let height = scrollViewSize.height - contentInset.top - contentInset.bottom
        return CGSize(width:width, height:height)
    }

    private var scrollViewCenter: CGPoint {
        let scrollViewSize = self.scrollViewVisibleSize
        return CGPoint(x: scrollViewSize.width / 2.0,
                       y: scrollViewSize.height / 2.0)
    }

    @objc private func centerScrollViewContents() {
        guard let image = mainImageView.image else {
            return
        }

        let imgViewSize = mainImageView.frame.size
        let imageSize = image.size

        var realImgSize: CGSize
        if imageSize.width / imageSize.height > imgViewSize.width / imgViewSize.height {
            realImgSize = CGSize(width: imgViewSize.width,height: imgViewSize.width / imageSize.width * imageSize.height)
        } else {
            realImgSize = CGSize(width: imgViewSize.height / imageSize.height * imageSize.width, height: imgViewSize.height)
        }

        var frame = CGRect.zero
        frame.size = realImgSize
        mainImageView.frame = frame
        self.view.layoutIfNeeded()

        let screenSize  = scrollView.frame.size
        let offx = screenSize.width > realImgSize.width ? (screenSize.width - realImgSize.width) / 2 : 0
        let offy = screenSize.height > realImgSize.height ? (screenSize.height - realImgSize.height) / 2 : 0
        scrollView.contentInset = UIEdgeInsets(top: offy,
                                               left: offx,
                                               bottom: offy,
                                               right: offx)

        // The scroll view has zoomed, so you need to re-center the contents
        let scrollViewSize = scrollViewVisibleSize

        // First assume that image center coincides with the contents box center.
        // This is correct when the image is bigger than scrollView due to zoom
        var imageCenter = CGPoint(x: scrollView.contentSize.width / 2.0,
                                  y: scrollView.contentSize.height / 2.0)

        let center = scrollViewCenter

        //if image is smaller than the scrollView visible size - fix the image center accordingly
        if scrollView.contentSize.width < scrollViewSize.width {
            imageCenter.x = center.x
        }

        if scrollView.contentSize.height < scrollViewSize.height {
            imageCenter.y = center.y
        }

        mainImageView.center = imageCenter
    }
    
}
