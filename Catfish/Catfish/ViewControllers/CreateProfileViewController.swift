//
//  CreateProfileViewController.swift
//  Catfish
//
//  Created by Shawn Gee on 4/3/20.
//  Copyright © 2020 James Pacheco. All rights reserved.
//

import UIKit

class CreateProfileViewController: FormViewController {
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    // MARK: - Private Properties
    
    private let inputAccessoryVC = TextInputAccessoryViewController()
    private var textViewPlaceholderManager: TextViewPlaceholderManager?
    
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
    
    private let profilePicImageView: CircularImageView = {
        let profilePic = CircularImageView(width: 150, image: UIImage(systemName: "person.circle.fill"))
        profilePic.tintColor = Colors.purple
        return profilePic
    }()
    private let uploadButton: UIButton = {
        let uploadButton = UIButton(type: .system)
        uploadButton.setTitle("Upload your Catfish profile picture", for: .normal)
        uploadButton.setTitleColor(Colors.purple, for: .normal)
        uploadButton.titleLabel?.font = .systemFont(ofSize: 16)
        uploadButton.addTarget(self, action: #selector(uploadButtonTapped), for: .touchUpInside)
        return uploadButton
    }()
    private lazy var profilePicVStack: UIStackView = {
        let profilePicVStack = UIStackView(arrangedSubviews: [profilePicImageView, uploadButton])
        profilePicVStack.axis = .vertical
        profilePicVStack.alignment = .center
        
        return profilePicVStack
    }()
    
    private let bioLabel = UILabel(text: "Bio:")
    private let bioPlaceholder = "Say something about yourself..."
    private lazy var bioTextView: UITextView = {
        let bioTextView = UITextView()
        bioTextView.translatesAutoresizingMaskIntoConstraints = false
        bioTextView.heightAnchor.constraint(equalToConstant: 220).isActive = true
        
        bioTextView.layer.borderColor = UIColor.systemGray4.cgColor
        bioTextView.layer.borderWidth = 1.0
        bioTextView.layer.cornerRadius = 5.0
        
        textViewPlaceholderManager = TextViewPlaceholderManager(textView: bioTextView, placeholder: bioPlaceholder)
        return bioTextView
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
   
    private let catfishButton = CFButton(backgroundColor: Colors.purple, title: "Catfish!", image: nil)
    
    // MARK: - Private Methods
    
    private func configure() {
        view.backgroundColor = .white
        
        addChild(inputAccessoryVC)
        inputAccessoryVC.didMove(toParent: self)
        inputAccessoryVC.register(nameTextField, bioTextView)
        
        mainVStack.translatesAutoresizingMaskIntoConstraints = false
        catfishButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubviews(mainVStack, catfishButton)
        
        NSLayoutConstraint.activate([
            mainVStack.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainVStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainVStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            catfishButton.topAnchor.constraint(equalTo: mainVStack.bottomAnchor, constant: 20),
            catfishButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            catfishButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    // MARK: - Actions
    
    @objc private func uploadButtonTapped() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.mediaTypes = ["public.image"]
        present(imagePicker, animated: true)
    }
}

//MARK: - Image Picker Controller Delegate

extension CreateProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        profilePicImageView.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        picker.dismiss(animated: true)
    }
}




// Uncomment below to enable SwiftUI previews for visual feedback

//import SwiftUI
//
//struct ViewWrapper: UIViewRepresentable {
//    func makeUIView(context: UIViewRepresentableContext<ViewWrapper>) -> UIView {
//        return CreateProfileViewController().view
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
