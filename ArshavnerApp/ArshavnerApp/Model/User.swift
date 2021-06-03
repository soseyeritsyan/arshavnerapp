//
//  User.swift
//  ArshavnerApp
//
//  Created by sose yeritsyan on 5/21/21.
//

import UIKit



struct User {
    var name: String
    var surName: String
    var email: String
    var phoneNumber: String?
    var diseases: String?
    var stepCount: Int
    var userPhoto: UIImage?
    
    var level: Level {
        return.easy
    }
    
    mutating func configure(info: [String: Any]) {
        self.name = info["name"] as! String
        self.surName = info["surname"] as! String
        self.email = info["email"] as! String
        self.phoneNumber = info["phone"] as? String
        self.diseases = info["diseases"] as? String
        self.stepCount = info["stepcount"] as! Int
        //self.userPhoto = info["name"] as! String
        
    }
}

