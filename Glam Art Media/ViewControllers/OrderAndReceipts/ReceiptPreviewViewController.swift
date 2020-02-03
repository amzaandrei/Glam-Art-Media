//
//  ReceiptView.swift
//  Glam Art Media
//
//  Created by Andrew on 11/25/19.
//  Copyright © 2019 Andrew. All rights reserved.
//

import UIKit
import PDFKit
import WebKit
import Firebase

class ReceiptPreviewViewController: UIViewController, WKNavigationDelegate {
    
    var pdfViewData: Data! {
        
        didSet{
            pdfView.document = PDFDocument(data: pdfViewData)
        }
        
    }
    
    var pdfViewName: String! {
        didSet{
            self.navigationItem.title = pdfViewName
        }
    }
    
    var urlWebView: String! {
        
        didSet{
            if let urlExStr = urlWebView{
                let urlReq = URLRequest(url: URL(string: urlExStr)!)
                webView.load(urlReq)
            }
        }
        
    }
    
    let pdfView: PDFView = {
        let pdfView = PDFView()
        pdfView.displayMode = .singlePageContinuous
        pdfView.autoScales = true
        pdfView.displayDirection = .vertical
        pdfView.translatesAutoresizingMaskIntoConstraints = false
        return pdfView
    }()
    
    lazy var webView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.navigationDelegate = self
        return webView
    }()
    
    override func viewDidLoad() {
        
        if pdfViewData == nil{
            view.addSubview(webView)
            addConstraintsWKWeb()
            addConstraintsWKWeb()
        }else{
            view.addSubview(pdfView)
            addConstraintsPDF()
        }
        view.backgroundColor = .white
        
//        let share = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(uploadReceiptToFirebase))
        let cancel = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelView))
//        self.navigationItem.rightBarButtonItem = share
        self.navigationItem.leftBarButtonItem = cancel
    }
    
    func addConstraintsPDF(){
        
        NSLayoutConstraint.activate([
            pdfView.leftAnchor.constraint(equalTo: view.leftAnchor),
            pdfView.rightAnchor.constraint(equalTo: view.rightAnchor),
            pdfView.topAnchor.constraint(equalTo: view.topAnchor),
            pdfView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func addConstraintsWKWeb(){
        
        NSLayoutConstraint.activate([
            webView.leftAnchor.constraint(equalTo: view.leftAnchor),
            webView.rightAnchor.constraint(equalTo: view.rightAnchor),
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
    
    @objc func cancelView(){
        self.dismiss(animated: true, completion: nil)
    }
    
}
