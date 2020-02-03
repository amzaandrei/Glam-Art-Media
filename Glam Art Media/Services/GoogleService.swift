//
//  GoogleService.swift
//  Glam Art Media
//
//  Created by Andrew on 12/7/19.
//  Copyright © 2019 Andrew. All rights reserved.
//

import Foundation
import Firebase
import GoogleSignIn

class GoogleService: NSObject {
    
    static var sharedInstance = GoogleService()
    
    func getDataFromGoogle(userGg: GIDGoogleUser , completion: @escaping (String, Bool) -> ()){
        guard let authentication = userGg.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                          accessToken: authentication.accessToken)
        Auth.auth().signIn(with: credential) { (user, err) in
            if err != nil{
                print(err!.localizedDescription)
                return
            }
            if let uid = user?.user.uid{
                self.sendGoogleDataToFirebase(uid: uid, user: userGg, completion: { _ in
                    completion(uid, true)
                })
            }
        }
    }
    
    func sendGoogleDataToFirebase(uid: String, user: GIDGoogleUser, completion: @escaping (Bool) -> ()){
        let db = Firestore.firestore()
        let ref = db.collection("users").document(uid)
        
        let data = [
            "firstName": user.profile.givenName,
            "lastName": user.profile.familyName,
            "email": user.profile.email,
            "profileImageUrl": user.profile.imageURL(withDimension: 120)?.absoluteString
            ] as [String : Any]
        
        ref.setData(data) { (err) in
            if err != nil{
                print(err?.localizedDescription)
                return
            }
            print("Data uploaded")
            completion(true)
        }
        
    }
    
}
