//
//  ChatLogViewController + Handler.swift
//  iosChatApp
//
//  Created by Chhayrith on 11/23/18.
//  Copyright © 2018 Chhayrith. All rights reserved.
//

import UIKit
import Firebase

// Mark: send message handler
extension ChatLogViewController{
    @objc func handleSendMessage() {
        
        let messageRef = Database.database().reference().child("message")
        let values = ["message": textField.text!]
        let childRef = messageRef.childByAutoId()
        childRef.updateChildValues(values) { (error, data) in
            if let error = error {
                print(error)
                return
            }
        }
        
    }
}
