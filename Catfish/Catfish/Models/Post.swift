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
    var reactions: [Reaction]
    var comments: [Comment]
    var id: String
    
    static var mocks: [Post] = {
        return Profile.mocks.map { Post(profile: $0, imageURL: $0.imageURL, caption: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", reactions: [], comments: [], id: $0.id)}
    }()
}

struct CreatePost: Codable {
    var profileID: String
    var caption: String
}
