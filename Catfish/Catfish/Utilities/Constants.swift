//
//  Constants.swift
//  Catfish
//
//  Created by morse on 3/31/20.
//  Copyright © 2020 James Pacheco. All rights reserved.
//

import UIKit

enum Images {
    static let postPlaceholder = UIImage(systemName: "photo")
    static let like = UIImage(systemName: "hand.thumbsup")
}

enum Colors {
    static let textFieldGray = UIColor(red: 198.0/255, green: 206.0/255, blue: 213.0/255, alpha: 1)
    static let labelText = UIColor(red: 44.0/255, green: 56.0/255, blue: 68.00/255, alpha: 1)
    static let purple = UIColor(named: "BGGradientTop")! // TODO: Delete after switching colors to final scheme
    
    static let aqua = UIColor(named: "Aqua")!
    static let bgGradientBottom = UIColor(named: "BGGradientBottom")!
    static let bgGradientTop = UIColor(named: "BGGradientTop")!
    static let blue = UIColor(named: "Blue")!
    static let gray = UIColor(named: "Gray")!
    static let pink = UIColor(named: "Pink")!
    static let white = UIColor(named: "White")! // Use this in case we want to have a custom color for dark mode
}

enum Fonts {
    static let header = UIFont.systemFont(ofSize: 24, weight: .bold)
}
