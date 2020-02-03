//
//  AllReceiptsViewController.swift
//  Glam Art Media
//
//  Created by Andrew on 11/25/19.
//  Copyright © 2019 Andrew. All rights reserved.
//

import UIKit
import Firebase

class AllReceiptsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let cellId = "cellId"
    var pdfsDataArr = [Data]()
    var pdfsNameArr = [String]()
    
    lazy var receiptTableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        table.delegate = self
        table.dataSource = self
        return table
    }()
    
    override func viewDidLoad() {
        view.addSubview(receiptTableView)
        locatePDFS()
        addConstraints()
        self.navigationController?.title = "My PDFs"
    }
    
    func locatePDFS(){
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let storageRef = Storage.storage().reference()
        let pdfRef = storageRef.child("pdfs").child(uid)
        
        pdfRef.listAll { (result, err) in
            if let err = err{
                print(err.localizedDescription)
                return
            }
            for item in result.items{
                item.downloadURL { (url, err2) in
                    if let err2 = err2{
                        print(err2.localizedDescription)
                        return
                    }
                    self.pdfsNameArr.append(item.name)
                    guard let urlStr = url?.absoluteString else { return }
                    self.downloadPDF(urlStr: urlStr)
                }
            }
        }
    }
    
    func downloadPDF(urlStr: String){
        OxeboxService.sharedInstance.downloadFireabsePDF(urlStr: urlStr) { (err, data) in
            if err == nil, let dataEx = data{
                self.pdfsDataArr.append(dataEx)
                DispatchQueue.main.async {
                    self.receiptTableView.reloadData()
                }
            }
        }
    }
    
    func addConstraints(){
        
        NSLayoutConstraint.activate([
            receiptTableView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            receiptTableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            receiptTableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            receiptTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pdfsDataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let pdfNames = pdfsNameArr[indexPath.row]
        cell.textLabel?.text = pdfNames
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pdfData = pdfsDataArr[indexPath.row]
        let pdfNames = pdfsNameArr[indexPath.row]
        let receiptPreview = ReceiptPreviewViewController()
        let navController = UINavigationController(rootViewController: receiptPreview)
        receiptPreview.pdfViewData = pdfData
        receiptPreview.pdfViewName = pdfNames
        self.present(navController, animated: true, completion: nil)
    }
    
}
