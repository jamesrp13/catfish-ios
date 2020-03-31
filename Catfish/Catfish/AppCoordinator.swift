//
//  AppCoordinator.swift
//  Catfish
//
//  Created by James Pacheco on 3/31/20.
//  Copyright © 2020 James Pacheco. All rights reserved.
//

import UIKit

protocol AppCoordinatorDelegate: class {
    func handleAppCoordinatorRootChanged()
}

class AppCoordinator: AuthServiceDelegate {
    
    var rootViewController: UIViewController?
    
    weak var delegate: AppCoordinatorDelegate?
    
    private var authService: AuthServiceProtocol
    
    init(authService: AuthServiceProtocol) {
        self.authService = authService
        self.authService.delegate = self
        
        setVC(authStatus: authService.authStatus)
    }
    
    func handleNewAuthStatus(_ status: AuthStatus) {
        setVC(authStatus: status)
    }

    func setVC(authStatus: AuthStatus) {
        switch authStatus {
        case .unknown:
            rootViewController = LoadingViewController()
        case .authenticated:
            print("To Do")
            // TODO: - add main view controller
        case .unauthenticated:
            rootViewController = authService.authViewController
        }
    }
}
