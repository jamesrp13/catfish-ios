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
}

struct CreateProfile: Codable {
    var username: String
    var about: String
    var imageURL: URL
}
