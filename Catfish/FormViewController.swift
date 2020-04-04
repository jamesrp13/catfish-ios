//
//  FormViewController.swift
//  Catfish
//
//  Created by Shawn Gee on 4/4/20.
//  Copyright © 2020 James Pacheco. All rights reserved.
//

import UIKit

class FormViewController: UIViewController {
    
    // MARK: - Public
    
    let contentView = UIView()
    let scrollView =  UIScrollView()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    // MARK: - Private
    
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
}
