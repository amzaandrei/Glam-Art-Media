//
//  TrelloServicePush.swift
//  Glam Art Media
//
//  Created by Andrew on 12/12/19.
//  Copyright © 2019 Andrew. All rights reserved.
//

import Foundation
import Alamofire

class TrelloServicePost: NSObject {
    
    static let sharedInstance = TrelloServicePost()
    
    func postCard(postDict: [String: String], completion: @escaping (Bool) -> ()) {
        
        let postUrl = "https://api.trello.com/1/cards?"
        
        let params: Parameters = [
            "name": postDict["name"]!,
            "desc": postDict["desc"]!,
            "post": postDict["post"]!,
            "idList": postDict["idList"]!,
            "key": UserModelTrello.key,
            "token": UserModelTrello.token
        ]
        
        
        AF.request(postUrl, method: .post, parameters: params).responseJSON { (response) in
            if let dataEx = response.data{
                let verify = self.verifyResponseData(data: dataEx)
                if verify.1 == true{
                    completion(true)
                }else{
                    completion(false)
                }
            }
        }
    }
    
    func postList(postDict: [String: String], completion: @escaping (Bool) -> ()) {
        
        let postUrl = "https://api.trello.com/1/lists?"
        
        let params: Parameters = [
            "name": postDict["name"]!,
            "idBoard": postDict["idBoard"]!,
            "pos": postDict["pos"]!,
            "key": UserModelTrello.key,
            "token": UserModelTrello.token
        ]
        
        AF.request(postUrl, method: .post, parameters: params).responseJSON { (response) in
            if let dataEx = response.data{
                let verify = self.verifyResponseData(data: dataEx)
                if verify.1 == true{
                    completion(true)
                }else{
                    completion(false)
                }
            }
        }
        
    }
    
}
