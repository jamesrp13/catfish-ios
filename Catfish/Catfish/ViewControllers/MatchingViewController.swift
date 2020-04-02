//
//  MatchingViewController.swift
//  Catfish
//
//  Created by Shawn Gee on 4/2/20.
//  Copyright © 2020 James Pacheco. All rights reserved.
//

import UIKit

class MatchingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
    }
    
    // MARK: - Private

    let headerProfileCVC = ProfileCollectionViewController(dragEnabled: true)
    let profileMatchCVC = ProfileMatchCollectionViewController()
    
    private func configure() {
        view.backgroundColor = .white
        
        addChild(headerProfileCVC)
        headerProfileCVC.didMove(toParent: self)
        
        addChild(profileMatchCVC)
        profileMatchCVC.didMove(toParent: self)
        
        guard let headerProfileCollectionView = headerProfileCVC.collectionView,
            let profileMatchCollectionView = profileMatchCVC.collectionView else { return }
        
        let instructionLabel = UILabel(text: "Drag and drop to match each\n player to their Catfish profile", font: .systemFont(ofSize: 16, weight: .bold), textAlignment: .center, numberOfLines: 0)
        
        headerProfileCollectionView.translatesAutoresizingMaskIntoConstraints = false
        instructionLabel.translatesAutoresizingMaskIntoConstraints = false
        profileMatchCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubviews(headerProfileCollectionView, instructionLabel, profileMatchCollectionView)
        
        NSLayoutConstraint.activate([
            headerProfileCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerProfileCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            headerProfileCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            headerProfileCollectionView.heightAnchor.constraint(equalToConstant: 80),
            
            instructionLabel.topAnchor.constraint(equalTo: headerProfileCollectionView.bottomAnchor, constant: 20),
            instructionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            instructionLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            profileMatchCollectionView.topAnchor.constraint(equalTo: instructionLabel.bottomAnchor, constant: 20),
            profileMatchCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            profileMatchCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            profileMatchCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
