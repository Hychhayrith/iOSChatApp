//
//  NewMessageViewController.swift
//  iosChatApp
//
//  Created by Chhayrith on 11/22/18.
//  Copyright © 2018 Chhayrith. All rights reserved.
//

import UIKit
import Firebase

class NewMessageViewController: UITableViewController {
    let cellId = "cellId"
    var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "New Message"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        
        getUserList()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cellId")
        
        let user = users[indexPath.row]
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = user.email
        
        
        return cell
    }
    
}


// Mark: Scrap all the users
extension NewMessageViewController { 
    func getUserList() {
        Database.database().reference().child("users").observe(.childAdded, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let user = User()
                user.email = (dictionary["email"] as? String)!
                user.name = (dictionary["name"] as? String)!
                print("name: \(user.name)")
                print("email: \(user.email)")
                self.users.append(user)
                
                DispatchQueue.main.async(execute: {
                    self.tableView.reloadData()
                })
            }
        }, withCancel: nil)
    }
}

extension NewMessageViewController {
    @objc func handleCancel() {
        self.dismiss(animated: true, completion: nil)
    }
}
