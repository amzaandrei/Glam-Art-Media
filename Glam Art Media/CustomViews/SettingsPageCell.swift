//
//  SettingPageCell.swift
//  Glam Art Media
//
//  Created by Amza Andrei on 8/2/20.
//  Copyright © 2020 Andrew. All rights reserved.
//

import UIKit

class SettingsPageCell: UITableViewCell {
    
    var cellActivate: Bool! {
        didSet {
            if cellActivate == true{
                self.textField.removeFromSuperview()
                self.addImageViewConstraints()
            }else{
                self.logoImageView.removeFromSuperview()
                self.addTextFieldConstraints()
            }
        }
    }
    
    let logoImageView: UIImageView = {
        let image = LetterImageGenerator.imageWith(name: "Andrei Amza")
        let imageView = UIImageView(image: image)
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let customLabel: UILabel = {
        let l = UILabel()
        l.text = "hah"
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let textField: UITextField = {
        let t = UITextField()
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "cellId")
        self.addSubview(customLabel)
        self.addSubview(logoImageView)
        self.addSubview(textField)

        self.addLabelConstraints()
    }
    
    
    fileprivate func addLabelConstraints(){
        NSLayoutConstraint.activate([
            customLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            customLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10)
        ])
    }
    
    fileprivate func addImageViewConstraints(){
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: customLabel.bottomAnchor, constant: 5),
            logoImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            logoImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 100),
            logoImageView.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    fileprivate func addTextFieldConstraints(){
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: customLabel.bottomAnchor, constant: 5),
            textField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            textField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 10)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

