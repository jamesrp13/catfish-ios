//
//  CircularImageView.swift
//  Catfish
//
//  Created by Shawn Gee on 4/1/20.
//  Copyright © 2020 James Pacheco. All rights reserved.
//

import UIKit

class CircularImageView: UIImageView {
    
    // MARK: - Public Methods
    
    func setWidth(_ width: CGFloat) {
        widthConstraint?.constant = width
    }
    
    // MARK: - Initializers
    
    init(width: CGFloat, image: UIImage? = nil) {
        super.init(image: image)
        contentMode = .scaleAspectFill
        translatesAutoresizingMaskIntoConstraints = false
        
        widthConstraint = widthAnchor.constraint(equalToConstant: width)
        widthConstraint?.isActive = true
        
        heightAnchor.constraint(equalTo: widthAnchor).isActive = true
        clipsToBounds = true
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.width / 2
    }
    
    // MARK: - Private
    
    private var widthConstraint: NSLayoutConstraint?
}
