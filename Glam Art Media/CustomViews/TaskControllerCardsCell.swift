//
//  TaskControllerCardsCell.swift
//  Glam Art Media
//
//  Created by Andrew on 12/5/19.
//  Copyright © 2019 Andrew. All rights reserved.
//

import UIKit

class TaskControllerCardsCell: UICollectionViewCell {
    
    let cardName: UILabel = {
        let label = UILabel()
        label.text = "cardName"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let cardDescriptionName: UITextView = {
        let text = UITextView()
        text.text = "asdasdasdasdasdasdadasadsasds"
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    let cardDate: UILabel = {
        let label = UILabel()
        label.text = "cardName"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let cardHour: UILabel = {
        let label = UILabel()
        label.text = "cardName"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(cardName)
        self.addSubview(cardDescriptionName)
        self.addSubview(cardDate)
        self.addSubview(cardHour)
        addConstraints()
    }
    
    func addConstraints(){
        
        NSLayoutConstraint.activate([
            
            cardName.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 30),
            cardName.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            
            cardDescriptionName.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 30),
            cardDescriptionName.topAnchor.constraint(equalTo: self.cardName.bottomAnchor, constant: 20),
            cardDescriptionName.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -30),
            cardDescriptionName.heightAnchor.constraint(equalToConstant: 40),
            
            cardDate.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 30),
            cardDate.topAnchor.constraint(equalTo: self.cardDescriptionName.bottomAnchor, constant: 20),
            
            cardHour.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            cardHour.topAnchor.constraint(equalTo: self.topAnchor, constant: 20)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
