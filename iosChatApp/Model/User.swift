//
//  User.swift
//  iosChatApp
//
//  Created by Chhayrith on 11/22/18.
//  Copyright © 2018 Chhayrith. All rights reserved.
//

import UIKit

class User: NSObject {
    
    var name: String?
    var email: String?
    var profileImageUrl:String?
    init(dictionary: [String: AnyObject]){
        self.name = dictionary["name"] as? String
        self.email = dictionary["email"] as? String
        self.profileImageUrl = dictionary["profileImageUrl"] as? String
    }
}
