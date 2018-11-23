//
//  ChatLogViewController.swift
//  iosChatApp
//
//  Created by Chhayrith on 11/23/18.
//  Copyright © 2018 Chhayrith. All rights reserved.
//

import UIKit


class ChatLogViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UITextFieldDelegate {
    let textField: UITextField = {
        let textInput = UITextField()
        textInput.placeholder = "Enter message..."
        textInput.translatesAutoresizingMaskIntoConstraints = false
        return textInput
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Chat Log"
        collectionView.backgroundColor = UIColor.white
        textField.delegate = self
       addSubviewToView()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        handleSendMessage()
        return true
    }
    
    func addSubviewToView(){
        let inputTextField: UIView = {
            let vw = UIView()
            vw.translatesAutoresizingMaskIntoConstraints = false
            return vw
        }()
        
        let sendMessageButton: UIButton = {
            let sendBtn = UIButton(type: .system)
            sendBtn.setTitle("Send", for: .normal)
            sendBtn.addTarget(self, action: #selector(handleSendMessage), for: .touchUpInside)
            sendBtn.translatesAutoresizingMaskIntoConstraints = false
            return sendBtn
        }()
        let saparatorLine: UIView = {
            let vw = UIView()
            vw.backgroundColor = UIColor(r: 220, g: 220, b: 220)
            vw.translatesAutoresizingMaskIntoConstraints = false
            return vw
        }()
        
        view.addSubview(inputTextField)
        // set constraint for iput Text Field
        // needs x, y, width, height
        inputTextField.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        inputTextField.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        inputTextField.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        inputTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        inputTextField.addSubview(sendMessageButton)
        // set constraint for send message button
        // needs x, y, width, height
        sendMessageButton.rightAnchor.constraint(equalTo: inputTextField.rightAnchor, constant: -8).isActive = true
        sendMessageButton.centerYAnchor.constraint(equalTo: inputTextField.centerYAnchor).isActive = true
        sendMessageButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        sendMessageButton.heightAnchor.constraint(equalTo: inputTextField.heightAnchor).isActive = true

        inputTextField.addSubview(textField)
        // set constraint for textfield
        // needs x, y, width, height
        textField.leftAnchor.constraint(equalTo: inputTextField.leftAnchor, constant: 8).isActive = true
        textField.centerYAnchor.constraint(equalTo: inputTextField.centerYAnchor).isActive = true
        textField.rightAnchor.constraint(equalTo: sendMessageButton.leftAnchor, constant: -8).isActive = true
        textField.heightAnchor.constraint(equalTo: inputTextField.heightAnchor).isActive = true
        
        view.addSubview(saparatorLine)
        // set constraint for saparator line
        // needs x, y, width, height
        saparatorLine.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        saparatorLine.topAnchor.constraint(equalTo: inputTextField.topAnchor).isActive = true
        saparatorLine.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        saparatorLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }

}
