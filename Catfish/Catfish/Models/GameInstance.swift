//
//  GameInstance.swift
//  Catfish
//
//  Created by morse on 3/31/20.
//  Copyright © 2020 morse. All rights reserved.
//

import Foundation

struct GameInstance: Codable {
    var id: String
    var name: String
    var imageURL: URL?
    var members: [GameUser]
    var inviteCode: String
}

struct CreateGameInstance: Codable {
    var name: String
}

// TODO: Endpoint for adding profiles to game instance
