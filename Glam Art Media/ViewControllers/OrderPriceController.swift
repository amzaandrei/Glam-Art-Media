//
//  OrderPriceController.swift
//  Glam Art Media
//
//  Created by Andrew on 11/23/19.
//  Copyright © 2019 Andrew. All rights reserved.
//

import UIKit

class OrderPriceController: UIViewController {
    
    let button: UIButton = {
        let btt = UIButton(type: .system)
        btt.addTarget(self, action: #selector(createBill), for: .touchUpInside)
        btt.setTitle("Buy me", for: .normal)
        btt.translatesAutoresizingMaskIntoConstraints = false
        return btt
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        view.addSubview(button)
        addConstraints()
    }
    
    func addConstraints(){
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.heightAnchor.constraint(equalToConstant: 30),
            button.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    @objc func createBill(){
        OxeboxService.sharedInstance.createBill { (responseData, err) in
            if err == nil{
                print(responseData)
//                self.openReceipt(url: (responseData?.data)!)
//                self.downloadPDF(url: (responseData?.data)!)
            }
        }
    }
    
    func openReceipt(url: String){
        DispatchQueue.main.async {
            let receiptViewController = ReceiptPreviewViewController()
            receiptViewController.urlWebView = url
//            receiptViewController.pdfViewData = pdfData
            let navController = UINavigationController(rootViewController: receiptViewController)
            self.present(navController, animated: true, completion: nil)
        }
    }
    
//    func downloadPDF(url: String){
//        OxeboxService.sharedInstance.downloadPDF(urlStr: url) { (err,pdfData)  in
//            if err == nil{
//                DispatchQueue.main.async {
//                    let receiptViewController = ReceiptPreviewViewController()
//                    receiptViewController.pdfViewData = pdfData
//                    self.present(receiptViewController, animated: true, completion: nil)
//                }
//            }
//        }
//    }
    
}
