//
//  TaskControllerBoardsCell.swift
//  Glam Art Media
//
//  Created by Andrew on 11/24/19.
//  Copyright © 2019 Andrew. All rights reserved.
//

import UIKit

class TaskControllerBoardsCell: UICollectionViewCell {
    
    let boardLabel: UILabel = {
        let text = UILabel()
        text.text = "Amza"
        text.translatesAutoresizingMaskIntoConstraints = false
        text.textColor = .black
        return text
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(boardLabel)
        addConstraints()
    }
    
    func configure(){
        contentView.layer.cornerRadius = 15
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.clear.cgColor
        contentView.layer.masksToBounds = true
        self.contentView.frame = self.bounds
        self.layoutIfNeeded()

        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2.0)
        layer.shadowRadius = 2.0
        layer.shadowOpacity = 0.5
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
    }
    
    func addConstraints(){
        
        NSLayoutConstraint.activate([
            boardLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            boardLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
