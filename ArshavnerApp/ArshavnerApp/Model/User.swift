//
//  User.swift
//  ArshavnerApp
//
//  Created by sose yeritsyan on 5/21/21.
//

import UIKit



struct User {
    var uid: String = ""
    var name: String = ""
    var surName: String = ""
    var email: String = ""
    var phoneNumber: String? = nil
    var diseases: String? = nil
    var stepCount: Int = 0
    var imageURL: String? = nil
    
    var level: Level {
        return.easy
    }
//    mutating func configure(info: [String: Any]) {
//        self.name = info["name"] as! String
//        self.surName = info["surname"] as! String
//        self.email = info["email"] as! String
//        self.phoneNumber = info["phone"] as? String
//        self.diseases = info["diseases"] as? String
//        self.stepCount = info["stepcount"] as! Int
//        self.imageURL = info["imageURL"] as! String
//
//    }
}

