//
//  CreateProfileView.swift
//  Catfish
//
//  Created by Shawn Gee on 4/5/20.
//  Copyright © 2020 James Pacheco. All rights reserved.
//

import UIKit

class CreateProfileView: UIView {
    
    // MARK: - Public
    
    let profilePicImageView: CircularImageView = {
        let profilePic = CircularImageView(width: 150, image: UIImage(systemName: "person.circle.fill"))
        profilePic.tintColor = Colors.aqua
        
        return profilePic
    }()
    
    let uploadButton: UIButton = {
        let uploadButton = UIButton(type: .system)
        uploadButton.setTitle("Upload your Catfish profile picture", for: .normal)
        uploadButton.setTitleColor(Colors.white, for: .normal)
        uploadButton.titleLabel?.font = .systemFont(ofSize: 16)
        
        return uploadButton
    }()
    
    let nameTextField = UITextField(placeholder: "Name")
    
    let bioTextView: UITextView = {
        let bioTextView = UITextView()
        bioTextView.translatesAutoresizingMaskIntoConstraints = false
        bioTextView.heightAnchor.constraint(equalToConstant: 220).isActive = true
        
        bioTextView.layer.borderColor = UIColor.systemGray4.cgColor
        bioTextView.layer.borderWidth = 1.0
        bioTextView.layer.cornerRadius = 5.0
        
        return bioTextView
    }()
    
    let catfishButton = CFButton(backgroundColor: Colors.pink, title: "Catfish!", image: nil)
    
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    // MARK: - Private Subviews
    
    // Labels
    private let createProfileLabel = UILabel(text: "Create your Catfish profile", font: Fonts.header,
                                             textColor: Colors.white, textAlignment: .center)
    private let nameLabel = UILabel(text: "Name:", textColor: Colors.white)
    private let bioLabel = UILabel(text: "Bio:", textColor: Colors.white)
    
    // Stacks
    private lazy var nameVStack: UIStackView = {
        let nameVStack = UIStackView(arrangedSubviews: [nameLabel, nameTextField])
        nameVStack.axis = .vertical
        nameVStack.spacing = 10
        return nameVStack
    }()
    
    private lazy var profilePicVStack: UIStackView = {
        let profilePicVStack = UIStackView(arrangedSubviews: [profilePicImageView, uploadButton])
        profilePicVStack.axis = .vertical
        profilePicVStack.alignment = .center
        
        return profilePicVStack
    }()
    
    private lazy var bioVStack: UIStackView = {
        let bioVStack = UIStackView(arrangedSubviews: [bioLabel, bioTextView])
        bioVStack.axis = .vertical
        bioVStack.spacing = 10
        return bioVStack
    }()
    
    private lazy var mainVStack: UIStackView = {
        let mainVStack = UIStackView(arrangedSubviews: [
            createProfileLabel,
            profilePicVStack,
            nameVStack,
            bioVStack
        ])
        
        mainVStack.axis = .vertical
        mainVStack.spacing = 25
        mainVStack.isLayoutMarginsRelativeArrangement = true
        mainVStack.directionalLayoutMargins = .init(top: 20, leading: 20, bottom: 0, trailing: 20)
        
        return mainVStack
    }()
    
    // MARK: - Private Methods
    
    func configure() {
        mainVStack.translatesAutoresizingMaskIntoConstraints = false
        catfishButton.translatesAutoresizingMaskIntoConstraints = false
        addSubviews(mainVStack, catfishButton)
        
        NSLayoutConstraint.activate([
            mainVStack.topAnchor.constraint(equalTo: topAnchor),
            mainVStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainVStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            catfishButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            catfishButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ])
    }
    
}
