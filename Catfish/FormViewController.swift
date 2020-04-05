//
//  FormViewController.swift
//  Catfish
//
//  Created by Shawn Gee on 4/4/20.
//  Copyright © 2020 James Pacheco. All rights reserved.
//

import UIKit

/// A view controller that expands to fit content vertically
/// and responds to keyboard showing in order to not obscure text inputs.
///
/// Add all of your subviews to contentView. If your content should extend beyond the size of the scrollview,
/// be sure to fully define the contentView's height through use of constraints.
/// This view controller also adds an inputAccessoryView to each textField or textView in the content view.
/// This facilitates easy navigation between text inputs.

class FormViewController: UIViewController {
    
    // MARK: - Public
    
    let contentView = UIView()
    let scrollView =  UIScrollView()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if !inputAccessoryConfigured {
            configureInputAccessory()
        }
    }
    
    // MARK: - Private
    
    private let inputAccessoryVC = TextInputAccessoryViewController()
    private var inputAccessoryConfigured = false
    
    private func configureInputAccessory() {
        addChild(inputAccessoryVC)
        inputAccessoryVC.didMove(toParent: self)
        registerTextInputs(in: contentView)
        inputAccessoryConfigured = true
    }
    
    private func registerTextInputs(in view: UIView) {
        for subview in view.subviews {
            if let textField = subview as? UITextField {
                inputAccessoryVC.register(textField)
            } else if let textView = subview as? UITextView {
                inputAccessoryVC.register(textView)
            } else if !subview.subviews.isEmpty {
                registerTextInputs(in: subview)
            }
        }
    }
    
    private func configure() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
            
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
        let weakHeightConstraint = contentView.heightAnchor.constraint(equalTo: scrollView.frameLayoutGuide.heightAnchor)
        weakHeightConstraint.priority = .defaultLow
        weakHeightConstraint.isActive = true
        
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.keyboardDismissMode = .interactive
        
        setupKeyboardNotifications()
    }
    
    // MARK: - Keyboard Handling
    
    private func setupKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextInputBeginEditing), name: UITextField.textDidBeginEditingNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextInputBeginEditing), name: UITextView.textDidBeginEditingNotification, object: nil)
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
        
        let frame = selectedTextInput.frame
        
        guard let convertedFrame = selectedTextInput.superview?.convert(frame, to: view) else { return }
        
        let origin = convertedFrame.origin
        var bottomPoint = origin
        bottomPoint.y += selectedTextInput.frame.maxY
        
        let distanceToTop = origin.y
        let distanceToBottom = view.frame.height - bottomPoint.y
        
        if distanceToTop < 0 {
            let distanceToMove = distanceToTop - frame.height - view.safeAreaInsets.top
            scrollView.contentInset.bottom += distanceToMove
            scrollView.contentInset.top -= distanceToMove
        } else if distanceToBottom < keyboardHeight {
            let distanceToMove = keyboardHeight - distanceToBottom
            scrollView.contentInset.bottom += distanceToMove
            scrollView.contentInset.top -= distanceToMove
        }
        
        self.keyboardHeight = nil
        self.selectedTextInput = nil
    }
}
