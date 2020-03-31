//
//  Comment.swift
//  Catfish
//
//  Created by morse on 3/31/20.
//  Copyright © 2020 morse. All rights reserved.
//

import Foundation

struct Comment: Codable {
    let post: Post
    let text: String
}
