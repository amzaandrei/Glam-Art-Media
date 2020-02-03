//
//  File.swift
//  Glam Art Media
//
//  Created by Andrew on 11/22/19.
//  Copyright © 2019 Andrew. All rights reserved.
//

import UIKit
import OAuthSwift
import Alamofire

class TaskController: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let boardsId = "boardsId"
    let listsId = "listsId"
    let cardsId = "cardsId"
    
    var boardsArr = [TrelloBoardModel]()
    var listsArr = [TrelloListModel]()
    var cardsArr = [TrelloCardModel]()
    var cardsChecklistsArr = [TrelloCardModelCheckLists]()
    var cardsMembersArr = [TrelloCardModelMembers]()
    
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
                
                self.addSubview(boardsCollectionView)
                self.addSubview(listsCollectionView)
                self.addSubview(cardsCollectionView)
                self.addSubview(profileImage)
                self.addSubview(userNameLabel)
//                self.addSubview(trelloLogInButt)
                addConstraints()
                requestBoards()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addConstraints(){
        
        NSLayoutConstraint.activate([
            profileImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            profileImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 70),
            profileImage.heightAnchor.constraint(equalToConstant: 30),
            profileImage.widthAnchor.constraint(equalToConstant: 30),
            userNameLabel.leftAnchor.constraint(equalTo: profileImage.rightAnchor, constant: 15),
            userNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 70),
            
            boardsCollectionView.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 30),
            boardsCollectionView.leftAnchor.constraint(equalTo: self.leftAnchor),
            boardsCollectionView.rightAnchor.constraint(equalTo: self.rightAnchor),
            boardsCollectionView.heightAnchor.constraint(equalToConstant: 30),
            
            listsCollectionView.topAnchor.constraint(equalTo: boardsCollectionView.bottomAnchor, constant: 30),
            listsCollectionView.leftAnchor.constraint(equalTo: self.leftAnchor),
            listsCollectionView.rightAnchor.constraint(equalTo: self.rightAnchor),
            listsCollectionView.heightAnchor.constraint(equalToConstant: 30),
            
            cardsCollectionView.topAnchor.constraint(equalTo: listsCollectionView.bottomAnchor, constant: 30),
            cardsCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            cardsCollectionView.leftAnchor.constraint(equalTo: self.leftAnchor),
            cardsCollectionView.rightAnchor.constraint(equalTo: self.rightAnchor),
            
//            trelloLogInButt.centerXAnchor.constraint(equalTo: self.centerXAnchor),
//            trelloLogInButt.centerYAnchor.constraint(equalTo: self.centerYAnchor),
//            trelloLogInButt.heightAnchor.constraint(equalToConstant: 50),
//            trelloLogInButt.widthAnchor.constraint(equalToConstant: 50)
            
        ])
        
    }
    
    @objc func logInTrello(){
        let config = URLSessionConfiguration.ephemeral
        config.waitsForConnectivity = true
        let urlStr = "https://trello.com/1/authorize?expiration=1day&name=MyPersonalToken&scope=read&response_type=token&key=" + UserModelTrelloAuth.consumerKey
        guard let url = URL(string: urlStr) else { return }
        UIApplication.shared.open(url)
        
        let paramaters: [String: String] = [
            "consumerKey": UserModelTrelloAuth.consumerKey,
            "consumerSecret": UserModelTrelloAuth.consumerSecret,
            "requestTokenUrl": "https://trello.com/1/OAuthGetRequestToken?scope=read,write,account&expiration=never&name=AppName",
            "authorizeUrl":    "https://trello.com/1/OAuthAuthorizeToken?scope=read,write,account&expiration=never&name=AppName",
            "accessTokenUrl":  "https://trello.com/1/OAuthGetAccessToken?scope=read,write,account&expiration=never&name=AppName",
            "callbackURL": "oauth-swift://oauth-callback/trello"
        ]
        
//        AF.request(urlStr, method: .post, parameters: paramaters).responseJSON { (response) in
//            print(response)
//        }
        
        let oauthswift = OAuth1Swift(
            consumerKey: UserModelTrelloAuth.consumerKey,
            consumerSecret: UserModelTrelloAuth.consumerSecret,
            requestTokenUrl: "https://trello.com/1/OAuthGetRequestToken?scope=read,write,account&expiration=never&name=AppName",
            authorizeUrl:    "https://trello.com/1/OAuthAuthorizeToken?scope=read,write,account&expiration=never&name=AppName",
            accessTokenUrl:  "https://trello.com/1/OAuthGetAccessToken?scope=read,write,account&expiration=never&name=AppName"
        )
        // authorize
        oauthswift.authorizeURLHandler = SafariURLHandler(viewController: MainController(), oauthSwift: oauthswift)
        let handle = oauthswift.authorize(
            withCallbackURL: URL(string: "oauth-swift://oauth-callback/trello")!) { result in
            switch result {
            case .success(let (credential, response, parameters)):
              print(credential.oauthToken)
              print(credential.oauthTokenSecret)
//                      print(parameters["user_id"])
              // Do your request
            case .failure(let error):
              print(error.localizedDescription)
            }
        }
        
        
    }
    
    func requestBoards(){
        TrelloServiceGet.sharedInstance.getBoardsRef { (res, data) in
            if res == nil, let dataEx = data {
                for (_, elemData) in dataEx.enumerated(){
                    let initi = TrelloBoardModel(dict: elemData)
                    print(initi.id)
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
        TrelloServiceGet.sharedInstance.getListRef(boardId: id) { (res, data) in
            if res == nil, let dataEx = data{
                for(_, elemData) in dataEx.enumerated(){
                    DispatchQueue.main.async {
                        self.listsCollectionView.delegate = self
                        self.listsCollectionView.dataSource = self
                        self.listsCollectionView.reloadData()
                    }
                    let initi = TrelloListModel(dict: elemData)
                    self.listsArr.append(initi)
                    print("list" + "\(initi.id)")
//                    self.requestAllCardsFromAList(id: initi.id)
                }
            }
        }
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
            let numberOfCells = floor(self.frame.size.width / self.cellWidth)
            edgeInsets = (self.frame.size.width - (numberOfCells * self.cellWidth)) / (numberOfCells + 1)
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
            let displayCardDetailed = DisplayCardDetailsViewController()
            displayCardDetailed.cardMainDataArr = cardsArr[indexPath.row]
            /// FIXME: Fatal error: Index out of range
//            displayCardDetailed.cardCheckLists = cardsChecklistsArr[indexPath.row]
            displayCardDetailed.cardsMembersArr = cardsMembersArr[indexPath.row]
            var topVC = UIApplication.shared.keyWindow?.rootViewController
            while((topVC!.presentedViewController) != nil) {
                 topVC = topVC!.presentedViewController
            }
            topVC?.present(displayCardDetailed, animated: true, completion: nil)
            print(indexPath.row)
        }
    }
    
    
    func requestAllCardsFromAList(id: String){
        self.cardsArr.removeAll()
        TrelloServiceGet.sharedInstance.getCardsRef(listId: id) { (res, data) in
                    if res == nil, let dataEx = data{
                        for(index, _) in dataEx.enumerated(){
//                            print("cards" + "\(dataEx[index]["id"])")
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
        TrelloServiceGet.sharedInstance.geTheMembersOfaCard(cardId: cardId) { (res, data) in
            if res == nil, let dataEx = data {
                for(_, elem) in dataEx.enumerated(){
                    let membersData = TrelloCardModelMembers(dict: elem)
                    self.cardsMembersArr.append(membersData)
                }
            }
        }
    }
    
    func requestAllContesCards(id: String){
        TrelloServiceGet.sharedInstance.getCheckLists(cardId: id) { (res, data) in
            if res == nil, let dataEx = data{
                for(index, _) in dataEx.enumerated(){
//                    print(dataEx[index]["name"])
                    
                    var cardListItemArr = [TrelloCardModelCheckListsItems]()
                    cardListItemArr.removeAll()
                    for cardListItem in dataEx[index]["checkItems"] as! [[String : Any]]{
                        let cardListItem = TrelloCardModelCheckListsItems(dict:  cardListItem )
                        cardListItemArr.append(cardListItem)
                    }
                    let cardCheckListData = TrelloCardModelCheckLists(dict: dataEx[index], cardListItemArr)
                    self.cardsChecklistsArr.append(cardCheckListData)
                }
            }else if res != nil{
                print(res)
            }
        }
    }
    
}
