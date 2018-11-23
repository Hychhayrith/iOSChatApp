//
//  LoginViewController + Hanlder.swift
//  iosChatApp
//
//  Created by Chhayrith on 11/22/18.
//  Copyright © 2018 Chhayrith. All rights reserved.
//

import UIKit
import Firebase

extension LoginViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // Mark: Save user to database
    @objc func handleRegister (){
        guard let email = emailInputConstraint.text, let password = passwordInputConstraint.text, let name = nameInputConstraint.text, let profileImage = self.profileImageView.image else {
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
            
            let profileImageName = UUID().uuidString
            let storageRef = Storage.storage().reference().child("profileImage").child("\(profileImageName).jpg")
            if let uploadData = profileImage.jpegData(compressionQuality: 0.1){
                
                storageRef.putData(uploadData, metadata: nil, completion: { (_, error) in
                    if error != nil {
                        print(error!)
                        return
                    }
                    
                    storageRef.downloadURL(completion: { (url, error) in
                        if let error = error {
                            print(error)
                            return
                        }
                        guard let url = url else {
                            return
                        }
                        let values = ["name": name, "email": email, "password": password, "profileImageUrl": url.absoluteString]
                        
                        self.registerUserIntoDatabaseWithUUID(uid: uid, values: values as [String: AnyObject])
                    })
                })
            }
            
            
        }
    }
    
    fileprivate func registerUserIntoDatabaseWithUUID(uid: String, values: [String: AnyObject]) {
        let ref = Database.database().reference(fromURL: "https://ioschatapp-51603.firebaseio.com/")
        let userReference = ref.child("users").child(uid)
        userReference.updateChildValues(values, withCompletionBlock: { (error, dataRef) in
            if error != nil {
                print(error!)
                return
            }
            
            print("Saved user to Firebase")
            // Mark: User already logged
            self.dismiss(animated: true, completion: nil)
        })
    }
    
    @objc func handleImagePicker () {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
        var selectedImageFromPicker: UIImage?
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            selectedImageFromPicker = editedImage
        }else if let originalImage
            = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            selectedImageFromPicker = originalImage
        }
        
        if let selectedImage = selectedImageFromPicker {
            profileImageView.image = selectedImage
        }
        
        dismiss(animated: true, completion: nil)
        
    }
}

// Helper function
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
    return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}
