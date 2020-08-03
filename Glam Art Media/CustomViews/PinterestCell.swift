//
//  PinterestCell.swift
//  Glam Art Media
//
//  Created by Amza Andrei on 8/3/20.
//  Copyright © 2020 Andrew. All rights reserved.
//

import UIKit

class myCell: UICollectionViewCell{
    
    let myImage: UIImageView = {
        let image = UIImage()
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false;
        return imageView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(myImage)
        addConstraints()
    }
    
    func addConstraints(){
        NSLayoutConstraint.activate([
            myImage.rightAnchor.constraint(equalTo: self.rightAnchor),
            myImage.leftAnchor.constraint(equalTo: self.leftAnchor),
            myImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            myImage.topAnchor.constraint(equalTo: self.topAnchor),
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
