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
    
    func getAllCustomers(completion: @escaping (String?, [FirebaseUser]?) -> ()){
        let ref = Firestore.firestore().collection("users")
        ref.whereField("userType", isEqualTo: false).getDocuments { (snap, err) in
            if err != nil {
                completion(err?.localizedDescription, nil)
            }
            guard let docs = snap?.documents else { return }
            var users = [FirebaseUser]()
            for doc in docs{
                let user = FirebaseUser(dict: doc.data())
                users.append(user)
            }
            completion(nil, users)
        }
//        ref.getDocuments { (snap, err) in
//            if err != nil {
//                completion(err?.localizedDescription, nil)
//            }
//            guard let docs = snap?.documents else { return }
//            let docsFiltered = docs.filter { (doc) -> Bool in
//                let data = doc.data()
//                return (data["userType"] as! Bool) != true
//            }
//            var users = [FirebaseUser]()
//            docsFiltered.forEach { (snap) in
//                let user = FirebaseUser(dict: snap.data())
//                users.append(user)
//            }
//            completion(nil, users)
//        }
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
    
    func uploadImg(location: String, userImg: UIImage, completion: @escaping (String?, String?) -> ()) {
        let storageRef = Storage.storage().reference()
        let userRef = storageRef.child(location)
        
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
    
    func uploadFile(location: String, file: URL, completion: @escaping (String?, String?) -> ()){
        
        let storageRef = Storage.storage().reference()
        let ref = storageRef.child(location)
        
        let uploadTask = ref.putFile(from: file, metadata: nil) { (metada, err) in
            if err != nil{
                completion(err?.localizedDescription, nil)
            }
            ref.downloadURL { (fileUrl, err2) -> Void in
                if err2 != nil{
                    completion(err2?.localizedDescription, nil)
                }
                completion(nil, fileUrl?.absoluteString)
            }
        }
        
        let observer = uploadTask.observe(.progress) { snapshot in
          print(snapshot.progress) // NSProgress object
        }
        
    }
    
}
