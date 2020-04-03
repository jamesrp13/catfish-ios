//
//  GameCoordinator.swift
//  Catfish
//
//  Created by James Pacheco on 4/1/20.
//  Copyright © 2020 James Pacheco. All rights reserved.
//

import UIKit

class GameCoordinator: ChildCoordinator {
    var delegate: ChildCoordinatorDelegate?
    
    var rootViewController: UIViewController
    
    init() {
        rootViewController = UIViewController()
    }
}
