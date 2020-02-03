//
//  DislayCardDetailsViewController.swift
//  Glam Art Media
//
//  Created by Andrew on 12/6/19.
//  Copyright © 2019 Andrew. All rights reserved.
//

import UIKit

class DisplayCardDetailsViewController: UIViewController {
    
    var cardMainDataArr: TrelloCardModel! {
        didSet{
            
        }
    }
    
    var cardCheckLists: TrelloCardModelCheckLists! {
        didSet{
        }
    }
    
    var cardsMembersArr: TrelloCardModelMembers? = nil {
        didSet{
            if let membEx = cardsMembersArr {
                if let avatarStr = membEx.avatarHash{
                    TrelloServiceGet.sharedInstance.getTheImageFromAvatar(avatarStr: avatarStr) { (imgData, errStr) in
                        if errStr == nil{
                            print(imgData)
                        }
                    }
                }
            }
        }
    }
    
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
//        createNewCard(listId: "5dd2c24f1c05905123bf3940")
//        deleteCard(cardId: "5df53580acd7e81d287e6904")
        
        /// FIXME: functia asta nu trebuie sa fie aici dar in Taskcontroller
        addList(boardId: "5dd2acdeaeb5c58893100e2d")
    }
    
    func addConstraints(){
        NSLayoutConstraint.activate([
            
        ])
    }
    
    func createNewCard(listId: String){
        let params: [String: String] = [
            "name": "LogIn",
            "desc": "Best description ever",
            "post": "top",
            "idList": listId
        ]
        TrelloServicePost.sharedInstance.postCard(postDict: params, completion: { (response) in
            if response {
                print("created Card")
            }else{
                print("not created Card")
            }
        })
    }
    
    func deleteCard(cardId: String){
        TrelloServiceDelete.sharedInstance.deleteCard(cardId: cardId, completion: { (response) in
            if response {
                print("deleted card")
            }else{
                print("not deleted Card")
            }
        })
    }
    
    func addList(boardId: String){
        
        let params: [String: String] = [
            "name": "New List",
            "idBoard": boardId,
            "pos": "top"
        ]
        
        TrelloServicePost.sharedInstance.postList(postDict: params) { (response) in
            if response {
                print("created list")
            }else{
                print("not created list")
            }
        }
        
    }
    
}
