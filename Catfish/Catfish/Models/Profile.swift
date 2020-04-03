//
//  Profile.swift
//  Catfish
//
//  Created by morse on 3/31/20.
//  Copyright © 2020 morse. All rights reserved.
//

import Foundation

struct Profile: Codable {
    var name: String
    var about: String
    var id: String
}

struct CreateProfile: Codable {
    var name: String
    var about: String
}
