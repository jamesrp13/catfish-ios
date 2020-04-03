//
//  User.swift
//  Catfish
//
//  Created by morse on 3/31/20.
//  Copyright © 2020 morse. All rights reserved.
//

import Foundation

protocol User {
    var firstName: String { get }
    var imageURL: URL { get }
}

struct CurrentUser: Codable, ProfileDisplayable, User {
    var displayName: String { return firstName + " " + lastName }
    var firstName: String
    var lastName: String
    var email: String
    var phone: String
    var imageURL: URL
    var profiles: [Profile]
    var uid: String
}

struct GameUser: Codable, ProfileDisplayable, User, Hashable {
    var displayName: String { return firstName }
    var imageURL: URL
    var firstName: String
    var uid: String
    
    static var mocks: [GameUser] = {
        return Profile.mocks.map { GameUser(imageURL: $0.imageURL, firstName: $0.username, uid: $0.id)}
    }()
}
