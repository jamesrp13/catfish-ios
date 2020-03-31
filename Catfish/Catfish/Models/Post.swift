//
//  Post.swift
//  Catfish
//
//  Created by morse on 3/31/20.
//  Copyright © 2020 morse. All rights reserved.
//

import Foundation

struct Post: Codable {
    let likes: [Like]
    let comments: [Comment]
}
