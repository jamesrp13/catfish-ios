//
//  BGGradientView.swift
//  Catfish
//
//  Created by Shawn Gee on 4/4/20.
//  Copyright © 2020 James Pacheco. All rights reserved.
//

import UIKit

class BGGradientView: UIView {
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    // MARK: - Private
    
    private func configure() {
        let layer = self.layer as! CAGradientLayer
        
        layer.colors = [Colors.bgGradientTop, Colors.bgGradientBottom].map { $0.cgColor }
        
        layer.startPoint = CGPoint(x: 0, y: 0)
        layer.endPoint = CGPoint(x: 0, y: 0.557)
    }
    
    override class var layerClass: AnyClass {
        get {
            return CAGradientLayer.self
        }
    }
}
