//
//  Hike.swift
//  ArshavnerApp
//
//  Created by sose yeritsyan on 5/21/21.
//

import UIKit


enum Level: Int {
    case easy = 1
    case medium = 2
    case hard = 3
        
}


struct Hike {
    var name: String
    var placeName: String
    var description: String
    var rating: Int
    var participantsCount: Int
    var comments: [Comment]
    var level: Level
}
