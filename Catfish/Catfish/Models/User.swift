//
//  User.swift
//  Catfish
//
//  Created by morse on 3/31/20.
//  Copyright © 2020 morse. All rights reserved.
//

import Foundation
import UIKit

struct User: Codable, ProfileDisplayable {
    var displayName: String { return firstName + " " + lastName }
    var firstName: String
    var lastName: String
    var email: String
    var phone: String
    var imageURL: URL
    var id: String
    
    static var mock: User = {
        let imageURL = FileManager.default.temporaryDirectory.absoluteURL.appendingPathComponent("mockProfileImage").appendingPathExtension("png")
        let data = UIImage(named: "Profile")?.pngData()
        try? data?.write(to: imageURL)
        
        return User(firstName: "James", lastName: "Pacheco", email: "jamesrp13@gmail.com", phone: "571-201-3866", imageURL: imageURL, id: "122445345")
    }()
}

struct GameUser: Codable, ProfileDisplayable, Hashable {
    var displayName: String { return firstName }
    var imageURL: URL
    var firstName: String
    var lastName: String
    var id: String
    
    static var mocks: [GameUser] = {
        let imageURL = FileManager.default.temporaryDirectory.absoluteURL.appendingPathComponent("mockProfileImage").appendingPathExtension("png")
        let data = UIImage(named: "Profile")?.pngData()
        try? data?.write(to: imageURL)
        
        return [
            GameUser(imageURL: imageURL, firstName: "James", lastName: "Pacheco", id: "12345"),
            GameUser(imageURL: imageURL, firstName: "Shawn", lastName: "Gee", id: "1345"),
            GameUser(imageURL: imageURL, firstName: "Kyla", lastName: "Oyamot", id: "1245"),
            GameUser(imageURL: imageURL, firstName: "Brandon", lastName: "Ramirez", id: "1235"),
            GameUser(imageURL: imageURL, firstName: "Brandi", lastName: "Bailey", id: "1234"),
            GameUser(imageURL: imageURL, firstName: "Dan", lastName: "Morse", id: "123456")
        ]
    }()
}
