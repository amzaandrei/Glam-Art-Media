//
//  File.swift
//  Glam Art Media
//
//  Created by Andrew on 11/22/19.
//  Copyright © 2019 Andrew. All rights reserved.
//

import UIKit
import OAuthSwift

class TaskController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let boardsId = "boardsId"
    let listsId = "listsId"
    let cardsId = "cardsId"
    
    var boardsArr = [TrelloBoardModel]()
    var listsArr = [TrelloListModel]()
    var cardsArr = [TrelloCardModel]()
    
    lazy var boardsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let coll = UICollectionView(frame: .zero, collectionViewLayout: layout)
        coll.register(TaskControllerBoardsCell.self, forCellWithReuseIdentifier: boardsId)
        coll.backgroundColor = .clear
        coll.translatesAutoresizingMaskIntoConstraints = false
        coll.showsHorizontalScrollIndicator = false
        return coll
    }()
    
    lazy var listsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let coll = UICollectionView(frame: .zero, collectionViewLayout: layout)
        coll.register(TaskControllerListsCell.self, forCellWithReuseIdentifier: listsId)
        coll.backgroundColor = .clear
        coll.translatesAutoresizingMaskIntoConstraints = false
        coll.showsHorizontalScrollIndicator = false
        return coll
    }()
    
    lazy var cardsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let coll = UICollectionView(frame: .zero, collectionViewLayout: layout)
        coll.register(TaskControllerCardsCell.self, forCellWithReuseIdentifier: cardsId)
        coll.backgroundColor = .clear
        coll.translatesAutoresizingMaskIntoConstraints = false
        coll.showsHorizontalScrollIndicator = false
        return coll
        }()
    
    let profileImage: UIImageView = {
        let image = UIImage(systemName: "pencil")
        let imageView = UIImageView(image: image)
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let userNameLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Amza"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    let trelloLogInButt: UIButton = {
        let btt = UIButton(type: .system)
        btt.setTitle("LogIn", for: .normal)
        btt.addTarget(self, action: #selector(logInTrello), for: .touchUpInside)
        btt.translatesAutoresizingMaskIntoConstraints = false
        return btt
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        
        view.addSubview(boardsCollectionView)
        view.addSubview(listsCollectionView)
        view.addSubview(cardsCollectionView)
        view.addSubview(profileImage)
        view.addSubview(userNameLabel)
//        view.addSubview(trelloLogInButt)
        addConstraints()
        requestBoards()
        
    }
    
    func addConstraints(){
        
        NSLayoutConstraint.activate([
            profileImage.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20),
            profileImage.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 70),
            profileImage.heightAnchor.constraint(equalToConstant: 30),
            profileImage.widthAnchor.constraint(equalToConstant: 30),
            userNameLabel.leftAnchor.constraint(equalTo: profileImage.rightAnchor, constant: 15),
            userNameLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 70),
            
            boardsCollectionView.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 30),
            boardsCollectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            boardsCollectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            boardsCollectionView.heightAnchor.constraint(equalToConstant: 30),
            
            listsCollectionView.topAnchor.constraint(equalTo: boardsCollectionView.bottomAnchor, constant: 30),
            listsCollectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            listsCollectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            listsCollectionView.heightAnchor.constraint(equalToConstant: 30),
            
            cardsCollectionView.topAnchor.constraint(equalTo: listsCollectionView.bottomAnchor, constant: 30),
            cardsCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            cardsCollectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            cardsCollectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
//            cardsCollectionView.heightAnchor.constraint(equalToConstant: 200)
            
//            trelloLogInButt.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            trelloLogInButt.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            trelloLogInButt.heightAnchor.constraint(equalToConstant: 50),
//            trelloLogInButt.widthAnchor.constraint(equalToConstant: 50)
            
        ])
        
    }
    
    @objc func logInTrello(){
        let urlStr = "https://trello.com/1/authorize?expiration=1day&name=MyPersonalToken&scope=read&response_type=token&key=" + UserModelTrelloAuth.consumerKey
        guard let url = URL(string: urlStr) else { return }
        UIApplication.shared.open(url)
        
//        let oauthswift = OAuth1Swift(
//            consumerKey: UserModelTrelloAuth.consumerKey,
//            consumerSecret: UserModelTrelloAuth.consumerSecret,
//            requestTokenUrl: "https://trello.com/1/OAuthGetRequestToken",
//            authorizeUrl:    "https://trello.com/1/OAuthAuthorizeToken",
//            accessTokenUrl:  "https://trello.com/1/OAuthGetAccessToken"
//        )
//        // authorize
//        let handle = oauthswift.authorize(
//            withCallbackURL: URL(string: "oauth-swift://oauth-callback/twitter")!) { result in
//            switch result {
//            case .success(let (credential, response, parameters)):
//              print(credential.oauthToken)
//              print(credential.oauthTokenSecret)
////                      print(parameters["user_id"])
//              // Do your request
//            case .failure(let error):
//              print(error.localizedDescription)
//            }
//        }
//        oauthswift.authorizeURLHandler = SafariURLHandler(viewController: self, oauthSwift: oauthswift)
        
    }
    
    func requestBoards(){
        TrelloService.sharedInstance.getBoardsRef { (res, data) in
            if res == nil, let dataEx = data {
                for (_, elemData) in dataEx.enumerated(){
                    let initi = TrelloBoardModel(dict: elemData)
                    self.boardsArr.append(initi)
                    DispatchQueue.main.async {
                        self.boardsCollectionView.delegate = self
                        self.boardsCollectionView.dataSource = self
                        self.boardsCollectionView.reloadData()
                    }
                }
            }
        }
    }
    
    func requestListsFromBoards(id: String){
        TrelloService.sharedInstance.getListRef(boardId: id) { (res, data) in
            if res == nil, let dataEx = data{
                for(_, elemData) in dataEx.enumerated(){
                    DispatchQueue.main.async {
                        self.listsCollectionView.delegate = self
                        self.listsCollectionView.dataSource = self
                        self.listsCollectionView.reloadData()
                    }
                    let initi = TrelloListModel(dict: elemData)
                    self.listsArr.append(initi)
//                    self.requestAllCardsFromAList(id: initi.id)
                }
                self.refreshUI()
            }
        }
    }
    
    
    func refreshUI(){
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.boardsCollectionView{
            return self.boardsArr.count
        }else if collectionView == self.listsCollectionView{
            return self.listsArr.count
        }else{
            return self.cardsArr.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.boardsCollectionView{
            let boardData = boardsArr[indexPath.row]
            let cellB = boardsCollectionView.dequeueReusableCell(withReuseIdentifier: boardsId, for: indexPath) as! TaskControllerBoardsCell
            cellB.backgroundColor = .red
            cellB.configure()
            cellB.boardLabel.text = boardData.name
            return cellB
        }else if collectionView == self.listsCollectionView{
            let listData = listsArr[indexPath.row]
            let cellL = listsCollectionView.dequeueReusableCell(withReuseIdentifier: listsId, for: indexPath) as! TaskControllerListsCell
            cellL.backgroundColor = .blue
            cellL.listLabel.text = listData.name
            return cellL
        }else {
            let cardData = cardsArr[indexPath.row]
            let cellc = cardsCollectionView.dequeueReusableCell(withReuseIdentifier: cardsId, for: indexPath) as! TaskControllerCardsCell
            cellc.backgroundColor = .green
            cellc.cardName.text = cardData.name
            cellc.cardDescriptionName.text = cardData.description
            if let dateData = convertDataToTime(dateStr: cardData.dateLastActivity){
                cellc.cardHour.text = "\(dateData["hour"]!)" + ":" + "\(dateData["minute"]!)"
                cellc.cardDate.text = "\(dateData["day"]!)" + " " + "\(findTheMonthStringFromInt(dateData["month"]!))"
            }
            return cellc
        }
    }
    
    func convertDataToTime(dateStr: String) -> [String: Int]?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z"
        var comp = DateComponents()
        guard let date = dateFormatter.date(from: dateStr) else { return nil }
        comp.hour = Calendar.current.component(.hour, from: date)
        comp.minute = Calendar.current.component(.minute, from: date)
        comp.month = Calendar.current.component(.month, from: date)
        comp.day = Calendar.current.component(.day, from: date)
        
        let allTimes : [String: Any] = [
            "hour": comp.hour!,
            "minute": comp.minute!,
            "month": comp.month!,
            "day": comp.day!
        ]
        return allTimes as! [String : Int]
    }
    
    func findTheMonthStringFromInt(_ monthNr: Int) -> String{
        
        var val: String!
        
        switch (monthNr) {
            case 1: val = "Ianuarie"; break
            case 2: val = "Februarie"; break
            case 3: val = "Martie"; break
            case 4: val = "Aprilie"; break
            case 5: val = "Mai"; break
            case 6: val = "Iunie"; break
            case 7: val = "Iulie"; break
            case 8: val = "August"; break
            case 9: val = "Septembrie"; break
            case 10: val = "Octombrie"; break
            case 11: val = "Noiembrie"; break
            case 12: val = "Decembrie"; break
            default: break
        }
        return val
    }
    
    var cellWidth: CGFloat = 280
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.boardsCollectionView{
            return CGSize(width: 100, height: 30)
        }else if collectionView == self.listsCollectionView{
            return CGSize(width: 100, height: 30)
        }else{
            return CGSize(width: cellWidth, height: 200)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        var edgeInsets: CGFloat = 0
        
        if collectionView == self.cardsCollectionView{
            let numberOfCells = floor(self.view.frame.size.width / self.cellWidth)
            edgeInsets = (self.view.frame.size.width - (numberOfCells * self.cellWidth)) / (numberOfCells + 1)
        }
        
        return UIEdgeInsets(top: 0, left: edgeInsets, bottom: 0, right: edgeInsets)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.boardsCollectionView{
            let boardData = boardsArr[indexPath.row]
            listsArr.removeAll()
            self.requestListsFromBoards(id: boardData.id)
            print(indexPath.row)
        }else if collectionView == self.listsCollectionView{
            let listData = listsArr[indexPath.row]
            self.requestAllCardsFromAList(id: listData.id)
            print(indexPath.row)
        }else{
            let cardData = cardsArr[indexPath.row]
            let displayCardDetailed = DisplayCardDetailsViewController()
            self.present(displayCardDetailed, animated: true, completion: nil)
            print(indexPath.row)
        }
    }
    
    
    func requestAllCardsFromAList(id: String){
        self.cardsArr.removeAll()
        TrelloService.sharedInstance.getCardsRef(listId: id) { (res, data) in
                    if res == nil, let dataEx = data{
                        for(index, _) in dataEx.enumerated(){
                            print(dataEx[index]["id"])
                            let card = TrelloCardModel(dict: dataEx[index])
                            self.cardsArr.append(card)
                            self.requestMembersCard(cardId: card.id)
                            self.cardsCollectionView.delegate = self
                            self.cardsCollectionView.dataSource = self
                            DispatchQueue.main.async {
                                self.cardsCollectionView.reloadData()
                            }
                            self.requestAllContesCards(id: card.id)
                        }
                    }
                }
        }
    
    func requestMembersCard(cardId: String){
        TrelloService.sharedInstance.geTheMembersOfaCard(cardId: cardId) { (res, data) in
            if res == nil, let dataEx = data {
                for(index, _) in dataEx.enumerated(){
                    print(dataEx)
                }
            }else{
                print(res)
            }
        }
    }
    
    func requestAllContesCards(id: String){
        TrelloService.sharedInstance.getCheckLists(cardId: id) { (res, data) in
            if res == nil, let dataEx = data{
                for(index, _) in dataEx.enumerated(){
                    print(dataEx[index]["name"])
                    
//                    let cardData = TrelloCardModelCheckLists(dict: dataEx[index], dataEx[index]["checkItems"] as! [TrelloCardModelCheckListsItems])
                }
            }else if res != nil{
                print(res)
            }
        }
    }
    
}
