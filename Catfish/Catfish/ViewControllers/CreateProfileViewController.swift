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
    private lazy var nameVStack: UIStackView = {
        let nameVStack = UIStackView(arrangedSubviews: [nameLabel, nameTextField])
        nameVStack.axis = .vertical
        nameVStack.spacing = 10
        return nameVStack
    }()
    
    private let bioLabel = UILabel(text: "Bio:")
    private lazy var bioTextView: UITextView = {
        let bioTextView = UITextView()
        bioTextView.translatesAutoresizingMaskIntoConstraints = false
        bioTextView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        bioTextView.layer.borderColor = UIColor.systemGray4.cgColor
        bioTextView.layer.borderWidth = 1.0
        bioTextView.layer.cornerRadius = 5.0
        
        return bioTextView
    }()
    
    private lazy var bioVStack: UIStackView = {
        let bioVStack = UIStackView(arrangedSubviews: [bioLabel, bioTextView])
        bioVStack.axis = .vertical
        bioVStack.spacing = 10
        return bioVStack
    }()
    
    private lazy var mainVStack = UIStackView(arrangedSubviews: [
        createProfileLabel,
        nameVStack,
        bioVStack
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

import SwiftUI

struct ViewWrapper: UIViewRepresentable {
    func makeUIView(context: UIViewRepresentableContext<ViewWrapper>) -> UIView {
        return CreateProfileViewController().view
    }

    func updateUIView(_ uiView: ViewWrapper.UIViewType, context: UIViewRepresentableContext<ViewWrapper>) {
    }
}

struct ViewWrapper_Previews: PreviewProvider {
    static var previews: some View {
        ViewWrapper()
    }
}
