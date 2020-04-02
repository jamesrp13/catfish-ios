//
//  CFGameCell.swift
//  Catfish
//
//  Created by Brandi Bailey on 4/1/20.
//  Copyright © 2020 James Pacheco. All rights reserved.
//

import UIKit

class CFGameCell: UICollectionViewCell {
    
    var gameImage = UIImageView()
    var gameTitleLabel = UILabel()
    
    var game: GameInstance? {
        didSet {
            updateViews()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSubViews()
    }
    
    private func setupSubViews() {
            
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.contentMode = .scaleAspectFit
            addSubview(imageView)
            
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textAlignment = .center
            addSubview(label)
            
                let leadingConstraint = NSLayoutConstraint(item: imageView,
                                                       attribute: .leading,
                                                       relatedBy: .equal,
                                                       toItem: self,
                                                       attribute: .leading,
                                                       multiplier: 1,
                                                       constant: 4)
            
            let trailingConstraint = NSLayoutConstraint(item: imageView,
                                                        attribute: .trailing,
                                                        relatedBy: .equal,
                                                        toItem: self,
                                                        attribute: .trailing,
                                                        multiplier: 1,
                                                        constant: -4)
            
            NSLayoutConstraint.activate([leadingConstraint, trailingConstraint])
            
            self.gameImage = imageView
            self.gameTitleLabel = label
        }
        
        private func updateViews() {

//            guard let game = game else { return }
//            gameImage.image = UIImage(data: game.imageData)
//            gameTitleLabel.text = game.title
        }
    }

