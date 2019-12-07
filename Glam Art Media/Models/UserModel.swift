//
//  UserModel.swift
//  Glam Art Media
//
//  Created by Andrew on 11/20/19.
//  Copyright © 2019 Andrew. All rights reserved.
//

import Foundation

struct UserModelTrelloAuth {
    static var consumerKey = "17e33135808a6c9392013c13aa379e41"
    static var consumerSecret = "d3c9ba844715d74e492f5cd76f0b730cdd895cc50879e7de840d021584ce6f28"
}

struct UserModelOxebox {
    
    static var partnerId = "OBP-GLAMAR113-ROM-RO"
    static var authKey = "1TYWjP3XFcvi6pStrDGJAE2Q7OV5ZUK0Lk4xfbgmzNuHBalC"
    
}

struct UserModelTrello {
    
    static var key = "17e33135808a6c9392013c13aa379e41"
    static var token = "80fdd58ddb7e8b75a369f17481f8d0e7e8fb6dfa5b5cff2983c9aec86d77cc5d"
}


struct UserModel {
    
    var email: String!
    var firstName: String!
    var lastName: String!
    var profileImageUrl: String!
    
    init(dict: [String: Any]) {
        self.email = dict["email"] as? String
        self.firstName = dict["firstName"] as? String
        self.lastName = dict["lastName"] as? String
        self.profileImageUrl = dict["profileImageUrl"] as? String
    }
    
}
