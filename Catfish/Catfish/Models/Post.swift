//
//  Post.swift
//  Catfish
//
//  Created by morse on 3/31/20.
//  Copyright © 2020 morse. All rights reserved.
//

import Foundation

struct Post: Codable {
    var profile: Profile
    var imageURL: URL
    var caption: String
    var likes: [Like]
    var comments: [Comment]
    var id: String
}

struct CreatePost: Codable {
    var profile: Profile
    var imageURL: URL
    var caption: String
    var likes: [Like]
    var comments: [Comment]
}
