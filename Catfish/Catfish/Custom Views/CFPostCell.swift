//
//  CFPostCell.swift
//  Catfish
//
//  Created by morse on 3/31/20.
//  Copyright © 2020 James Pacheco. All rights reserved.
//

import UIKit

class CFPostCell: UITableViewCell {
    
    static let reuseID = "PostCell"
    
    let postImageView = CFPostImageView(frame: .zero)
    let userLabel = CFTitleLabel(textAlignment: .left, fontSize: 26)
    let captionLabel = CFBodyLabel(textAlignment: .center, fontSize: 14)
    let likeButton = CFButton(backgroundColor: .systemTeal, title: "", image: Images.like)
    let commentButton = CFButton(backgroundColor: .systemTeal, title: "Comment", image: nil)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(post: Post) {
        postImageView.downloadImage(from: post.imageURL)
        userLabel.text = post.profile.name
        captionLabel.text = post.caption
    }
    
    func configure() {
        addSubviews(postImageView, userLabel, captionLabel, likeButton, commentButton)
        let padding: CGFloat = 12
        
        NSLayoutConstraint.activate([
            postImageView.topAnchor.constraint(equalTo: self.topAnchor),
            postImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            postImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            postImageView.heightAnchor.constraint(equalToConstant: 120), // Note: This will need to be dialed in
            
            userLabel.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: padding),
            userLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            userLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            userLabel.heightAnchor.constraint(equalToConstant: 40), // May need to be adusted
            
            captionLabel.topAnchor.constraint(equalTo: userLabel.bottomAnchor, constant: padding),
            captionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            captionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            captionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding)
        ])
    }

}
