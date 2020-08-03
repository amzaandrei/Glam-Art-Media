//
//  SettingPageCell.swift
//  Glam Art Media
//
//  Created by Amza Andrei on 8/2/20.
//  Copyright © 2020 Andrew. All rights reserved.
//

import UIKit

protocol PrefixDelegate {
    func prefixBoxTapped(cell: SettingsPageCell)
}

class SettingsPageCell: UITableViewCell, UITextFieldDelegate {
    
    enum cellType {
        case LOGO
        case TEXTFIELD
        case PHONEPREFIX
    }
    
    var cellActivate: cellType! {
        didSet {
            if cellActivate == cellType.LOGO{
                self.textField.removeFromSuperview()
                self.addImageViewConstraints()
            }else if cellActivate == cellType.TEXTFIELD {
                self.logoImageView.removeFromSuperview()
                self.addTextFieldConstraints()
            }else if cellActivate == cellType.PHONEPREFIX{
                self.textField.removeFromSuperview()
                self.logoImageView.removeFromSuperview()
                self.addPhonePrefixConstraints()
            }
        }
    }
    
    var prefixBoxDelegate: PrefixDelegate?
    
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
    
    let prefixPhoneBox: UIView = {
        let box = UIView()
        box.backgroundColor = .gray
        box.translatesAutoresizingMaskIntoConstraints = false
        box.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(boxTapped)))
        box.isUserInteractionEnabled = true
        return box
    }()
    
    let prefixLabel: UILabel = {
        let label = UILabel()
        label.text = "+1"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(boxTapped)))
        label.isUserInteractionEnabled = true
        return label
    }()
    
    let arrowImage: UIImageView = {
        let image = UIImage(systemName: "chevron.down")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(boxTapped)))
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "cellId")
        self.addSubview(customLabel)
        self.addSubview(logoImageView)
        self.addSubview(textField)
        self.addSubview(prefixPhoneBox)
        
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
    
    fileprivate func addPhonePrefixConstraints(){
        
        NSLayoutConstraint.activate([
            prefixPhoneBox.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15),
            prefixPhoneBox.topAnchor.constraint(equalTo: customLabel.bottomAnchor, constant: 3),
            prefixPhoneBox.heightAnchor.constraint(equalToConstant: 20),
            prefixPhoneBox.widthAnchor.constraint(equalToConstant: 70)
        ])
        
        prefixPhoneBox.addSubview(prefixLabel)
        prefixPhoneBox.addSubview(arrowImage)
        
        NSLayoutConstraint.activate([
            prefixLabel.leftAnchor.constraint(equalTo: prefixPhoneBox.leftAnchor, constant: 3),
            prefixLabel.centerYAnchor.constraint(equalTo: prefixPhoneBox.centerYAnchor),
            arrowImage.rightAnchor.constraint(equalTo: prefixPhoneBox.rightAnchor, constant: -3),
            arrowImage.centerYAnchor.constraint(equalTo: prefixPhoneBox.centerYAnchor),
            arrowImage.heightAnchor.constraint(equalToConstant: 20),
            arrowImage.widthAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    @objc func boxTapped(){
        prefixBoxDelegate?.prefixBoxTapped(cell: self)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

