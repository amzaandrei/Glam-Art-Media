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
    
    func updateUserData(data: [String: String], completion: @escaping (Bool, String?) -> ()) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let ref = Firestore.firestore().collection("users").document(uid)
        
        ref.updateData(data) { err in
            if err != nil {
                completion(false, err?.localizedDescription)
            }
            completion(true, nil)
        }
    }
    
    func uploadImg(userImg: UIImage, completion: @escaping (String?, String?) -> ()) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let storageRef = Storage.storage().reference()
        let userRef = storageRef.child("photos/\(uid)")
        
        guard let dataImage = userImg.jpegData(compressionQuality: 0.7) else { return  }
        
        userRef.putData(dataImage, metadata: nil) { (metadata, err) in
            if err != nil{
                completion(err?.localizedDescription, nil)
            }
            guard let _ = metadata else { return }
            
            userRef.downloadURL { (url, err2) in
                if err2 != nil{
                    completion(err2?.localizedDescription, nil)
                }
                if let imageUrl = url {
                    completion(nil, imageUrl.absoluteString)
                }
            }
        }
    }
    
}
