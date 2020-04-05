//
//  ProfileCollectionViewController.swift
//  Catfish
//
//  Created by Shawn Gee on 4/1/20.
//  Copyright © 2020 James Pacheco. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Profile Cell"

class GameUserCollectionViewController: UICollectionViewController {
    
    // MARK: - Properties
    let gameUsers = GameUser.mocks
    
    // MARK: - Init
    
    convenience init(dragEnabled: Bool = false) {
        self.init(collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.dragInteractionEnabled = dragEnabled
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout,
            let collectionView = collectionView else { return }
        
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(CFProfileDisplayableCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        collectionView.dragDelegate = self
        
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 5
        flowLayout.itemSize = CGSize(width: 80, height: 80)
    }
    
    // MARK: Collection View Data Source
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameUsers.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? CFProfileDisplayableCell else {
            fatalError("Unable to cast cell as CFProfileDisplayableCell")
        }
        
        let gameUser = gameUsers[indexPath.row]
        cell.set(state: .filled(gameUser))
        
        return cell
    }
}

// MARK: - Drag Delegate

extension GameUserCollectionViewController: UICollectionViewDragDelegate {
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        session.localContext = collectionView
        return dragItems(at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, itemsForAddingTo session: UIDragSession, at indexPath: IndexPath, point: CGPoint) -> [UIDragItem] {
        return dragItems(at: indexPath)
    }
    
    private func dragItems(at indexPath: IndexPath) -> [UIDragItem] {
        let gameUser = gameUsers[indexPath.row]
        let name = gameUser.displayName as NSString
        
        let dragItem = UIDragItem(itemProvider: NSItemProvider(object: name))
        dragItem.localObject = gameUser
        return [dragItem]
    }
}

