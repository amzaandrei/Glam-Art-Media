//
//  SettingsApp.swift
//  Glam Art Media
//
//  Created by Amza Andrei on 8/2/20.
//  Copyright © 2020 Andrew. All rights reserved.
//

import UIKit
import SwiftUI

class SettingsPage: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let labelsText = [
        "Profile Picture",
        "Username",
        "Email",
        "Phonenumber"
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
        if indexPath.row == 0 {
            cell.cellActivate = true
            cell.logoImageView.image = LetterImageGenerator.imageWith(name: userData.firstName + " " + userData.secondName)
        }else{
            cell.cellActivate = false
            cell.textField.placeholder = "Add"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 200
        }
        return 60
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
