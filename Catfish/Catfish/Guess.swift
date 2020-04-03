//
//  Guess.swift
//  Catfish
//
//  Created by James Pacheco on 4/3/20.
//  Copyright © 2020 James Pacheco. All rights reserved.
//

import Foundation

struct Guess: Codable {
    var guesses: [GameUser: Profile]
}
