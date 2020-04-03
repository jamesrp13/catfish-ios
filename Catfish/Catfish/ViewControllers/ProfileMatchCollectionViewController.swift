//
//  ProfileMatchCollectionViewController.swift
//  Catfish
//
//  Created by Shawn Gee on 4/2/20.
//  Copyright © 2020 James Pacheco. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Profile Cell"

class ProfileMatchCollectionViewController: UICollectionViewController {
    
    // MARK: - Publice
    
    let realLifeProfiles = [Profile]()

    typealias Match = (catFishProfile: Profile, realLifeProfile: Profile?)
    
    
    var matches: [Match] = []
    
    // MARK: - Init
    
    convenience init() {
        self.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(CFProfileCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.dragDelegate = self
        collectionView.dropDelegate = self
        collectionView.dragInteractionEnabled = true
    }
    
    // MARK: Collection View Data Source

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return matches.count
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? CFProfileCell else {
            fatalError("Unable to cast cell as CFProfileCell")
        }
    
        let match = matches[indexPath.section]
        
        if indexPath.row == 0 {
            let profile = match.catFishProfile
            cell.set(state: .filled(profile), imageSize: 50, labelFont: .systemFont(ofSize: 16, weight: .bold), layoutAxis: .horizontal)
        } else if indexPath.row == 1 {
            if let profile = match.realLifeProfile {
                cell.set(state: .filled(profile), imageSize: 50, imageOnly: true)
            } else {
                cell.set(state: .empty, imageSize: 50, imageOnly: true)
            }
        }
        
        return cell
    }
}

// MARK: - Flow Layout Delegate

extension ProfileMatchCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == 0 {
            return CGSize(width: 250, height: 50)
        } else {
            return CGSize(width: 50, height: 50)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 10, left: 20, bottom: 10, right: 20)
    }
}

// MARK: - Drag Delegate

extension ProfileMatchCollectionViewController: UICollectionViewDragDelegate {
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        session.localContext = collectionView
        return dragItems(at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, itemsForAddingTo session: UIDragSession, at indexPath: IndexPath, point: CGPoint) -> [UIDragItem] {
        return dragItems(at: indexPath)
    }
    
    private func dragItems(at indexPath: IndexPath) -> [UIDragItem] {
        guard indexPath.item == 1,
            let profile = matches[indexPath.section].realLifeProfile else { return [] }
        
        let name = profile.username as NSString

        let dragItem = UIDragItem(itemProvider: NSItemProvider(object: name))
        dragItem.localObject = profile
        return [dragItem]
    }
}

// MARK: - Drop Delegate

extension ProfileMatchCollectionViewController: UICollectionViewDropDelegate {
    
    /// Determines if we are dealing with a local drag session, or one coming from another collection view
    private func isLocal(_ session: UIDropSession) -> Bool {
        return session.localDragSession?.localContext as? UICollectionView == collectionView
    }
    
    func collectionView(_ collectionView: UICollectionView, canHandle session: UIDropSession) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        
        if destinationIndexPath?.item == 1 {
            if isLocal(session) {
                return UICollectionViewDropProposal(operation: .move, intent: .insertIntoDestinationIndexPath)
            } else {
                return UICollectionViewDropProposal(operation: .copy, intent: .insertIntoDestinationIndexPath)
            }
        } else {
            return UICollectionViewDropProposal(operation: .cancel, intent: .unspecified)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        let destinationIndexPath = coordinator.destinationIndexPath ?? IndexPath(item: 0, section: 0)
        
        if isLocal(coordinator.session) {
            
            for item in coordinator.items {
                guard let sourceIndexPath = item.sourceIndexPath else { continue }
                
                collectionView.performBatchUpdates({
                    let profile = matches[sourceIndexPath.section].realLifeProfile
                    matches[sourceIndexPath.section].realLifeProfile = nil
                    matches[destinationIndexPath.section].realLifeProfile = profile
                    collectionView.deleteItems(at: [sourceIndexPath])
                    collectionView.reloadItems(at: [destinationIndexPath])
                })
            }
        } else {
            
            for item in coordinator.items {
                guard let profile = item.dragItem.localObject as? Profile else { continue }
                
                collectionView.performBatchUpdates({
                    matches[destinationIndexPath.section].realLifeProfile = profile
                    collectionView.reloadItems(at: [destinationIndexPath])
                })
                
                coordinator.drop(item.dragItem, toItemAt: destinationIndexPath)
            }
        }
    }
}
