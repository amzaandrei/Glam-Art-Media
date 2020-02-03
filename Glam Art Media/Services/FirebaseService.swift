//
//  FirebaseSIgnUpService.swift
//  Glam Art Media
//
//  Created by Andrew on 12/7/19.
//  Copyright © 2019 Andrew. All rights reserved.
//

import Foundation
import Firebase

class FirebaseService: NSObject {
    
    static var sharedInstance = FirebaseService()
    
    func createUser(emailStr: String, password: String, userImage: UIImage, completion: @escaping (String, Bool) -> ()){
        Auth.auth().createUser(withEmail: emailStr, password: password) { (user, err) in
            if let err = err{
                print(err.localizedDescription)
                return
            }
            
            if let uid = user?.user.uid{
                self.sentDataEmailToFirebase(uid: uid, emailStr: emailStr, userImage: userImage, completion: { _ in
                    completion(uid, true)
                })
            }
        }
    }
    
    func sentDataEmailToFirebase(uid: String, emailStr: String, userImage: UIImage, completion: @escaping (Bool) -> ()){
        let ref = Firestore.firestore().collection("users").document(uid)
        let storageRef = Storage.storage().reference()
        let userRef = storageRef.child("photos/\(uid)")
        
        guard let dataImage = userImage.jpegData(compressionQuality: 0.7) else { return  }
        
        userRef.putData(dataImage, metadata: nil) { (metadata, err) in
            if let error = err{
                print(error.localizedDescription)
                return
            }
            
            guard let _ = metadata else { return }
            
            userRef.downloadURL { (url, err2) in
                if let error2 = err{
                    print(error2.localizedDescription)
                    return
                }
                if let imageUrl = url {
                    let data = ["email": emailStr, "profileImageUrl": imageUrl.absoluteString] as [String : Any]
                    ref.setData(data) { (err3) in
                        if let error3 = err3{
                            print(error3.localizedDescription)
                            return
                        }
                        print("Data uploaded")
                        completion(true)
                    }
                }
            }
            
        }
    }
    
}
