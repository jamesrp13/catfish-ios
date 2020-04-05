//
//  Comment.swift
//  Catfish
//
//  Created by morse on 3/31/20.
//  Copyright © 2020 morse. All rights reserved.
//

import Foundation

struct Comment: Codable {
    var text: String
    var profile: Profile
    var id: String
}

struct CreateComment: Codable {
    var postId: String
    var content: String
    var profileId: Profile
}
