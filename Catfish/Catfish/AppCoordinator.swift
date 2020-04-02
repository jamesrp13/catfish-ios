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

class AppCoordinator: ParentCoordinator, AuthServiceDelegate {
    var rootViewController: UIViewController = LoadingViewController()
    
    var children: [ChildCoordinator] = []
    
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
            children.removeAll(where: {!($0 is GameCoordinator)})
            
            let gameCoordinator: GameCoordinator
            
            if let coordinator = children.first(where: {$0 is GameCoordinator}) {
                gameCoordinator = coordinator as! GameCoordinator
            } else {
                let coordinator = GameCoordinator()
                children.append(coordinator)
                gameCoordinator = coordinator
            }
            
            rootViewController = gameCoordinator.rootViewController
        case .unauthenticated:
            children.removeAll(where: {!($0 is AuthCoordinator)})
            
            let authCoordinator: AuthCoordinator
            
            if let coordinator = children.first(where: {$0 is AuthCoordinator}) {
                authCoordinator = coordinator as! AuthCoordinator
            } else {
                let authService = FirebaseAuthService()
                let coordinator = AuthCoordinator(authService: authService, authUIProvider: authService)
                children.append(coordinator)
                authCoordinator = coordinator
            }
            
            rootViewController = authCoordinator.rootViewController
        case let .error(error):
            // TODO: - What to do here?
            print(error)
        }
    }
}
