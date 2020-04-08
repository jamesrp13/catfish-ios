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
    var rootViewController: UIViewController {
        return containerViewController
    }
    
    private var containerViewController = ContainerViewController(child: LoadingViewController())
    
    var currentUser: User?
    
    init(networkController: NetworkController) {
        self.networkController = networkController
        getSetUser()
    }
    
    func getSetUser() {
        networkController.getCurrentUser { (response) in
            switch response {
            case let .success(user):
                self.currentUser = user
                self.setGameListVC()
            case let .failure(error):
                if error == .notFound404 {
                    self.setCreateUserVC()
                } else {
                    // TODO: - go back to login screen and show error message
                }
            }
        }
    }
    
    func setCreateUserVC() {
        containerViewController.child = CreateUserViewController()
    }
    
    func setGameListVC() {
        containerViewController.child = GameListViewController()
    }
    
    // User created: show games
    
    // Need to create User:
    
    // Not sure if we have a user...
    
}
