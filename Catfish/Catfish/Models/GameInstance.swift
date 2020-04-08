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
    var profiles: [Profile]
    var inviteCode: String
    
    static var mock: GameInstance = {
        return GameInstance(id: "8217404", name: "A Team", imageURL: nil, members: GameUser.mocks, profiles: Profile.mocks, inviteCode: "12345")
    }()
}

struct CreateGameInstance: Codable {
    var name: String
}

// TODO: Endpoint for adding profiles to game instance
