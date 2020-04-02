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
    
    let realLifeProfiles = [Profile]()

    typealias Match = (catFishProfile: Profile, realLifeProfile: Profile?)
    
    let matches: [Match] = [
        (Profile(name: "Bart Simpson"), Profile(name: "Caitlyn")),
        (Profile(name: "Meg Ryan"), Profile(name: "Jonny")),
        (Profile(name: "Jake Peralta"), Profile(name: "Barbara")),
        (Profile(name: "John Mayer"), Profile(name: "Susan")),
        (Profile(name: "Jennifer Lopez"), Profile(name: "Jeffery")),
        (Profile(name: "Jimmy Fallon"), Profile(name: "Timothy")),
    ]
    
    // MARK: - Init
    
    convenience init() {
        self.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(CFProfileCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    // MARK: Collection View Data Source

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return matches.count
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 2
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? CFProfileCell else {
            fatalError("Unable to cast cell as CFProfileCell")
        }
    
        let match = matches[indexPath.section]
        
        
        if indexPath.row == 0 {
            let profile = match.catFishProfile
            cell.set(profile: profile, imageSize: 50, labelFont: .systemFont(ofSize: 16, weight: .bold), layoutAxis: .horizontal)
        } else if indexPath.row == 1 {
            if let profile = match.realLifeProfile {
                cell.set(profile: profile, imageSize: 50, imageOnly: true)
            }
        }
        
        
        return cell
    }

    // MARK: Collection View Delegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

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
