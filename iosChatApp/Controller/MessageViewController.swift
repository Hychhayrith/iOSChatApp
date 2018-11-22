//
//  ViewController.swift
//  iosChatApp
//
//  Created by Chhayrith on 11/19/18.
//  Copyright © 2018 Chhayrith. All rights reserved.
//

import UIKit
import Firebase

class MessageViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "SignOut", style: .plain, target: self, action: #selector(handleLogout))
        
        let newMessageIcon = UIImage(named: "newMessageIcon")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: newMessageIcon, style: .plain, target: self, action: #selector(handleNewMessage))
        checkUserLogin()
    }
}

// Mark: Hanle function
extension MessageViewController {
    @objc func handleNewMessage() {
        let newMessageController = UINavigationController(rootViewController: NewMessageViewController())
        present(newMessageController, animated: true, completion: nil)
    }
}

// Mark: Check whether user is login or logout
extension MessageViewController {
    func checkUserLogin() {
        if Auth.auth().currentUser?.uid == nil {
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        }else {
            let uid = Auth.auth().currentUser?.uid
            Database.database().reference().child("users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
                
                if let dictionary = snapshot.value as? [String: AnyObject] {
                    print(dictionary["name"] as? String as Any)
                    self.navigationItem.title = dictionary["name"] as? String
                }
                
            }, withCancel: nil)
        }
    }
    @objc func handleLogout() {
        do{
            try Auth.auth().signOut()
        }catch let logoutError {
            print("Logout error with code : \(logoutError) " )
        }
        
        let navController = UINavigationController(rootViewController: LoginViewController())
        present(navController, animated: true, completion: nil)
    }
    
}

// Mark: -> Handle Logout
extension MessageViewController {
    
    
}

