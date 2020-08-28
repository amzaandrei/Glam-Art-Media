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
    var userType: Bool!
    
    init(dict: [String: Any]){
        self.firstName = dict["firstName"] as! String
        self.secondName = dict["lastName"] as! String
        self.email = dict["email"] as! String
        self.profileImageUrl = dict["profileImageUrl"] as! String
        self.userType = dict["userType"] as! Bool
    }
    
    static func downloadImage(urlStr: String) -> UIImage? {
        
        guard let url = URL(string: urlStr) else { return nil }
        var finalImg: UIImage!
        
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            if let err = err {
                print(err.localizedDescription)
            }
            if let downloadData = UIImage(data: data!){
                finalImg = downloadData
            }
        }.resume()
        
        return finalImg
    }
    
}
