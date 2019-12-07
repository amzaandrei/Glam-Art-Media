//
//  TaskControllerCell.swift
//  Glam Art Media
//
//  Created by Andrew on 11/22/19.
//  Copyright © 2019 Andrew. All rights reserved.
//

import UIKit

class TaskControllerListsCell: UICollectionViewCell {
    
    let listLabel: UILabel = {
        let text = UILabel()
        text.text = "Amza"
        text.translatesAutoresizingMaskIntoConstraints = false
        text.textColor = .black
        return text
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(listLabel)
        addConstraints()
    }
    
    func addConstraints(){
        
        NSLayoutConstraint.activate([
            listLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15),
            listLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 15)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
