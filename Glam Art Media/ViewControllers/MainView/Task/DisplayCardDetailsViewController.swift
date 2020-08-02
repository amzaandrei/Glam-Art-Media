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
            print(cardMainDataArr)
        }
    }
    
    var cardCheckLists: TrelloCardModelCheckLists! {
        didSet{
            print(cardCheckLists)
        }
    }
    
    var cardsMembersArr: TrelloCardModelMembers? = nil {
        didSet{
            if let membEx = cardsMembersArr, let avatarStr = membEx.avatarHash, let userId = membEx.id {
                TrelloServiceGet.sharedInstance.getTheImageFromAvatar(userId: userId, avatarStr: avatarStr) { (imgData, errStr) in
                    if errStr == nil{
                        guard let imgDataExt = imgData else { return }
                        DispatchQueue.main.async {
                            self.imageViewMembers.image = UIImage(data: imgDataExt)
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
        let image = UIImage(named: "bell")
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
        
        //FIXME: functia asta nu trebuie sa fie aici dar in Taskcontroller
//        addList(boardId: "5dd2acdeaeb5c58893100e2d")
        updateContentOfCard(cardId: "5dd57e2f54540f32c5369ebb")
    }
    
    func addConstraints(){
        NSLayoutConstraint.activate([
            imageViewMembers.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25),
            imageViewMembers.topAnchor.constraint(equalTo: view.topAnchor, constant: 25),
            imageViewMembers.heightAnchor.constraint(equalToConstant: 50),
            imageViewMembers.widthAnchor.constraint(equalToConstant: 50),
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
    
    func updateContentOfCard(cardId: String){
        
        let params: [String: String?] = [
            "name": "Integration",
            "desc": "moahaha"
        ]
        
        TrelloServiceUpdate.sharedInstance.updateCard(updateContent: params, cardId: cardId) { (res) in
            if res {
                print("content updated")
            }else {
                print("content not updated")
            }
        }
        
    }
    
}
