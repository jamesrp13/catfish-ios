//
//  NewGameViewController.swift
//  Catfish
//
//  Created by Shawn Gee on 4/1/20.
//  Copyright © 2020 James Pacheco. All rights reserved.
//

import UIKit

class NewGameViewController: FormViewController {

    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    // MARK: - Private Properties
    
//    private let inputAccessoryVC = TextInputAccessoryViewController()
    private var durationManager: PickerTextFieldManager?
    
    // Views:
    
    private let createGameLabel = UILabel(text: "Create a new game", font: Fonts.header, textAlignment: .center)
    
    private let teamNameLabel = UILabel(text: "Team Name:")
    private let teamNameTextField = UITextField(placeholder: "Name")
    private lazy var teamVStack: UIStackView = {
        let teamVStack = UIStackView(arrangedSubviews: [teamNameLabel, teamNameTextField])
        teamVStack.axis = .vertical
        teamVStack.spacing = 10
        return teamVStack
    }()
    
    private let gameDurationLabel = UILabel(text: "Game Duration:")
    private lazy var gameDurationTextField: UITextField = {
        let gameDurationTextField = UITextField(placeholder: nil)
        gameDurationTextField.text = "7 Days"
        
        gameDurationTextField.layer.borderColor = Colors.purple.cgColor
        gameDurationTextField.layer.borderWidth = 1.0
        gameDurationTextField.layer.cornerRadius = 5.0
        
        durationManager = PickerTextFieldManager(textField: gameDurationTextField, options: ["3 Days", "5 Days", "7 Days"], initialIndex: 2)
        
        return gameDurationTextField
    }()
    private lazy var gameDurationHStack: UIStackView = {
        let gameDurationHStack = UIStackView(arrangedSubviews: [gameDurationLabel, gameDurationTextField])
        gameDurationHStack.spacing = 40
        gameDurationLabel.setContentHuggingPriority(.required, for: .horizontal)
        return gameDurationHStack
    }()
    
    private let sendCodeLabel = UILabel(text: "Send this code to your friends", textAlignment: .center)
    
    private let inviteCodeLabel = UILabel(text: "Invite code:")
    private let inviteCodeTextField = UITextField(placeholder: "XXYYZZ")
    private lazy var inviteVStack: UIStackView = {
        let inviteVStack = UIStackView(arrangedSubviews: [inviteCodeLabel, inviteCodeTextField])
        inviteVStack.axis = .vertical
        inviteVStack.spacing = 10
        return inviteVStack
    }()
    
    private lazy var mainVStack = UIStackView(arrangedSubviews: [
        createGameLabel,
        teamVStack,
        gameDurationHStack,
        sendCodeLabel,
        inviteVStack
    ])
    
    private let createButton = CFButton(backgroundColor: Colors.purple, title: "Create", image: nil)
    
    // MARK: - Private Methods
    
    private func configure() {
        view.backgroundColor = .white
        
//        addChild(inputAccessoryVC)
//        inputAccessoryVC.didMove(toParent: self)
//        inputAccessoryVC.register(teamNameTextField, gameDurationTextField, inviteCodeTextField)
        
        mainVStack.axis = .vertical
        mainVStack.spacing = 25
        mainVStack.isLayoutMarginsRelativeArrangement = true
        mainVStack.directionalLayoutMargins = .init(top: 20, leading: 20, bottom: 0, trailing: 20)
        
        mainVStack.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(mainVStack)
        
        NSLayoutConstraint.activate([
            mainVStack.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainVStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainVStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
        
        createButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(createButton)
        
        NSLayoutConstraint.activate([
            createButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            createButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
//            contentView.heightAnchor.constraint(equalTo: scrollView.frameLayoutGuide.heightAnchor)
        ])
    }
}




// Uncomment below to enable SwiftUI previews for visual feedback

//import SwiftUI
//
//struct ViewWrapper: UIViewRepresentable {
//    func makeUIView(context: UIViewRepresentableContext<ViewWrapper>) -> UIView {
//        return NewGameViewController().view
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
