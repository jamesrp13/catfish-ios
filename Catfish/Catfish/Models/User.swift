//
//  User.swift
//  Catfish
//
//  Created by morse on 3/31/20.
//  Copyright © 2020 morse. All rights reserved.
//

import Foundation

struct User: Codable {
    let firstName: String
    let lastName: String
    let email: String
    let id: Int
}
