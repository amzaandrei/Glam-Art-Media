//
//  TrelloServiceDelete.swift
//  Glam Art Media
//
//  Created by Andrew on 12/14/19.
//  Copyright © 2019 Andrew. All rights reserved.
//

import Foundation
import Alamofire

class TrelloServiceDelete: NSObject {
    
    static var sharedInstance = TrelloServiceDelete()
    
    func deleteCard(cardId: String, completion: @escaping (Bool) -> ()){
        
        let deleteUrl = "https://api.trello.com/1/cards/" + cardId + "?"
        
        let params: Parameters = [
            "key": UserModelTrello.key,
            "token": UserModelTrello.token
        ]
        
        AF.request(deleteUrl, method: .delete, parameters: params).responseJSON { (response) in
            if let dataEx = response.data{
                let verify = self.verifyResponseData(data: dataEx)
                if verify.1 == true{
                    print("deleted")
                    completion(true)
                }else{
                    print("nondeleted")
                    completion(false)
                }
            }
        }
        
    }
    
}
