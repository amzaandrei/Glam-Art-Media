//
//  SearchUserPage.swift
//  Glam Art Media
//
//  Created by Amza Andrei on 8/5/20.
//  Copyright © 2020 Andrew. All rights reserved.
//

import UIKit
import Firebase

class SearchUserPage: UIView, UITableViewDelegate, UITableViewDataSource{
    
    private let cellId = "cellId"
    var users = [FirebaseUser]()
    
    lazy var tableView: UITableView = {
        let t = UITableView()
        t.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        t.dataSource = self
        t.delegate = self
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.addSubview(tableView)
        fetchCustomers()
        addConstraints()
    }
    
    func addConstraints(){
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: self.leftAnchor),
            tableView.topAnchor.constraint(equalTo: self.topAnchor),
            tableView.rightAnchor.constraint(equalTo: self.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    func fetchCustomers(){
        FirebaseServiceAccessData.sharedInstance.getAllCustomers { (err, usersFetched) in
            if err != nil{
                print(err)
            }else{
                DispatchQueue.main.async {
                    self.users = usersFetched!
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let user = users[indexPath.row]
        cell.textLabel?.text = user.firstName + " " + user.secondName
        return cell
    }
    
}
