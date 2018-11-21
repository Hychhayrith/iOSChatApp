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
        
    }

    
}

// Mark: -> Handle Logout
extension ViewController {
    @objc func handleLogout() {
        let navController = UINavigationController(rootViewController: LoginViewController())
        present(navController, animated: true, completion: nil)
    }
    
}

