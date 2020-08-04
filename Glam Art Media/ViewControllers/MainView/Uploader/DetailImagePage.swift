//
//  DetailImagePage.swift
//  Glam Art Media
//
//  Created by Amza Andrei on 8/5/20.
//  Copyright © 2020 Andrew. All rights reserved.
//

import UIKit
import Hero

class DetailImagePage: UIViewController {
    
    var img: UIImage! = nil {
        didSet{
            self.imageView.image = img
        }
    }
    
    var imgId: String! = nil {
        didSet{
            self.imageView.hero.id = imgId
        }
    }
    
    let imageView: UIImageView = {
        let image = UIImage(named: "bell")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        self.hero.isEnabled = true
        view.addSubview(imageView)
        imageView.frame = view.bounds
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(dismissView))
        view.addGestureRecognizer(panGesture)
    }
    
    @objc func dismissView(sender: UIPanGestureRecognizer){
        let transation = sender.translation(in: nil)
        let progress = transation.y / 2 / view.frame.height
        switch sender.state {
        case .began:
            hero.dismissViewController()
        case .changed:
            Hero.shared.update(progress)
            
            let currentPos = CGPoint(x: transation.x + imageView.center.x, y: transation.y + imageView.center.y)
            Hero.shared.apply(modifiers: [.position(currentPos)], to: imageView)
            
        default:
            if progress + sender.velocity(in: nil).y / view.bounds.height > 0.2{
                Hero.shared.finish()
            }else{
                Hero.shared.cancel()
            }
        }
    }
    
}
