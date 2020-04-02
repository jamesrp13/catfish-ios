//
//  User.swift
//  Catfish
//
//  Created by morse on 3/31/20.
//  Copyright © 2020 morse. All rights reserved.
//

import Foundation

struct User: Codable {
    let username: String
    let password: String
    let email: String
    let id: Int
    let token: String
}

struct ReturnedUser: Codable {
    let id: Int
    let token: String
}
