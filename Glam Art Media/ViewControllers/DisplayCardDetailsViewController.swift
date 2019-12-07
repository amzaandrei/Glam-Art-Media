//
//  DislayCardDetailsViewController.swift
//  Glam Art Media
//
//  Created by Andrew on 12/6/19.
//  Copyright © 2019 Andrew. All rights reserved.
//

import UIKit

class DisplayCardDetailsViewController: UIViewController {
    
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
    
    let activityHour: UILabel = {
        let label = UILabel()
        label.text = "cardName"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let imageViewMembers: UIImageView = {
        let image = UIImage()
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        view.addSubview(cardName)
        view.addSubview(cardDescriptionName)
        view.addSubview(cardDate)
        view.addSubview(activityHour)
        view.addSubview(imageViewMembers)
        
        addConstraints()
    }
    
    func addConstraints(){
        NSLayoutConstraint.activate([
            
        ])
    }
    
}
