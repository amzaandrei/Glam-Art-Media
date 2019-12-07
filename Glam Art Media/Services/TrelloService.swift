//
//  TrelloService.swift
//  Glam Art Media
//
//  Created by Andrew on 11/22/19.
//  Copyright © 2019 Andrew. All rights reserved.
//

import Foundation
import Alamofire

class TrelloService: NSObject {
    
    static let sharedInstance = TrelloService()
    typealias JSONStandard = [String: AnyObject]
    
    let params: Parameters = [
        "key": UserModelTrello.key,
        "token": UserModelTrello.token
    ]
    
    func getBoardsRef(completion: @escaping (String?, [JSONStandard]?) -> ()){
        
//        guard let url = URL(string: urlStr) else { return }
        
        let boardString = "https://api.trello.com/1/members/me/boards?"
        
        AF.request(boardString, method: .get, parameters: params).responseJSON { (response) in
            if let dataEx = response.data{
                do{
                    let parsedData = try JSONSerialization.jsonObject(with: dataEx, options: .mutableContainers) as? [JSONStandard]
                    completion(nil, parsedData)
                }catch let errCat{
                    completion(errCat.localizedDescription, nil)
                    return
                }
            }
        }
        
    }
    
    
    func getListRef(boardId: String, completion: @escaping (String?, [JSONStandard]?) -> ()){
        
        let boardsString = "https://api.trello.com/1/boards/" + boardId + "/" + "lists?"
        
        AF.request(boardsString, method: .get, parameters: params).responseJSON { (response) in
            if let dataEx = response.data{
                do{
                    let parsedData = try JSONSerialization.jsonObject(with: dataEx, options: .mutableContainers) as? [JSONStandard]
                    completion(nil, parsedData)
                }catch let errCat{
                    completion(errCat.localizedDescription, nil)
                    return
                }
            }
        }
    }
    
    func getCardsRef(listId: String, completion: @escaping (String?, [JSONStandard]?) -> ()){
        
        let listsString = "https://api.trello.com/1/lists/" + listId + "/" + "cards?"
        
        AF.request(listsString, method: .get, parameters: params).responseJSON { (response) in
            if let dataEx = response.data{
                do{
                    let parsedData = try JSONSerialization.jsonObject(with: dataEx, options: .mutableContainers) as? [JSONStandard]
                    completion(nil, parsedData)
                }catch let errCat{
                    completion(errCat.localizedDescription, nil)
                    return
                }
            }
        }
    }
    
    func getCheckLists(cardId: String, completion: @escaping (String?, [JSONStandard]?) -> ()){
        
        let cardParams: Parameters = [
            "checkItems": "all",
            "checkItem_fields": "name,nameData,pos,state",
            "filter": "all",
            "fields": "all",
            "key": UserModelTrello.key,
            "token": UserModelTrello.token
        ]
        
        let checkLists = "https://api.trello.com/1/cards/" + cardId + "/checklists?"
        
        AF.request(checkLists, method: .get, parameters:  cardParams).responseJSON { (response) in
            if let dataEx = response.data{
                do{
                    let parsedData = try JSONSerialization.jsonObject(with: dataEx, options: .mutableContainers) as? [JSONStandard]
                    completion(nil, parsedData)
                }catch let errCat{
                    completion(errCat.localizedDescription, nil)
                    return
                }
            }
        }
        
    }
    
    func geTheMembersOfaCard(cardId: String, completion: @escaping (String?, [JSONStandard]?) -> ()){
        
        let membersLists = "https://api.trello.com/1/cards/" + cardId + "/members?"
        
        let membersParams: Parameters = [
            "fields": "avatarHash,fullName,initials,username",
            "key": UserModelTrello.key,
            "token": UserModelTrello.token
        ]
        
        AF.request(membersLists, method: .get, parameters:  membersParams).responseJSON { (response) in
            if let dataEx = response.data{
                do{
                    let parsedData = try JSONSerialization.jsonObject(with: dataEx, options: .mutableContainers) as? [JSONStandard]
                    completion(nil, parsedData)
                }catch let errCat{
                    completion(errCat.localizedDescription, nil)
                    return
                }
            }
        }
        
    }
    
}
