//
//  NewGameView.swift
//  Catfish
//
//  Created by Shawn Gee on 4/6/20.
//  Copyright © 2020 James Pacheco. All rights reserved.
//

import UIKit

class NewGameView: UIView {
    
    // MARK: - Public
    
    let teamNameTextField = UITextField(placeholder: "Name")
    
    let gameDurationTextField: UITextField = {
        let gameDurationTextField = UITextField(placeholder: nil)
        gameDurationTextField.text = "7 Days"
        
        gameDurationTextField.layer.borderColor = Colors.pink.cgColor
        gameDurationTextField.layer.borderWidth = 2.0
        gameDurationTextField.layer.cornerRadius = 5.0
        
        return gameDurationTextField
    }()
    
    let inviteCodeTextField = UITextField(placeholder: "XXYYZZ")
    
    let createButton = CFButton(backgroundColor: Colors.aqua, title: "Create", image: nil)
    
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
    private let createGameLabel = UILabel(text: "Create a new game", font: Fonts.header, textColor: Colors.white, textAlignment: .center)
    private let teamNameLabel = UILabel(text: "Team Name:", textColor: Colors.white)
    private let gameDurationLabel = UILabel(text: "Game Duration:", textColor: Colors.white)
    private let sendCodeLabel = UILabel(text: "Send this code to your friends", textColor: Colors.white, textAlignment: .center)
    private let inviteCodeLabel = UILabel(text: "Invite code:", textColor: Colors.white)
    
    // Stacks
    private lazy var teamVStack: UIStackView = {
        let teamVStack = UIStackView(arrangedSubviews: [teamNameLabel, teamNameTextField])
        teamVStack.axis = .vertical
        teamVStack.spacing = 10
        return teamVStack
    }()
    
    private lazy var gameDurationHStack: UIStackView = {
        let gameDurationHStack = UIStackView(arrangedSubviews: [gameDurationLabel, gameDurationTextField])
        gameDurationHStack.spacing = 40
        gameDurationLabel.setContentHuggingPriority(.required, for: .horizontal)
        return gameDurationHStack
    }()
    
    private lazy var inviteVStack: UIStackView = {
        let inviteVStack = UIStackView(arrangedSubviews: [inviteCodeLabel, inviteCodeTextField])
        inviteVStack.axis = .vertical
        inviteVStack.spacing = 10
        return inviteVStack
    }()
    
    private lazy var mainVStack: UIStackView = {
        let mainVStack =  UIStackView(arrangedSubviews: [
            createGameLabel,
            teamVStack,
            gameDurationHStack,
            sendCodeLabel,
            inviteVStack
        ])
        
        mainVStack.axis = .vertical
        mainVStack.spacing = 25
        mainVStack.isLayoutMarginsRelativeArrangement = true
        mainVStack.directionalLayoutMargins = .init(top: 20, leading: 20, bottom: 0, trailing: 20)
        
        return mainVStack
    }()
    
    // MARK: - Private Methods
    
    private func configure() {
        mainVStack.translatesAutoresizingMaskIntoConstraints = false
        createButton.translatesAutoresizingMaskIntoConstraints = false
        addSubviews(mainVStack, createButton)
        
        NSLayoutConstraint.activate([
            mainVStack.topAnchor.constraint(equalTo: topAnchor),
            mainVStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainVStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            createButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            createButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
        ])
    }
}
