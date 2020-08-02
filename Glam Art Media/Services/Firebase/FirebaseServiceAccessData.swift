//
//  FirebaseServiceAccessData.swift
//  Glam Art Media
//
//  Created by Amza Andrei on 8/2/20.
//  Copyright © 2020 Andrew. All rights reserved.
//

import UIKit
import Firebase

class FirebaseServiceAccessData: NSObject {
    
    static let sharedInstance = FirebaseServiceAccessData()
    
    func getUserData(completion: @escaping (String?, FirebaseUser?) -> ()){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let ref = Firestore.firestore().collection("users").document(uid)
        
        ref.getDocument { (snap, err) in
            if err != nil{
                completion(err?.localizedDescription, nil)
            }
            if let dict = snap?.data(){
                let userData = FirebaseUser(dict: dict)
                completion(nil, userData)
            }
        }
    }
    
}
