//
//  InputAccessoryViewController.swift
//  Catfish
//
//  Created by Shawn Gee on 4/1/20.
//  Copyright © 2020 James Pacheco. All rights reserved.
//

import UIKit

/// Provides an interface to navigate up and down between textFields, and to dismiss textFields when done.
class InputAccessoryViewController: UIViewController {
    
    // MARK: - Public
    
    /// Adds textFields to be managed by the InputAccessoryViewController.
    /// 
    /// Automatically sets the inputAccessoryView of the textFields passed in.
    func register(_ textFields: UITextField...) {
        for textField in textFields {
            textField.inputAccessoryView = view
            NotificationCenter.default.addObserver(self, selector: #selector(handleTextFieldDidBeginEditing(notification:)), name: UITextField.textDidBeginEditingNotification, object: textField)
            textField.autocorrectionType = .no // Needed to fix bug, also looks cleaner
            textField.tag = managedTextFields.count
            managedTextFields.append(textField)
        }
    }
    
    /// Removes managed  textFields from the InputAccessoryViewController
    func unregister(_ textFields: UITextField...) {
        for textField in textFields {
            textField.inputAccessoryView = nil
            NotificationCenter.default.removeObserver(self, name: UITextField.textDidBeginEditingNotification, object: textField)
            if let index = managedTextFields.firstIndex(of: textField) {
                managedTextFields.remove(at: index)
            }
        }
        
        for i in 0..<textFields.count {
            textFields[i].tag = i
        }
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    deinit {
        for textField in managedTextFields {
            NotificationCenter.default.removeObserver(self, name: UITextField.textDidBeginEditingNotification, object: textField)
        }
    }
    
    // MARK: - Private Properties
    
    private var managedTextFields = [UITextField]()
    private var currentTextFieldIndex = 0
    
    private let toolbar = UIToolbar(frame: CGRect.zero)
    private let upButton = UIBarButtonItem(image: UIImage(systemName: "chevron.up"), style: .plain, target: self, action: #selector(upButtonTapped))
    private let downButton = UIBarButtonItem(image: UIImage(systemName: "chevron.down"), style: .plain, target: self, action: #selector(downButtonTapped))
    private let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    private let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
    
    
    // MARK: - Actions
    
    @objc private func upButtonTapped() {
        if currentTextFieldIndex > 0 {
            managedTextFields[currentTextFieldIndex - 1].becomeFirstResponder()
        }
    }
    @objc private func downButtonTapped() {
        if currentTextFieldIndex < managedTextFields.count - 1 {
            managedTextFields[currentTextFieldIndex + 1].becomeFirstResponder()
        }
    }
    @objc private func doneButtonTapped() {
        managedTextFields[currentTextFieldIndex].resignFirstResponder()
    }
    
    @objc func handleTextFieldDidBeginEditing(notification: NSNotification) {
        if let textField = notification.object as? UITextField {
            currentTextFieldIndex = textField.tag
        }
        upButton.isEnabled = currentTextFieldIndex > 0
        downButton.isEnabled = currentTextFieldIndex < managedTextFields.count - 1
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
