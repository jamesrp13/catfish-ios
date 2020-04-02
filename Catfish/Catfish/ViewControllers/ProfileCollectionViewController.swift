//
//  ProfileCollectionViewController.swift
//  Catfish
//
//  Created by Shawn Gee on 4/1/20.
//  Copyright © 2020 James Pacheco. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Profile Cell"

class ProfileCollectionViewController: UICollectionViewController {
    
    // MARK: - Properties
    
    let profiles: [Profile] = [
        Profile(name: "Jonny"),
        Profile(name: "Caitlyn"),
        Profile(name: "Barbara"),
        Profile(name: "Susan"),
        Profile(name: "Jeffery"),
        Profile(name: "Timothy"),
    ]

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout,
        let collectionView = collectionView else { return }
        
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(CFProfileCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 5
    }

    // MARK: Collection View Data Source

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return profiles.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? CFProfileCell else {
            fatalError("Unable to cast cell as CFProfileCell")
        }
    
        let profile = profiles[indexPath.row]
        cell.set(profile: profile)
        
        return cell
    }

    // MARK: Collection View Delegate


    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}

extension ProfileCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 80)
    }
}
