//
//  MainController.swift
//  Glam Art Media
//
//  Created by Andrew on 11/19/19.
//  Copyright © 2019 Andrew. All rights reserved.
//

import UIKit
import SwiftUI
import Firebase

class MainController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var userContArr: UserModel! = nil
    
    var cellIconsArr: [String] = ["pencil","pencil","pencil","pencil","pencil"]
    
    enum ViewControllers: Int {
        case mainController = 0
        case searchController = 1
        case taskController = 2
        case notificationsController = 3
        case userController = 4
    }
    
    lazy var taskView: TaskController = {
        let view = TaskController()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var searchUserView: SearchUserPage = {
        let view = SearchUserPage()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var mainIcon: UIImageView = {
        let img = UIImage(systemName: "flame")
        let imageView = UIImageView(image: img)
        imageView.tag = ViewControllers.mainController.rawValue
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var searchIcon: UIImageView = {
        let img = UIImage(systemName: "magnifyingglass", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20))
        let imageView = UIImageView(image: img)
        imageView.tag = ViewControllers.searchController.rawValue
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    lazy var notifIcon: UIImageView = {
        let img = UIImage(systemName: "bell", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20))
        let imageView = UIImageView(image: img)
        imageView.tag = ViewControllers.notificationsController.rawValue
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var currProfilImg: UIImageView = {
        let img = UIImage(systemName: "person.crop.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20))
        let imageView = UIImageView()
        imageView.image = img
        imageView.layer.cornerRadius = 18
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        imageView.layer.cornerRadius = 6
        imageView.clipsToBounds = true
        imageView.tag = ViewControllers.userController.rawValue
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var settingsIcon: UIImageView = {
        let img = UIImage(systemName: "gear", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20))
        let imageView = UIImageView(image: img)
        imageView.tag = 2
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var tasksIcon: UIImageView = {
        let img = UIImage(systemName: "gear", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20))
        let imageView = UIImageView(image: img)
        imageView.tag = ViewControllers.taskController.rawValue
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let underStackView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.layer.cornerRadius = 30
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var stack: UIStackView = {
        let stc = UIStackView(arrangedSubviews: [mainIcon, searchIcon,tasksIcon, notifIcon, currProfilImg])
        stc.translatesAutoresizingMaskIntoConstraints = false
        stc.alignment = .center
        stc.distribution = .equalSpacing
        stc.axis = .horizontal
        stc.addBackground(color: UIColor.white.withAlphaComponent(0))
        return stc
    }()
    
    let cellId = "cellId"
    
    lazy var userPageTableView: UITableView = {
        let tb = UITableView()
        tb.register(UserPageTWCell.self, forCellReuseIdentifier: cellId)
        tb.translatesAutoresizingMaskIntoConstraints = false
        tb.delegate = self
        tb.dataSource = self
        return tb
    }()
    
    let navBar: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    override func viewDidLoad() {
        downloadUserData()
        view.backgroundColor = .green
        view.addSubview(underStackView)
        view.addSubview(stack)
        
        let stackTapped = UITapGestureRecognizer(target: self, action: #selector(findIconTapped(_:)))
        stack.addGestureRecognizer(stackTapped)
        addStackView()
    }
    
    func addStackView(){
        
        NSLayoutConstraint.activate([
            stack.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -30),
            stack.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            stack.heightAnchor.constraint(equalToConstant: 70),
            stack.widthAnchor.constraint(equalToConstant: 200),
            underStackView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -30),
            underStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            underStackView.heightAnchor.constraint(equalToConstant: 70),
            underStackView.widthAnchor.constraint(equalToConstant: 250)
        ])
        
        addConstraints(tag: 0)
        
    }
    
    
    var previousView = 0
    
    func addConstraints(tag: Int){
        
        if tag == ViewControllers.mainController.rawValue{
            removeAllSubviews()
            self.previousView = tag
        }else if tag == ViewControllers.searchController.rawValue{
            removeAllSubviews()
            self.previousView = tag
            
            view.insertSubview(searchUserView, belowSubview: underStackView)
            
            NSLayoutConstraint.activate([
                searchUserView.leftAnchor.constraint(equalTo: view.leftAnchor),
                searchUserView.rightAnchor.constraint(equalTo: view.rightAnchor),
                searchUserView.topAnchor.constraint(equalTo: view.topAnchor),
                searchUserView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            ])
        }else if tag == ViewControllers.taskController.rawValue{
            removeAllSubviews()
            self.previousView = tag
            
            view.insertSubview(taskView, belowSubview: underStackView)
            
            NSLayoutConstraint.activate([
                taskView.leftAnchor.constraint(equalTo: view.leftAnchor),
                taskView.rightAnchor.constraint(equalTo: view.rightAnchor),
                taskView.topAnchor.constraint(equalTo: view.topAnchor),
                taskView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            ])
            
        }else if tag == ViewControllers.notificationsController.rawValue{
            removeAllSubviews()
            self.previousView = tag
             
        }else if tag == ViewControllers.userController.rawValue{
            removeAllSubviews()
            self.previousView = tag
            
            view.insertSubview(userPageTableView, belowSubview: underStackView)
            view.addSubview(navBar)
            navBar.addSubview(settingsIcon)
            
            let settingsIconTapped = UITapGestureRecognizer(target: self, action: #selector(presentSetting))
            settingsIcon.addGestureRecognizer(settingsIconTapped)
            
            NSLayoutConstraint.activate([
                navBar.leftAnchor.constraint(equalTo: view.leftAnchor),
                navBar.rightAnchor.constraint(equalTo: view.rightAnchor),
                navBar.safeTopAnchor.constraint(equalTo: view.topAnchor),
                navBar.heightAnchor.constraint(equalToConstant: 120),
                userPageTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
                userPageTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
                userPageTableView.topAnchor.constraint(equalTo: navBar.bottomAnchor),
                userPageTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                settingsIcon.rightAnchor.constraint(equalTo: navBar.rightAnchor, constant: -15),
                settingsIcon.bottomAnchor.constraint(equalTo: navBar.bottomAnchor, constant: -15),
                settingsIcon.heightAnchor.constraint(equalToConstant: 20),
                settingsIcon.widthAnchor.constraint(equalToConstant: 20),
            ])
        }
        
    }
    
    @objc func presentSetting(){
        let nav = UINavigationController(rootViewController: SettingsPage())
        self.present(nav, animated: true)
    }
    
    func removeAllSubviews(){
        if previousView == ViewControllers.userController.rawValue{
            self.userPageTableView.removeFromSuperview()
            self.navBar.removeFromSuperview()
        }
    }
    
    
    @objc func findIconTapped(_ sender: UITapGestureRecognizer){
        
        for icon in stack.subviews{
            let location = sender.location(in: icon)
            if let hitIcon = icon.hitTest(location, with: nil){
                addConstraints(tag: hitIcon.tag)
            }
        }
        
    }
    
    func downloadUserData(){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let ref = Firestore.firestore().collection("users").document(uid)
        ref.getDocument { (snap, err) in
            if let err = err{
                print(err.localizedDescription)
                return
            }
            
            guard let dataUser = snap?.data() else { return }
            self.userContArr = UserModel(dict: dataUser)
            print(self.userContArr.firstName)
            self.downloadImage(urlStr: self.userContArr.profileImageUrl)
        }
    }
    
    func downloadImage(urlStr: String){
        
        guard let url = URL(string: urlStr) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            if let err = err{
                print(err.localizedDescription)
                return
            }
            if let downloadData = UIImage(data: data!){
                DispatchQueue.main.async {
//                    self.currProfilImg.image = downloadData
                }
            }
        }.resume()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! UserPageTWCell
        cell.customImage.image = UIImage(named: cellIconsArr[indexPath.row])
        cell.customNameLabel.text = "mza"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
    }
    
}

