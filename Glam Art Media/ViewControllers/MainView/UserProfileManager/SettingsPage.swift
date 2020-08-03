//
//  SettingsApp.swift
//  Glam Art Media
//
//  Created by Amza Andrei on 8/2/20.
//  Copyright © 2020 Andrew. All rights reserved.
//

import UIKit
import SwiftUI

class SettingsPage: UIViewController, UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate {
    
    let labelsText = [
        "Profile Picture",
        "Username",
        "Email",
        "Country Code"
    ]
    
    private let cellId = "cellId"
    var userData: FirebaseUser!
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(SettingsPageCell.self, forCellReuseIdentifier: cellId)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    override func viewDidLoad() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Fertih", style: .plain, target: self, action: #selector(updateUserContent))
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.frame = view.bounds
        retrieveUserData()
    }
    
    func retrieveUserData(){
        FirebaseServiceAccessData.sharedInstance.getUserData { (err, data) in
            if err == nil{
                DispatchQueue.main.async {
                    self.userData = data
                    self.tableView.delegate = self
                    self.tableView.dataSource = self
                    self.tableView.reloadData()
                }
            }else{
                print(err)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return labelsText.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! SettingsPageCell
        cell.customLabel.text = labelsText[indexPath.row]
        DispatchQueue.global(qos: .userInitiated).async {
            DispatchQueue.main.async {
                cell.textField.becomeFirstResponder()
            }
        }
        cell.prefixBoxDelegate = self
        if indexPath.row == 0 {
            cell.cellActivate = SettingsPageCell.cellType.LOGO
            cell.logoImageView.image = LetterImageGenerator.imageWith(name: userData.firstName + " " + userData.secondName)
        }else if indexPath.row == 1 {
            cell.cellActivate = SettingsPageCell.cellType.TEXTFIELD
            cell.textField.placeholder = userData.firstName + " " + userData.secondName
        }else if indexPath.row == 2 {
            cell.cellActivate = SettingsPageCell.cellType.TEXTFIELD
            cell.textField.placeholder = userData.email
        }else {
            cell.cellActivate = SettingsPageCell.cellType.PHONEPREFIX
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 200
        }
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 3{
            let countryPage = CountryCodePage()
            countryPage.prefixDelegate = self
            let nav = UINavigationController(rootViewController: countryPage)
            self.present(nav, animated: true)
        }
    }
    
    @objc func updateUserContent(){
        let indexImg = IndexPath(row: 0, section: 0)
        let indexUsr = IndexPath(row: 1, section: 0)
        let indexEmail = IndexPath(row: 2, section: 0)
        let indexPhn = IndexPath(row: 3, section: 0)
        
        var imgUrl = ""
        guard let imgData = getContent(index: indexImg) as? UIImage else { return }
        
        DispatchQueue.background(background: {
            FirebaseServiceAccessData.sharedInstance.uploadImg(userImg: imgData) { (url, err) in
                if err != nil{
                    print(err)
                }else{
                    //FIXME: it doesn't update to firebase the photo...i think that that's a problem with firestore => pod update
                    imgUrl = url!
                }
            }
        }, completion:{
            //FIXME: add the correct phone number at the end
            let phnNr = "\(self.getContent(index: indexPhn) as! String) 00000000"
            
            let dataToUpdate: [String: String] = [
                "email": self.getContent(index: indexEmail) as! String,
                "username": self.getContent(index: indexUsr) as! String,
                "profileImageUrl": imgUrl,
                "phoneNumber": phnNr
                ]
            FirebaseServiceAccessData.sharedInstance.updateUserData(data: dataToUpdate) { (res, err) in
                if res == false {
                    print(err)
                }else{
                    print("Data updated")
                }
            }
        })
        
    }
    
    func getContent(index: IndexPath) -> Any{
        let cell = tableView.cellForRow(at: index) as! SettingsPageCell
        if cell.cellActivate == SettingsPageCell.cellType.TEXTFIELD{
            if let returnStr = cell.textField.text, returnStr != ""{
                return returnStr
            }
            return cell.textField.placeholder!
        } else if cell.cellActivate == SettingsPageCell.cellType.PHONEPREFIX{
            //MARK: add here the rest number "+32 000"
            return cell.prefixLabel.text!
        }
        return cell.logoImageView.image!
    }
    
    
    
}

extension SettingsPage: PrefixDelegate, PrefixProtocol {
    //FIXME: inca nu merge sa apas doar pe prefixBOx ca sa mi apara lista intreaga
    func prefixBoxTapped(cell: SettingsPageCell) {
        let indexPath = tableView.indexPath(for: cell)
        print("tapped cell: \(indexPath?.row)" )
    }
    
    func prefix(prefixStr: String) {
        let indexPath = IndexPath(row: 3, section: 0)
        let cell = tableView.cellForRow(at: indexPath) as! SettingsPageCell
        cell.prefixLabel.text = prefixStr
//        DispatchQueue.main.async {
//            self.tableView.reloadData()
//        }
    }
    
}

//struct SettingsPagePreview: PreviewProvider{
//    static var previews: some View{
//        ContainerView().edgesIgnoringSafeArea(.all)
//    }
//    
//    struct ContainerView: UIViewControllerRepresentable {
//        
//        func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<SettingsPagePreview.ContainerView>) {
//            
//        }
//        
//        func makeUIViewController(context: UIViewControllerRepresentableContext<SettingsPagePreview.ContainerView>) -> UIViewController {
//            return SettingsPage()
//        }
//    }
//    
//}
