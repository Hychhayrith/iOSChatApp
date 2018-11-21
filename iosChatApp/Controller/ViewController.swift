//
//  ViewController.swift
//  iosChatApp
//
//  Created by Chhayrith on 11/19/18.
//  Copyright © 2018 Chhayrith. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        

        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        
        if Auth.auth().currentUser?.uid == nil {
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        }
        
    }

    
}

// Mark: -> Handle Logout
extension ViewController {
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

