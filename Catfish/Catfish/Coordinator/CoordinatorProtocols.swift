//
//  CoordinatorProtocols.swift
//  Catfish
//
//  Created by James Pacheco on 4/1/20.
//  Copyright © 2020 James Pacheco. All rights reserved.
//

import UIKit

protocol Coordinator: class {
    var rootViewController: UIViewController { get }
}

protocol ParentCoordinator: Coordinator {
    var children: [ChildCoordinator] { get }
}

protocol ChildCoordinatorDelegate: ParentCoordinator {
    func childDidFinish(child: ChildCoordinator)
}

protocol ChildCoordinator: Coordinator {
    var delegate: ChildCoordinatorDelegate? { get set }
}
