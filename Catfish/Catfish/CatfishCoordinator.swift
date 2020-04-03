//
//  CatfishCoordinator.swift
//  Catfish
//
//  Created by James Pacheco on 4/1/20.
//  Copyright © 2020 James Pacheco. All rights reserved.
//

import UIKit

class CatfishCoordinator: ChildCoordinator {
    var delegate: ChildCoordinatorDelegate?
    
    var networkController: NetworkController
    var rootViewController: UIViewController
    
    var currentUser: User?
    
    init(networkController: NetworkController) {
        rootViewController = LoadingViewController()
        self.networkController = networkController
    }
    
    func setUser() {
        guard let user = 
    }
    
    // User created: show games
    
    // Need to create User:
    
    // Not sure if we have a user...
    
}
