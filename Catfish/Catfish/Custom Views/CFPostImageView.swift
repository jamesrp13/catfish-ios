//
//  CFPostImageView.swift
//  Catfish
//
//  Created by morse on 3/31/20.
//  Copyright © 2020 James Pacheco. All rights reserved.
//

import UIKit

class CFPostImageView: UIImageView {

    let placeholderImage = Images.postPlaceholder
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        image = placeholderImage
    }
    
    func downloadImage(from url: String) {
        // Network call to download image goes here
    }
}
