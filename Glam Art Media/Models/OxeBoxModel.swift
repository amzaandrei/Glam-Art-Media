//
//  OxeBoxModel.swift
//  Glam Art Media
//
//  Created by Andrew on 11/23/19.
//  Copyright © 2019 Andrew. All rights reserved.
//

import Foundation

struct OxeBoxModel {
    
    var data: String?
    var message: String!
    var status: String!
    
    init(dict: [String: String]){
        self.data = dict["data"] as? String
        self.message = dict["message"] as! String
        self.status = dict["status"] as! String
    }
    
}

struct OxeCustomerMain: Codable{
    
    var TemplateDetails: TemplateDetails!
    var CustomerDetails: CustomerDetails!
    var PartnerDetails: PartnerDetails!
    var StoreDetails: StoreDetails!
    var BillingDetails: BillingDetails!
    
    init(_ templateDetails: TemplateDetails, _ customerDetails: CustomerDetails,_ partnerDetails: PartnerDetails, _ storeDetails: StoreDetails, _ billingDetails: BillingDetails){
        self.TemplateDetails = templateDetails
        self.CustomerDetails = customerDetails
        self.PartnerDetails = partnerDetails
        self.StoreDetails = storeDetails
        self.BillingDetails = billingDetails
    }
    
}

struct TemplateDetails: Codable{
    
    var TemplateName: String!
    
    init(dict: [String: Any]) {
        self.TemplateName = dict["TemplateName"] as! String
    }
    
}

struct CustomerDetails: Codable{
    
    var Name: String!
    var Phone: String!
    var Email: CustomerDetailsEmail!
    var CountryCode: Int!
    
    init(dict: [String: Any],_ email: CustomerDetailsEmail){
        self.Name = dict["Name"] as! String
        self.Phone = dict["Phone"] as! String
        self.CountryCode = dict["CountryCode"] as! Int
        self.Email = email
    }
}

struct CustomerDetailsEmail: Codable{
    
    var recepientEmail: String!
    var subject: String!
    var fromEmail: String!
    var fromName: String!
    var replyToEmail: String!
    
    init(dict: [String: Any]) {
        self.recepientEmail = dict["recepientEmail"] as! String
        self.subject = dict["subject"] as! String
        self.fromEmail = dict["fromEmail"] as! String
        self.fromName = dict["fromName"] as! String
        self.replyToEmail = dict["replyToEmail"] as! String
    }
    
}

struct PartnerDetails: Codable {
    
    var PartnerID: String!
    var AuthKey: String!
    
    init(dict: [String: Any]) {
        self.PartnerID = dict["PartnerID"] as! String
        self.AuthKey = dict["AuthKey"] as! String
    }
    
}

struct StoreDetails: Codable{
    
    var StoreID: String!
    
    init(dict: [String: Any]) {
        self.StoreID = dict["StoreID"] as! String
    }
    
}

struct BillingDetails: Codable {
    
    var BillReceiptID: String!
    var TransactionDate: String!
    var TransactionTime: String!
    var PaymentDetails: [PaymentDetailsAll]!
    var ItemDetails: [ItemDetailsAll]!
    var SubTotal: String!
    var TotalBillAmount: Int!
    
    init(dict: [String: Any], _ paymentDetails: [PaymentDetailsAll], _ itemDetails: [ItemDetailsAll]) {
        self.BillReceiptID = dict["BillReceiptID"] as! String
        self.TransactionDate = dict["TransactionDate"] as! String
        self.TransactionTime = dict["TransactionTime"] as! String
        self.PaymentDetails = paymentDetails
        self.ItemDetails = itemDetails
        self.SubTotal = dict["SubTotal"] as? String
        self.TotalBillAmount = dict["TotalBillAmount"] as? Int
    }
    
}

struct PaymentDetailsAll: Codable{
    
    var Amount: Int!
    var `Type`: String!
    var Cashier: String!
    
    init(dict: [[String: Any]]) {
//        for (index, elem ) in dict.enumerated(){
//            for (index2, key) in elem.keys.enumerated(){
//
//                if key.description == "Cashier"{
//                    self.Cashier.insert(Array(elem.values)[index2] as! String, at: index)
//                }else if key.description == "Amount"{
//                    self.Amount.insert(Array(elem.values)[index2] as! Int, at: index)
//                }else if key.description == "Type"{
//                    self.Tyype.insert(Array(elem.values)[index2] as! String, at: index)
//                }
//            }
//        }
        for(_, elem) in dict.enumerated(){
            let detail = PaymentDetails(dict: elem)
            self.Amount = detail.Amount
            self.Type = detail.Type
            self.Cashier = detail.Cashier
        }
    }
    
}

struct PaymentDetails: Codable {
    
    var Amount: Int!
    var `Type`: String!
    var Cashier: String!
    
    init(dict: [String: Any]) {
        self.Amount = dict["Amount"] as! Int
        self.Type = dict["Type"] as! String
        self.Cashier = dict["Cashier"] as! String
    }
    
}

struct ItemDetailsAll: Codable{
    
    var ItemName: String!
    var ItemQty: Int!
    var ItemPrice: Int!
    var ItemTotal: Int!
//    var SubItems: [SubItems]!
    
    init(dict: [[String: Any]]){
//        for(index, elem) in dict.enumerated(){
//            for(index2, key) in elem.keys.enumerated(){
//                if key.description == "ItemName"{
//                    self.ItemName.insert(Array(elem.values)[index2] as! String, at: index)
//                }else if key.description == "ItemQty"{
//                    self.ItemQty.insert(Array(elem.values)[index2] as! Int, at: index)
//                }else if key.description == "ItemPrice"{
//                    self.ItemPrice.insert(Array(elem.values)[index2] as! Int, at: index)
//                }else if key.description == "ItemTotal"{
//                    self.ItemTotal.insert(Array(elem.values)[index2] as! Int, at: index)
//                }
//            }
//        }
        for (_, elem) in dict.enumerated(){
            let item = ItemDetails(dict: elem)
            self.ItemName = item.ItemName
            self.ItemQty = item.ItemQty
            self.ItemPrice = item.ItemPrice
            self.ItemTotal = item.ItemTotal
        }
    }
    
}


struct ItemDetails: Codable {
    var ItemName: String!
    var ItemQty: Int!
    var ItemPrice: Int!
    var ItemTotal: Int!
    
    init(dict: [String: Any]){
        self.ItemName = dict["ItemName"] as! String
        self.ItemQty = dict["ItemQty"] as! Int
        self.ItemPrice = dict["ItemPrice"] as! Int
        self.ItemTotal = dict["ItemTotal"] as! Int
    }
}

struct SubItems: Codable{
    
    var ItemName: String!
    var ItemQty: String!
    var ItemPrice: String!
    var ItemTotal: String!
    
    init(dict: [String: Any]) {
        self.ItemName = dict["ItemName"] as! String
        self.ItemQty = dict["ItemQty"] as! String
        self.ItemPrice = dict["ItemPrice"] as! String
        self.ItemTotal = dict["ItemTotal"] as! String
    }
    
}
