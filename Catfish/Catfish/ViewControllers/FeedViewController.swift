//
//  FeedViewController.swift
//  Catfish
//
//  Created by Shawn Gee on 4/1/20.
//  Copyright © 2020 James Pacheco. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {
    // MARK: - Properties
    
    var posts: [Post] = [
        Post(profile: Profile(name: "Bart Simpson"),
             imageURL: "",
             caption: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
             likes: [],
             comments: []),
        Post(profile: Profile(name: "Meg Ryan"),
             imageURL: "",
             caption: "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
             likes: [],
             comments: []),
        Post(profile: Profile(name: "Jake Peralta"),
             imageURL: "",
             caption: "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.",
             likes: [],
             comments: []),
        Post(profile: Profile(name: "John Mayer"),
             imageURL: "",
             caption: "Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
             likes: [],
             comments: []),
        Post(profile: Profile(name: "Jennifer Lopez"),
             imageURL: "",
             caption: "Magna sit amet purus gravida quis blandit turpis cursus. Sed arcu non odio euismod lacinia at quis risus sed. Eget velit aliquet sagittis id.",
             likes: [],
             comments: []),
        Post(profile: Profile(name: "Jimmy Fallon"),
             imageURL: "",
             caption: "Pellentesque massa placerat duis ultricies lacus sed turpis tincidunt.",
             likes: [],
             comments: []),
    ]
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureHeaderView()
    }
    
    // MARK: - Private
    
    private let tableView = UITableView()
    private let headerView = UITableViewHeaderFooterView()
    private let profileCollectionVC = ProfileCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
    
    private func configureTableView() {
        tableView.register(CFPostCell.self, forCellReuseIdentifier: "PostCell")
        tableView.dataSource = self
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func configureHeaderView() {
        let playingAgainstLabel = UILabel(text: "You are playing against:", font: .systemFont(ofSize: 14, weight: .semibold))
        
        addChild(profileCollectionVC)
        profileCollectionVC.didMove(toParent: self)
        guard let profileCollectionView = profileCollectionVC.collectionView else { return }
        
        let separatorView = UIView()
        separatorView.backgroundColor = .lightGray
        
        playingAgainstLabel.translatesAutoresizingMaskIntoConstraints = false
        profileCollectionView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        
        headerView.addSubviews(playingAgainstLabel, profileCollectionView, separatorView)
        
        NSLayoutConstraint.activate([
            playingAgainstLabel.topAnchor.constraint(equalTo: headerView.topAnchor),
            playingAgainstLabel.leadingAnchor.constraint(greaterThanOrEqualTo: headerView.leadingAnchor, constant: 20),
            playingAgainstLabel.heightAnchor.constraint(equalToConstant: 30),
            
            profileCollectionView.topAnchor.constraint(equalTo: playingAgainstLabel.bottomAnchor, constant: 10),
            profileCollectionView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            profileCollectionView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            profileCollectionView.heightAnchor.constraint(equalToConstant: 80),
            
            separatorView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            separatorView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -8),
            separatorView.heightAnchor.constraint(equalToConstant: 6),
        ])
        
        
        let fittingSize = CGSize(width: tableView.bounds.width - (tableView.safeAreaInsets.left + tableView.safeAreaInsets.right), height: 136)
        let size = headerView.systemLayoutSizeFitting(fittingSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
        headerView.frame = CGRect(origin: .zero, size: size)
        tableView.tableHeaderView = headerView
    }
}

// MARK: - Table View Data Source

extension FeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as? CFPostCell else {
            fatalError("Could not cast cell as type CFPostCell")
        }
        
        let post = posts[indexPath.row]
        
        cell.set(post: post)
        
        return cell
    }
}

// Uncomment below to enable SwiftUI previews for visual feedback

//import SwiftUI
//
//struct ViewWrapper: UIViewRepresentable {
//    func makeUIView(context: UIViewRepresentableContext<ViewWrapper>) -> UIView {
//        return FeedViewController().view
//    }
//
//    func updateUIView(_ uiView: ViewWrapper.UIViewType, context: UIViewRepresentableContext<ViewWrapper>) {
//    }
//}
//
//struct ViewWrapper_Previews: PreviewProvider {
//    static var previews: some View {
//        ViewWrapper()
//    }
//}
