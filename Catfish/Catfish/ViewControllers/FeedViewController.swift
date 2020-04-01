//
//  FeedViewController.swift
//  Catfish
//
//  Created by Shawn Gee on 4/1/20.
//  Copyright © 2020 James Pacheco. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    // MARK: - Private
    
    private let tableView = UITableView()
    private let headerView = UIView() // Need a CFHeaderView
    
    private func configureTableView() {
        headerView.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 150)
        tableView.tableHeaderView = headerView
        
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
}

// MARK: - Table View Data Source

extension FeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as? CFPostCell else {
            fatalError("Could not cast cell as type CFPostCell")
        }
        
        // Mock post
        let post = Post(profile: Profile(name: "Jonny Appleseed"),
                        imageURL: "",
                        caption: "Hey, look at me pick some apples from an apple tree!",
                        likes: [],
                        comments: [])
        
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
