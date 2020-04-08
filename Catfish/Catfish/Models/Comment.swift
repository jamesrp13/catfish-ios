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
    
    static var mocks: [Comment] = {
        Profile.mocks.map { Comment(text: "Hey!", profile: $0, id: $0.id + "4") }
    }()
}

struct CreateComment: Codable {
    var postId: String
    var content: String
    var profileId: Profile
}
