//
//  TrelloServiceUpdate.swift
//  Glam Art Media
//
//  Created by Amza Andrei on 8/2/20.
//  Copyright © 2020 Andrew. All rights reserved.
//

import Foundation
import Alamofire

class TrelloServiceUpdate: NSObject {
    
    static let sharedInstance = TrelloServiceUpdate()
    
    var params: Parameters = [
        "key": UserModelTrello.key,
        "token": UserModelTrello.token
    ]
    
    func updateCard(updateContent: [String: String?], cardId: String, completion: @escaping (Bool) -> ()){
        
        let baseUrl = "https://api.trello.com/1/cards/" + cardId
        
        updateContent.forEach { (k,v) in
            if v != nil {
                params[k] = v
            }
        }
        
        print(params)
        
        AF.request(baseUrl, method: .put, parameters: params).responseJSON { (response) in
            if let res = response.data {
                let verifiy = self.verifyResponseData(data: res)
                if verifiy.1 == true{
                    completion(true)
                }else{
                    completion(false)
                }
            }
        }
        
    }
    
}
