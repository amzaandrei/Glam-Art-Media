//
//  UploaderImagePage.swift
//  Glam Art Media
//
//  Created by Amza Andrei on 8/3/20.
//  Copyright © 2020 Andrew. All rights reserved.
//

import UIKit

class UploaderImagePage: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDragDelegate, UICollectionViewDelegateFlowLayout, PinterestLayoutDelegate {
    
    
    private let cellId = "cellId"
    
    let photos = [UIImage(named: "01"),UIImage(named: "02"),UIImage(named: "03"),UIImage(named: "04"),UIImage(named: "05"),UIImage(named: "06"),UIImage(named: "07"),UIImage(named: "08"),UIImage(named: "09"),UIImage(named: "10")]
    
    lazy var collectionView: UICollectionView = {
        let layout = PinterestLayout()
        let myColll = UICollectionView(frame: .zero, collectionViewLayout: layout)
        myColll.delegate = self
        myColll.alwaysBounceVertical = false
        myColll.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        myColll.dataSource = self
        myColll.register(myCell.self, forCellWithReuseIdentifier: cellId)
        myColll.translatesAutoresizingMaskIntoConstraints = false
        myColll.backgroundColor = .white
        return myColll
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        view.addSubview(collectionView)
        if let layout = collectionView.collectionViewLayout as? PinterestLayout{
            layout.delegate = self
        }
        collectionView.frame = view.bounds
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! myCell
        cell.myImage.image = photos[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        var height: CGFloat!
        let images = photos[indexPath.row]
        height = images!.size.height
        return height
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = (collectionView.frame.width - (self.collectionView.contentInset.left + self.collectionView.contentInset.right + 10)) / 2
      return CGSize(width: itemSize, height: itemSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! myCell

        guard let image = cell.myImage.image else { return [] }
//        imageDragged = image
        let provider = NSItemProvider(object: image)
        let item = UIDragItem(itemProvider: provider)
        item.localObject = image
        item.previewProvider = {
            let frame: CGRect
            if image.size.width > image.size.height {
                let multiplier = cell.frame.width / image.size.width
                frame = CGRect(x: 0, y: 0, width: cell.frame.width, height: image.size.height * multiplier)
            } else {
                let multiplier = cell.frame.height / image.size.height
                frame = CGRect(x: 0, y: 0, width: image.size.width * multiplier, height: cell.frame.height)
            }

            let previewImageView = UIImageView(image: image)

            previewImageView.contentMode = .scaleAspectFit
            previewImageView.frame = frame

            return UIDragPreview(view: previewImageView, parameters: UIDragPreviewParameters())

        }
        return [item]

    }

}
