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
        //navigationItem.rightBarButtonItem = UIBarButtonItem(image: newMessageIcon, style: .plain, target: self, action: #selector(handleNewMessage))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: newMessageIcon, style: .plain, target: self, action: #selector(handleChatLog))
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
            if let uid = Auth.auth().currentUser?.uid {
                Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
                    
                    if let dictionary = snapshot.value as? [String: AnyObject] {
                        let user = User(dictionary: dictionary)
                        self.setupNavBarWithUser(user: user)
                        
                    } 
                }, withCancel: nil)
            }
        }
    }
    func setupNavBarWithUser(user: User){
        let titleView: UIView = {
           let vw = UIView()
            vw.translatesAutoresizingMaskIntoConstraints = false
            return vw
        }()
        
        let containerView: UIView = {
           let vw = UIView()
            vw.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleChatLog)))
            vw.translatesAutoresizingMaskIntoConstraints = false
            return vw
        }()
        
        let profileImageView: UIImageView = {
           let imageView = UIImageView()
            imageView.loadImageUsingCacheWithUrlString(urlString: user.profileImageUrl!)
            imageView.contentMode = .scaleAspectFill
            imageView.layer.cornerRadius = 20
            imageView.layer.masksToBounds = true
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
        
        let navTitle: UILabel = {
           let title = UILabel()
            title.text = user.name
            title.translatesAutoresizingMaskIntoConstraints = false
            return title
        }()
        
        containerView.addSubview(profileImageView)
        // set constraint for profileImageview
        // Needs x, y, width, height
        profileImageView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 8).isActive = true
        profileImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        containerView.addSubview(navTitle)
        // Set constraint for navTitle
        // needs x, y, width, height
        navTitle.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 8).isActive = true
        navTitle.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor).isActive = true
        navTitle.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        navTitle.heightAnchor.constraint(equalTo: profileImageView.heightAnchor).isActive = true
        
        titleView.addSubview(containerView)
        // Set constraint for containerView
        // needs x,y, width, height
        containerView.centerYAnchor.constraint(equalTo: titleView.centerYAnchor).isActive = true
        containerView.centerXAnchor.constraint(equalTo: titleView.centerXAnchor).isActive = true
        
        
        self.navigationItem.titleView = titleView
        
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

// Mark: -> Handle Chat log
extension MessageViewController {
    @objc func handleChatLog() {
        let chatLogViewController = ChatLogViewController(collectionViewLayout: UICollectionViewFlowLayout())
        navigationController?.pushViewController(chatLogViewController, animated: true)
    }
}

