//
//  AddGameViewController.swift
//  Catfish
//
//  Created by Brandi Bailey on 4/1/20.
//  Copyright © 2020 James Pacheco. All rights reserved.
//

import UIKit

enum Constants {
    static let reuseID = "GameCell"
    static let sectionInsets = UIEdgeInsets(top: 40.0, left: 20.0, bottom: 40.0, right: 20.0)
    static let itemsPerRow: CGFloat = 2
}

class AddGameViewController: UIViewController {
    
//    weak var containerView: UIView!
    var collectionView: UICollectionView!
    var games: [String] = ["1", "4", "6", "3", "9"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
    }
}

extension AddGameViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return games.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.reuseID, for: indexPath) as! CFGameCell
        
        cell.gameTitleLabel.text = games[indexPath.item]
        cell.backgroundColor = .systemPink
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let paddingSpace = Constants.sectionInsets.left * (Constants.itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / Constants.itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
}

// MARK: - Methods

extension AddGameViewController {
    func configureCollectionView() {
        
        view.backgroundColor = .white
        
        let flowLayout = UICollectionViewFlowLayout()

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(CFGameCell.self, forCellWithReuseIdentifier: "GameCell")
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            self.view.topAnchor.constraint(equalTo: collectionView.topAnchor),
            self.view.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 240),
            self.view.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor),
            self.view.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor)
        ])
        
        collectionView.backgroundColor = .darkGray
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}
