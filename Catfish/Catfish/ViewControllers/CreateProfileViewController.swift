//
//  CreateProfileViewController.swift
//  Catfish
//
//  Created by Shawn Gee on 4/3/20.
//  Copyright © 2020 James Pacheco. All rights reserved.
//

import UIKit

class CreateProfileViewController: UIViewController {
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    // MARK: - Private Properties
    
    private let inputAccessoryVC = TextInputAccessoryViewController()
    private var durationManager: PickerTextFieldManager?
    
    // Views:
    
    private let createProfileLabel = UILabel(text: "Create your Catfish profile", font: Fonts.header, textAlignment: .center)
    
    private let nameLabel = UILabel(text: "Name:")
    private let nameTextField = UITextField(placeholder: "Name")
    private lazy var teamVStack: UIStackView = {
        let teamVStack = UIStackView(arrangedSubviews: [nameLabel, nameTextField])
        teamVStack.axis = .vertical
        teamVStack.spacing = 10
        return teamVStack
    }()
    
    private let sendCodeLabel = UILabel(text: "Send this code to your friends", textAlignment: .center)
    
    private let bioLabel = UILabel(text: "Invite code:")
    private let bioTextView = UITextView()
    private lazy var inviteVStack: UIStackView = {
        let inviteVStack = UIStackView(arrangedSubviews: [bioLabel, bioTextView])
        inviteVStack.axis = .vertical
        inviteVStack.spacing = 10
        return inviteVStack
    }()
    
    private lazy var mainVStack = UIStackView(arrangedSubviews: [
        createProfileLabel,
        teamVStack,
        sendCodeLabel,
        inviteVStack
    ])
    
    private let createButton = CFButton(backgroundColor: Colors.purple, title: "Create", image: nil)
    
    // MARK: - Private Methods
    
    private func configure() {
        view.backgroundColor = .white
        
        addChild(inputAccessoryVC)
        inputAccessoryVC.didMove(toParent: self)
        inputAccessoryVC.register(nameTextField, bioTextView)
        
        mainVStack.axis = .vertical
        mainVStack.spacing = 25
        mainVStack.isLayoutMarginsRelativeArrangement = true
        mainVStack.directionalLayoutMargins = .init(top: 20, leading: 20, bottom: 0, trailing: 20)
        
        mainVStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mainVStack)
        
        NSLayoutConstraint.activate([
            mainVStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainVStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mainVStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
        
        createButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(createButton)
        
        NSLayoutConstraint.activate([
            createButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            createButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
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
