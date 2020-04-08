//
//  ContainerViewController.swift
//  Catfish
//
//  Created by James Pacheco on 4/5/20.
//  Copyright © 2020 James Pacheco. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {
    var child: UIViewController? {
        didSet {
            if let child = child {
                transition(from: oldValue?.view, to: child.view)
            } else {
                child = LoadingViewController()
            }
        }
    }
    
    init(child: UIViewController?) {
        self.child = child
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func transition(from oldView: UIView?, to newView: UIView) {
        oldView?.removeFromSuperview()
        
        view.addSubview(newView)
        newView.fillSuperview()
    }
}
