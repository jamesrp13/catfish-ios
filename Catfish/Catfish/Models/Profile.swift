//
//  Profile.swift
//  Catfish
//
//  Created by morse on 3/31/20.
//  Copyright © 2020 morse. All rights reserved.
//

import Foundation
import UIKit

protocol ProfileDisplayable {
    var displayName: String { get }
    var imageURL: URL { get }
}

struct Profile: Codable, ProfileDisplayable {
    var username: String
    var displayName: String { return username }
    var bio: String
    var imageURL: URL
    var dob: Date
    var id: String
    
    static var mocks: [Profile] = {
        let imageURL = FileManager.default.temporaryDirectory.absoluteURL.appendingPathComponent("mockImage").appendingPathExtension("png")
        let data = UIImage(named: "TestImage")?.pngData()
        try? data?.write(to: imageURL)
        
        return [
            Profile(username: "Jonny", bio: "", imageURL: imageURL, dob: Date(), id: "12345"),
            Profile(username: "Caitlyn", bio: "", imageURL: imageURL, dob: Date(), id: "1245"),
            Profile(username: "Barbara", bio: "", imageURL: imageURL, dob: Date(), id: "2345"),
            Profile(username: "Susan", bio: "", imageURL: imageURL, dob: Date(), id: "1235"),
            Profile(username: "Jeffery", bio: "", imageURL: imageURL, dob: Date(), id: "1234"),
            Profile(username: "Timothy", bio: "", imageURL: imageURL, dob: Date(), id: "1345"),
        ]
    }()
}

struct CreateProfile: Codable {
    var username: String
    var about: String
    var imageURL: URL
}
