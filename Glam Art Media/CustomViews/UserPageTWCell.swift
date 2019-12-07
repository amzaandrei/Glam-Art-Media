//
//  UserPageTWCell.swift
//  Glam Art Media
//
//  Created by Andrew on 11/21/19.
//  Copyright © 2019 Andrew. All rights reserved.
//

import UIKit


class UserPageTWCell: UITableViewCell {
    
    let cellId = "cellId"
    
//    var imageName: String!{
//        didSet{
//            customImage.image = UIImage(named: imageName)
//        }
//    }
    
    let customImage: UIImageView = {
        let image = UIImage(systemName: "pencil", withConfiguration: UIImage.SymbolConfiguration(pointSize: 40))
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = true
        return imageView
    }()
    
    let customNameLabel: UILabel = {
        let text = UILabel()
        text.text = "Amza"
        text.translatesAutoresizingMaskIntoConstraints = false
        text.textColor = .black
        return text
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: cellId)
        self.addSubview(customImage)
        self.addSubview(customNameLabel)
        addConstraints()
    }
    
    func addConstraints(){
        NSLayoutConstraint.activate([
            customImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            customImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            customImage.heightAnchor.constraint(equalToConstant: 20),
            customImage.widthAnchor.constraint(equalToConstant: 20),
            customNameLabel.leftAnchor.constraint(equalTo: customImage.rightAnchor, constant: 15),
            customNameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
