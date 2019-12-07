//
//  OxeBoxService.swift
//  Glam Art Media
//
//  Created by Andrew on 11/23/19.
//  Copyright © 2019 Andrew. All rights reserved.
//

import Foundation
import Alamofire

 

class OxeboxService: NSObject {
    
    static var sharedInstance = OxeboxService()
    typealias JSONStandard = [String: AnyObject]
    
    func createBill(completion: @escaping (OxeBoxModel?, Error?) -> ()){
        
        let billUrl = "https://www.oxebox.com/pbrapi/alpha/v1/index.php/PBR/generateBill"
        let base64StringFinal = UserModelOxebox.partnerId + ":" + UserModelOxebox.authKey
        let base64Encoded = base64StringFinal.toBase64()
//        let utf8str = base64StringFinal.data(using: .utf8)
//        guard let base64Encoded = utf8str?.base64EncodedData(options: .lineLength76Characters) else { return }
        let headers: HTTPHeaders = [
            "Authorization": "Basic \(base64Encoded)"
        ]
        
        guard let JSONData = readJSONFromFolder() else { return }
        
        let readJSON = readDatafromJSON(data: JSONData)!
        changeDataFromJson(json: readJSON)
        
        guard let myFinalJSONData = readJSONFromFolder() else { return }
        let finalJSON = readDatafromJSON(data: myFinalJSONData)
        print(finalJSON)
//        return
        var request = URLRequest(url: URL(string: billUrl)!)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = myFinalJSONData
        request.method = .post
        request.headers = headers
        
        AF.request(request).responseJSON { (response) in
            switch response.result{
                case .success(_):
                    if let dataExt = response.data{
                        do{
                            let parsedData = try JSONSerialization.jsonObject(with: dataExt, options: .mutableContainers) as? [String: String]
                            let responseData = OxeBoxModel(dict: parsedData!)
                            completion(responseData, nil)
                        }catch let errCat{
                            completion(nil, errCat)
                            return
                        }
                    }
                    break
                case .failure(let error as Error):
                    completion(nil, error)
                    break
            }

        }
    }
    
    var localPath: String!
    
    func readJSONFromFolder() -> Data?{
        let file = "customTemplate"
        
        var finData: Data!
        
        if let path = Bundle.main.path(forResource: file, ofType: "json"){
            ///read-only
            localPath = path
            if let jsonData = NSData(contentsOfFile: path){
                finData = jsonData as Data
            }
        }
        
        let fileManager = FileManager.default
        var attributes = [FileAttributeKey : Any]()
        attributes[.posixPermissions] = 0o666
        let success = fileManager.createFile(atPath: localPath, contents: nil, attributes: attributes)
        if success && fileManager.isWritableFile(atPath: localPath) && fileManager.isReadableFile(atPath: localPath) {
            NSLog("Worked!")
        } else {
            NSLog("Failed!")
        }
        if fileManager.fileExists(atPath: localPath){
            do{
                try fileManager.removeItem(atPath: localPath)
            }catch let error {
                print("error occurred, here are the details:\n \(error)")
            }
        }
        
        return finData
    }
    
    func readDatafromJSON(data: Data) -> NSDictionary?{
        do{
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as! NSDictionary
            return json
        }catch let err{
            print(err.localizedDescription)
            return nil
        }
    }
    
    func changeDataFromJson(json: NSDictionary){
        
        let templateDetails = TemplateDetails(dict: json["TemplateDetails"] as! [String: Any])
        let customerDetailsJson = json["CustomerDetails"] as! [String:Any]
        let customerDetailsEmail = CustomerDetailsEmail(dict: customerDetailsJson["Email"] as! [String : Any])
        let customerDetails = CustomerDetails(dict: customerDetailsJson, customerDetailsEmail)
        let partnerDetails = PartnerDetails(dict: json["PartnerDetails"] as! [String: Any])
        let storeDetails = StoreDetails(dict: json["StoreDetails"] as! [String: Any])
        let billingDetailsJSON = json["BillingDetails"] as! [String: Any]
        let billingPaymentDetails = PaymentDetailsAll(dict: billingDetailsJSON["PaymentDetails"] as! [[String: Any]])
        let billingItemDetails = ItemDetailsAll(dict: billingDetailsJSON["ItemDetails"] as! [[String: Any]])
        let billingDetails = BillingDetails(dict: billingDetailsJSON, [billingPaymentDetails], [billingItemDetails])
        var main = OxeCustomerMain(templateDetails, customerDetails, partnerDetails, storeDetails, billingDetails)
        main.TemplateDetails.TemplateName = "DEFAULT_TEMPLATE"
        
        main.CustomerDetails.Name = "Amza Andrei"
        main.CustomerDetails.Phone = "0771437386"
        main.CustomerDetails.Email.recepientEmail = "amza.andrei13@yahoo.com"
        main.CustomerDetails.Email.subject = "This is your email receipt subject line"
        main.CustomerDetails.Email.fromEmail = "andrei.amza177@gmail.com"
        main.CustomerDetails.Email.fromName = "fromName"
        main.CustomerDetails.Email.replyToEmail = "replyToEmail"
        
        main.PartnerDetails.PartnerID = "OBP-GLAMAR113-ROM-RO"
        main.PartnerDetails.AuthKey = "1TYWjP3XFcvi6pStrDGJAE2Q7OV5ZUK0Lk4xfbgmzNuHBalC"
        
        main.StoreDetails.StoreID = "OBS-GLAMAR257-ROM-RO"
        
        let uuid = UUID().uuidString
        main.BillingDetails.BillReceiptID = uuid
        main.BillingDetails.TransactionDate = "2017-09-30"
        main.BillingDetails.TransactionTime = "22:10:01"
        ///for
        
        
        main.BillingDetails.PaymentDetails[0].Amount = 400
        main.BillingDetails.PaymentDetails[0].Type = "card"
        main.BillingDetails.PaymentDetails[0].Cashier = "John Rock"
        
//        main.BillingDetails.PaymentDetails[1].Amount = 400
//        main.BillingDetails.PaymentDetails[1].Type = "card"
//        main.BillingDetails.PaymentDetails[1].Cashier = "John Rock"
        
//        let dict = ["Amount": 500, "Type": "card", "Cashier": "John Rock"] as [String : Any]
//        let paymentDetail = PaymentDetails(dict: dict)
//        main.BillingDetails.PaymentDetails[0].detail = paymentDetail
        
        main.BillingDetails.ItemDetails[0].ItemName = "Pizza"
        main.BillingDetails.ItemDetails[0].ItemQty = 2
        main.BillingDetails.ItemDetails[0].ItemPrice = 30
        main.BillingDetails.ItemDetails[0].ItemTotal = 60
        
//        print(main)
        
        do{
            let data = try JSONEncoder().encode(main)
            let url = URL(fileURLWithPath: localPath)
//            try data.write(to: url, options: .atomic)
            
            let jsonString = String(data: data, encoding: .utf8)!
            print(jsonString)
            try jsonString.write(to: url, atomically: false, encoding: .utf8)
            
        }catch let err{
            print(err.localizedDescription)
            return
        }
    }
    
    func downloadFireabsePDF(urlStr: String, completion: @escaping (String?, Data?) -> ()){
        guard let url = URL(string: urlStr) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            if let err = err{
                completion(err.localizedDescription, nil)
            }
            if let dataEx = data{
                completion(nil, dataEx)
            }
        }.resume()
    }
    
}

