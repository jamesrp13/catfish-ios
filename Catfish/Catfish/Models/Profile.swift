//
//  Profile.swift
//  Catfish
//
//  Created by morse on 3/31/20.
//  Copyright © 2020 morse. All rights reserved.
//

import Foundation

protocol ProfileDisplayable {
    var displayName: String { get }
    var imageURL: URL { get }
}

struct Profile: Codable, ProfileDisplayable {
    var username: String
    var displayName: String { return username }
    var about: String
    var imageURL: URL
    var id: String
    
    static var mocks: [Profile] = {
//        let imageURL = Bundle.main.url(forResource: "TestImage", withExtension: ".HEIC")!
        let imageURL = URL(string: "https://www.google.com")!
        
        return [
            Profile(username: "Jonny", about: "", imageURL: imageURL, id: "12345"),
            Profile(username: "Caitlyn", about: "", imageURL: imageURL, id: "1245"),
            Profile(username: "Barbara", about: "", imageURL: imageURL, id: "2345"),
            Profile(username: "Susan", about: "", imageURL: imageURL, id: "1235"),
            Profile(username: "Jeffery", about: "", imageURL: imageURL, id: "1234"),
            Profile(username: "Timothy", about: "", imageURL: imageURL, id: "1345"),
        ]
    }()
}

struct CreateProfile: Codable {
    var username: String
    var about: String
    var imageURL: URL
}
