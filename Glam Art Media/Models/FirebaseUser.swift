//
//  FireabaseUser.swift
//  Glam Art Media
//
//  Created by Amza Andrei on 8/2/20.
//  Copyright © 2020 Andrew. All rights reserved.
//

import Foundation

struct FirebaseUser {
    
    var firstName: String!
    var secondName: String!
    var email: String!
    var profileImageUrl: String!
    
    init(dict: [String: Any]){
        self.firstName = dict["firstName"] as! String
        self.secondName = dict["lastName"] as! String
        self.email = dict["email"] as! String
        self.profileImageUrl = dict["profileImageUrl"] as! String
    }
    
}