//
//  LoginViewController.swift
//  iosChatApp
//
//  Created by Chhayrith on 11/19/18.
//  Copyright © 2018 Chhayrith. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    let inputConstrainerView: UIView = {
        let vw = UIView()
        vw.backgroundColor = UIColor.white
        vw.layer.cornerRadius = 5
        vw.layer.masksToBounds = true
        vw.translatesAutoresizingMaskIntoConstraints = false
        return vw
    }()
    
    lazy var loginRegisterButton: UIButton = {
        let registerBtn = UIButton(type: .system)
        registerBtn.setTitle("Register", for: .normal)
        registerBtn.backgroundColor = UIColor(r: 80, g: 101, b: 161)
        registerBtn.setTitleColor(UIColor.white, for: UIControl.State())
        registerBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        registerBtn.layer.cornerRadius = 5
        registerBtn.layer.masksToBounds = true
        
        // Mark: Handle click
        registerBtn.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        
        registerBtn.translatesAutoresizingMaskIntoConstraints = false
        return registerBtn
    }()
    
    let nameInputConstraint: UITextField = {
        let input = UITextField()
        input.placeholder = "Name"
        input.translatesAutoresizingMaskIntoConstraints = false
        return input
    }()
    
    let nameSeparatorView: UIView = {
       let vw = UIView()
        vw.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        vw.translatesAutoresizingMaskIntoConstraints = false
        
        return vw
    }()
    
    let emailInputConstraint: UITextField = {
        let input = UITextField()
        input.placeholder = "Email"
        input.translatesAutoresizingMaskIntoConstraints = false
        return input
    }()
    
    let emailSeparatorView: UIView = {
        let vw = UIView()
        vw.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        vw.translatesAutoresizingMaskIntoConstraints = false
        
        return vw
    }()
    
    let passwordInputConstraint: UITextField = {
        let input = UITextField()
        input.placeholder = "Password"
        input.isSecureTextEntry = true
        input.translatesAutoresizingMaskIntoConstraints = false
        return input
    }()
    
    let passwordSeparatorView: UIView = {
        let vw = UIView()
        vw.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        vw.translatesAutoresizingMaskIntoConstraints = false
        
        return vw
    }()
    
    lazy var profileImageView: UIImageView = {
       let img = UIImageView()
        img.image = UIImage(named: "gameofthrones_splash")
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let loginRegisterSegmentedController: UISegmentedControl = {
        let segment = UISegmentedControl(items: ["Login", "Register"])
        segment.translatesAutoresizingMaskIntoConstraints = false
        return segment
    }()
   

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(r: 61, g: 91, b: 151)
        
        view.addSubview(inputConstrainerView)
        view.addSubview(loginRegisterButton)
        view.addSubview(profileImageView)
        view.addSubview(loginRegisterSegmentedController)
        
        setupInputContrainerView()
        setupLoginRegisterButton()
        setupProfileImageView()
        setupLoginRegisterSegmentedController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }

}

// Mark: -> Objective C function to handle button actions
extension LoginViewController {
    
    // Mark: Save user to database
    @objc func handleRegister (){
        guard let email = emailInputConstraint.text, let password = passwordInputConstraint.text, let name = nameInputConstraint.text else {
            print("Form is not valid")
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if(error != nil){
                print(error!)
                return
            }
            
            guard let uid = user?.user.uid else {
                return
            }
            // Mark: Successfully authenticate user
            
            let ref = Database.database().reference(fromURL: "https://ioschatapp-51603.firebaseio.com/")
            let userReference = ref.child("users").child(uid)
            let values = ["name": name, "email": email, "password": password]
            userReference.updateChildValues(values, withCompletionBlock: { (error, dataRef) in
                if error != nil {
                    print(error!)
                    return
                }
                
                print("Saved user to Firebase")
            })
        }
    }
}

// Mark: -> view constrainer
extension LoginViewController {
    func setupInputContrainerView(){
        NSLayoutConstraint.activate([
            inputConstrainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            inputConstrainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            inputConstrainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24),
            inputConstrainerView.heightAnchor.constraint(equalToConstant: 150)
        ])
        
        view.addSubview(nameInputConstraint)
        view.addSubview(nameSeparatorView)
        
        NSLayoutConstraint.activate([
            nameInputConstraint.topAnchor.constraint(equalTo: inputConstrainerView.topAnchor),
            nameInputConstraint.widthAnchor.constraint(equalTo: inputConstrainerView.widthAnchor, constant: -12),
            nameInputConstraint.leftAnchor.constraint(equalTo: inputConstrainerView.leftAnchor, constant: 12),
            nameInputConstraint.heightAnchor.constraint(equalTo: inputConstrainerView.heightAnchor, multiplier: 1/3),
            
            nameSeparatorView.topAnchor.constraint(equalTo: nameInputConstraint.bottomAnchor),
            nameSeparatorView.heightAnchor.constraint(equalToConstant: 1),
            nameSeparatorView.widthAnchor.constraint(equalTo: nameInputConstraint.widthAnchor),
            nameSeparatorView.leftAnchor.constraint(equalTo: inputConstrainerView.leftAnchor)
        ])
        
        view.addSubview(emailInputConstraint)
        view.addSubview(emailSeparatorView)
        
        NSLayoutConstraint.activate([
            emailInputConstraint.topAnchor.constraint(equalTo: nameInputConstraint.bottomAnchor),
            emailInputConstraint.widthAnchor.constraint(equalTo: inputConstrainerView.widthAnchor, constant: -12),
            emailInputConstraint.leftAnchor.constraint(equalTo: inputConstrainerView.leftAnchor, constant: 12),
            emailInputConstraint.heightAnchor.constraint(equalTo: inputConstrainerView.heightAnchor, multiplier: 1/3),
            
            emailSeparatorView.topAnchor.constraint(equalTo: emailInputConstraint.bottomAnchor),
            emailSeparatorView.heightAnchor.constraint(equalToConstant: 1),
            emailSeparatorView.widthAnchor.constraint(equalTo: inputConstrainerView.widthAnchor),
            emailSeparatorView.leftAnchor.constraint(equalTo: inputConstrainerView.leftAnchor)
            ])
        
        view.addSubview(passwordInputConstraint)
        
        NSLayoutConstraint.activate([
            passwordInputConstraint.topAnchor.constraint(equalTo: emailInputConstraint.bottomAnchor),
            passwordInputConstraint.widthAnchor.constraint(equalTo: inputConstrainerView.widthAnchor, constant: -12),
            passwordInputConstraint.leftAnchor.constraint(equalTo: inputConstrainerView.leftAnchor, constant: 12),
            passwordInputConstraint.heightAnchor.constraint(equalTo: inputConstrainerView.heightAnchor, multiplier: 1/3)
        ])
    }
    
    func setupLoginRegisterButton() {
        NSLayoutConstraint.activate([
            loginRegisterButton.widthAnchor.constraint(equalTo: inputConstrainerView.widthAnchor),
            loginRegisterButton.heightAnchor.constraint(equalToConstant: 50),
            loginRegisterButton.leftAnchor.constraint(equalTo: inputConstrainerView.leftAnchor),
            loginRegisterButton.topAnchor.constraint(equalTo: inputConstrainerView.bottomAnchor, constant: 12)
        ])
    }
    
    func setupProfileImageView() {
        NSLayoutConstraint.activate([
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImageView.bottomAnchor.constraint(equalTo: loginRegisterSegmentedController.topAnchor, constant: -12),
            profileImageView.widthAnchor.constraint(equalToConstant: 150),
            profileImageView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    func setupLoginRegisterSegmentedController() {
        // Constraint X, Y, width, height
        NSLayoutConstraint.activate([
            loginRegisterSegmentedController.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginRegisterSegmentedController.bottomAnchor.constraint(equalTo: inputConstrainerView.topAnchor, constant: -12),
            loginRegisterSegmentedController.widthAnchor.constraint(equalTo: inputConstrainerView.widthAnchor),
            loginRegisterSegmentedController.heightAnchor.constraint(equalToConstant: 36)
        ])
    }
}

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat){
        self.init(red: r / 255, green: g / 255, blue: b / 255, alpha: 1)
    }
}
