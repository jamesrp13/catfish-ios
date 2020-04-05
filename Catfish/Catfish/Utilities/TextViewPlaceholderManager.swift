//
//  TextViewPlaceholderManager.swift
//  Catfish
//
//  Created by Shawn Gee on 4/3/20.
//  Copyright © 2020 James Pacheco. All rights reserved.
//

import UIKit

class TextViewPlaceholderManager {
    
    // MARK: - Public
    
    var textColor: UIColor
    var placeholder: String
    var placeholderTextColor: UIColor = .lightGray
    
    // MARK: - Init
    
    init(textView: UITextView, placeholder: String, textColor: UIColor = .black) {
        self.textView = textView
        self.placeholder = placeholder
        self.textColor = textColor
        
        configure()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Private
    
    private let textView: UITextView
    
    private func configure() {
        textView.textColor = placeholderTextColor
        textView.text = placeholder
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextInputDidBeginEditing(notification:)), name: UITextView.textDidBeginEditingNotification, object: textView)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextInputDidEndEditing(notification:)), name: UITextView.textDidEndEditingNotification, object: textView)
    }
    
    // MARK: - Notifications
    
    @objc func handleTextInputDidBeginEditing(notification: NSNotification) {
        if let textView = notification.object as? UITextView {
            textView.text = ""
            textView.textColor = textColor
        }
    }
    
    @objc func handleTextInputDidEndEditing(notification: NSNotification) {
        if let textView = notification.object as? UITextView {
            if textView.text.isEmpty {
                textView.text = placeholder
                textView.textColor = placeholderTextColor
            }
        }
    }
}
