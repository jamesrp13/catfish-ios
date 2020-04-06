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
        contentView = createProfileView
        super.viewDidLoad()
        configure()
    }
    
    override func loadView() {
        view = BGGradientView()
    }
    
    // MARK: - Private Properties
    
    private var bioPlaceholderManager: TextViewPlaceholderManager?
    
    private let createProfileView = CreateProfileView()
    
    private lazy var profilePicImageView = createProfileView.profilePicImageView
    private lazy var uploadButton = createProfileView.uploadButton
    private lazy var nameTextField = createProfileView.nameTextField
    private lazy var bioTextView = createProfileView.bioTextView
    private lazy var catfishButton = createProfileView.catfishButton
  
    
    // MARK: - Private Methods
    
    private func configure() {
        bioPlaceholderManager = TextViewPlaceholderManager(textView: bioTextView, placeholder: "Say something about yourself...")
        uploadButton.addTarget(self, action: #selector(uploadButtonTapped), for: .touchUpInside)
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
