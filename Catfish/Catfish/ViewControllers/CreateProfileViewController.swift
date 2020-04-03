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
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        let contentView = UIView()
        
        mainVStack.translatesAutoresizingMaskIntoConstraints = false
        catfishButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubviews(mainVStack, catfishButton)
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            mainVStack.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainVStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainVStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            catfishButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            catfishButton.topAnchor.constraint(equalTo: mainVStack.bottomAnchor, constant: 20),
            
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            
            contentView.heightAnchor.constraint(equalTo: scrollView.frameLayoutGuide.heightAnchor, multiplier: 1, constant: 0),
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor, multiplier: 1, constant: 0),
        ])

        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.keyboardDismissMode = .interactive
        scrollView.isUserInteractionEnabled = true
        return scrollView
    }()
    
    // MARK: - Private Methods
    
    private func configure() {
        view.backgroundColor = .white
        
        addChild(inputAccessoryVC)
        inputAccessoryVC.didMove(toParent: self)
        inputAccessoryVC.register(nameTextField, bioTextView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
        setupKeyboardNotifications()
    }
    
    // MARK: - Keyboard Handling
    
    private func setupKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextInputBeginEditing), name: UITextField.textDidBeginEditingNotification, object: nameTextField)
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextInputBeginEditing), name: UITextView.textDidBeginEditingNotification, object: bioTextView)
    }
    
    @objc private func handleTextInputBeginEditing(notification: Notification) {
        guard let textInput = notification.object as? UIView else { return }
        selectedTextInput = textInput
    }
    
    @objc private func handleKeyboardShow(notification: Notification) {
        guard let value = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardFrame = value.cgRectValue
        
        keyboardHeight = keyboardFrame.height
        
        scrollView.alwaysBounceVertical = true
    }
    
    @objc private func handleKeyboardHide() {
        scrollView.contentInset.bottom = 0
        scrollView.contentInset.top = 0
        
        scrollView.alwaysBounceVertical = false
    }
    
    private var keyboardHeight: CGFloat? { didSet { moveForKeyboard() }}
    
    private var selectedTextInput: UIView? { didSet { moveForKeyboard() }}
    
    private func moveForKeyboard() {
        guard let selectedTextInput = selectedTextInput,
        let keyboardHeight = keyboardHeight else { return }
        
        var bottomPoint = selectedTextInput.frame.origin
        bottomPoint.y += selectedTextInput.frame.maxY
        
        guard let point = selectedTextInput.superview?.convert(bottomPoint, to: view) else { return }
        
        let distanceToBottom = view.frame.height - point.y
        
        let distanceToMove = keyboardHeight - distanceToBottom
        
        scrollView.contentInset.bottom += distanceToMove
        scrollView.contentInset.top -= distanceToMove
        
        self.keyboardHeight = nil
        self.selectedTextInput = nil
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
