//
//  ShareViewController.swift
//  ShareExtensionReceipt
//
//  Created by Andrew on 11/25/19.
//  Copyright © 2019 Andrew. All rights reserved.
//

import UIKit
import Social
import Firebase


class ShareViewController: SLComposeServiceViewController {

    let defaults = UserDefaults(suiteName: "group.com.glamartmedia.extension")
    
    override func isContentValid() -> Bool {
        // Do validation of contentText and/or NSExtensionContext attachments here
        return true
    }

    var uid: String!
    
    override func didSelectPost() {
        print("posted")
        
        defaults?.synchronize()
        
        if let restoredValue = defaults!.string(forKey: "userId") {
            uid = restoredValue
        }
        else {
            print("Cannot find value")
        }
        
        if let content = extensionContext!.inputItems.first as? NSExtensionItem {
            if let contents = content.attachments {
                for attachment in contents{
                    attachment.loadItem(forTypeIdentifier: "public.item", options: nil) { data, error in
                        let url = data as! URL
//                        let fileExtension = url.pathExtension as String?
                        let name = url.lastPathComponent
                        do{
                            let fileData = try Data(contentsOf: url)
                            print(fileData)
                            self.uploadPDFToFirebase(pdfData: fileData, pdfName: name)
                        }catch let err{
                            print(err.localizedDescription)
                            return
                        }
                    }
                }
            }
        }
        
        self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
    }

    override func configurationItems() -> [Any]! {
        // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
        return []
    }
    
    func uploadPDFToFirebase(pdfData: Data, pdfName: String){
        FirebaseApp.configure()
        let storageRef = Storage.storage().reference()
//        let uuid = NSUUID().uuidString
        if let uidSafe = uid {
            let pdfRef = storageRef.child("pdfs").child("\(uidSafe)/\(pdfName)")
            pdfRef.putData(pdfData, metadata: nil) { (metadata, err) in
                if let err = err{
                    print(err.localizedDescription)
                    return
                }
                guard let _ = metadata else { return }
                print("PDF uploaded")
            }
        }
    
        
    }
     
}
