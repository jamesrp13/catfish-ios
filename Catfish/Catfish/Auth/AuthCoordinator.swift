//
//  AuthCoordinator.swift
//  Catfish
//
//  Created by James Pacheco on 3/31/20.
//  Copyright © 2020 James Pacheco. All rights reserved.
//

import UIKit

class AuthCoordinator: ChildCoordinator {
    
    var rootViewController: UIViewController {
        return authUIProvider.authViewController
    }
    
    weak var delegate: ChildCoordinatorDelegate?
    
    private let authService: AuthServiceProtocol
    private let authUIProvider: AuthUIProvider
    
    init(authService: AuthServiceProtocol, authUIProvider: AuthUIProvider) {
        self.authService = authService
        self.authUIProvider = authUIProvider
    }
}
