//
//  LoadingViewController.swift
//  Catfish
//
//  Created by James Pacheco on 3/31/20.
//  Copyright © 2020 James Pacheco. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {
    
    private let loadingWheel = UIActivityIndicatorView()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        loadingWheel.startAnimating()
    }
    
    func configureViews() {
        NSLayoutConstraint.activate([
            loadingWheel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingWheel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
