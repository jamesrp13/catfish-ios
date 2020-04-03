//
//  Reaction.swift
//  Catfish
//
//  Created by morse on 3/31/20.
//  Copyright © 2020 morse. All rights reserved.
//

import Foundation

enum ReactionType: String, Codable {
    case like, love, laugh
}

struct Reaction: Codable {
    
    
    var type: ReactionType
    var profile: Profile
    var id: String
}

struct CreateReaction: Codable {
    var postID: String
    var type: ReactionType
    var profile: Profile
}
