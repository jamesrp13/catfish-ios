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
    var rootViewController: UIViewController {
        return containerViewController
    }
    
    private var containerViewController = ContainerViewController(child: LoadingViewController())
    
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
            containerViewController.child = LoadingViewController()
        case .authenticated:
            children.removeAll(where: {!($0 is CatfishCoordinator)})
            
            let catfishCoordinator: CatfishCoordinator
            
            if let coordinator = children.first(where: {$0 is CatfishCoordinator}) {
                catfishCoordinator = coordinator as! CatfishCoordinator
            } else {
                let coordinator = CatfishCoordinator(networkController: NetworkController(authService: authService))
                children.append(coordinator)
                catfishCoordinator = coordinator
            }
            
            containerViewController.child = catfishCoordinator.rootViewController
        case .unauthenticated(let error):
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
            
            containerViewController.child = authCoordinator.rootViewController
            
            if let error = error {
                print(error)
            }
        }
    }
}
