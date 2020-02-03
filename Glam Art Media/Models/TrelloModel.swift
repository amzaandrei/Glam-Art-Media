//
//  TrelloModel.swift
//  Glam Art Media
//
//  Created by Andrew on 11/24/19.
//  Copyright © 2019 Andrew. All rights reserved.
//

import Foundation

struct TrelloBoardModel {
    
    var id: String!
    var name: String!
    var boardUrl: String!
    
    init(dict: [String: Any]) {
        self.id = dict["id"] as? String
        self.name = dict["name"] as? String
        self.boardUrl = dict["url"] as? String
    }
    
}

struct TrelloListModel {
    
    var id: String!
    var name: String!
    
    
    init(dict: [String: Any]) {
        self.id = dict["id"] as? String
        self.name = dict["name"] as? String
        
    }
    
}

struct TrelloCardModel {
    
    var id: String!
    var name: String!
    var description: String!
    var dateLastActivity: String!
    
    init(dict: [String: Any]) {
        self.id = dict["id"] as? String
        self.name = dict["name"] as? String
        self.description = dict["desc"] as? String
        self.dateLastActivity = dict["dateLastActivity"] as? String
    }
    
}

struct TrelloCardModelCheckLists {
    
    var id: String!
    var name: String!
    var items: [TrelloCardModelCheckListsItems]!
    
    init(dict: [String: Any], _ items: [TrelloCardModelCheckListsItems]){
        self.id = dict["id"] as? String
        self.name = dict["name"] as? String
        self.items = items
    }
    
}


struct TrelloCardModelCheckListsItems {
    
    var id: String!
    var state: String!
    
    init(dict: [String: Any]) {
        self.id = dict["id"] as? String
        self.state = dict["state"] as? String
    }
    
}

struct TrelloCardModelMembers {
    
    var id: String!
    var avatarHash: String?
    var fullName: String!
    
    init(dict: [String: Any]) {
        self.id = dict["id"] as? String
        self.avatarHash = dict["avatarHash"] as? String
        self.fullName = dict["fullName"] as? String
    }
    
}




struct TrelloCardModelBadges {
    
    var checkItems: Int!
    var checkItemsChecked: Int!
    var comments: Int!
    
    init(dict: [String: Any]){
        self.checkItems = dict["checkItems"] as? Int
        self.checkItemsChecked = dict["checkItemsChecked"] as? Int
        self.comments = dict["comments"] as? Int
    }
    
}
