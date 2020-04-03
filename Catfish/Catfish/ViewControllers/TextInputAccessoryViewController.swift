//
//  TextInputAccessoryViewController.swift
//  Catfish
//
//  Created by Shawn Gee on 4/1/20.
//  Copyright © 2020 James Pacheco. All rights reserved.
//

import UIKit

/// Provides an interface to navigate up and down between textInputs, and to dismiss textInputs when done.
///
/// textInputs passed in should either be either UITextField or UITextView
class TextInputAccessoryViewController: UIViewController {
    
    // MARK: - Public
    
    /// Adds textInputs to be managed by the InputAccessoryViewController.
    /// 
    /// Automatically sets the inputAccessoryView of the textFields passed in.
    func register(_ textInputs: UIView...) {
        for textInput in textInputs {
            if let textField = textInput as? UITextField {
                textField.inputAccessoryView = view
                NotificationCenter.default.addObserver(self, selector: #selector(handleTextInputDidBeginEditing(notification:)), name: UITextField.textDidBeginEditingNotification, object: textField)
                textField.autocorrectionType = .no // Needed to fix bug, also looks cleaner
                
            } else if let textView = textInput as? UITextView {
                textView.inputAccessoryView = view
                NotificationCenter.default.addObserver(self, selector: #selector(handleTextInputDidBeginEditing(notification:)), name: UITextView.textDidBeginEditingNotification, object: textView)
                textView.autocorrectionType = .no
            }
            
            textInput.tag = managedTextInputs.count
            managedTextInputs.append(textInput)
        }
    }
    
    /// Removes managed textInputs from the InputAccessoryViewController
    func unregister(_ textInputs: UIView...) {
        for textInput in textInputs {
            if let textField = textInput as? UITextField {
                textField.inputAccessoryView = nil
                NotificationCenter.default.removeObserver(self, name: UITextField.textDidBeginEditingNotification, object: textField)
            } else if let textView = textInput as? UITextView {
                textView.inputAccessoryView = nil
                NotificationCenter.default.removeObserver(self, name: UITextView.textDidBeginEditingNotification, object: textView)
            }
            
            if let index = managedTextInputs.firstIndex(of: textInput) {
                managedTextInputs.remove(at: index)
            }
        }
        
        for i in 0..<textInputs.count {
            textInputs[i].tag = i
        }
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    deinit {
        for textInput in managedTextInputs {
            if let textField = textInput as? UITextField {
                NotificationCenter.default.removeObserver(self, name: UITextField.textDidBeginEditingNotification, object: textField)
            } else if let textView = textInput as? UITextView {
                NotificationCenter.default.removeObserver(self, name: UITextView.textDidBeginEditingNotification, object: textView)
            }
        }
    }
    
    // MARK: - Private Properties
    
    private var managedTextInputs = [UIView]()
    private var currentTextInputIndex = 0
    
    private let toolbar = UIToolbar(frame: CGRect.zero)
    private let upButton = UIBarButtonItem(image: UIImage(systemName: "chevron.up"), style: .plain, target: self, action: #selector(upButtonTapped))
    private let downButton = UIBarButtonItem(image: UIImage(systemName: "chevron.down"), style: .plain, target: self, action: #selector(downButtonTapped))
    private let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    private let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
    
    
    // MARK: - Actions
    
    @objc private func upButtonTapped() {
        if currentTextInputIndex > 0 {
            managedTextInputs[currentTextInputIndex - 1].becomeFirstResponder()
        }
    }
    @objc private func downButtonTapped() {
        if currentTextInputIndex < managedTextInputs.count - 1 {
            managedTextInputs[currentTextInputIndex + 1].becomeFirstResponder()
        }
    }
    @objc private func doneButtonTapped() {
        managedTextInputs[currentTextInputIndex].resignFirstResponder()
    }
    
    @objc func handleTextInputDidBeginEditing(notification: NSNotification) {
        if let textInput = notification.object as? UIView {
            currentTextInputIndex = textInput.tag
        }
        upButton.isEnabled = currentTextInputIndex > 0
        downButton.isEnabled = currentTextInputIndex < managedTextInputs.count - 1
    }
    
    // MARK: - Private Methods
    
    private func configure() {
        view.frame = CGRect(x: 0, y: 0, width: 0, height: 44)
        
        toolbar.setItems([upButton, downButton, spacer, doneButton], animated: false)
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(toolbar)
        
        NSLayoutConstraint.activate([
            toolbar.topAnchor.constraint(equalTo: view.topAnchor),
            toolbar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            toolbar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            toolbar.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}
