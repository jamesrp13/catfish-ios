//
//  CFTextField.swift
//  Catfish
//
//  Created by morse on 4/3/20.
//  Copyright © 2020 James Pacheco. All rights reserved.
//

import UIKit

class CFTextField: UIView {
    
    let label = UILabel()
    let textField = UITextField()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(labelText: String, placeholderText: String) {
        self.init(frame: .zero)
        label.text = labelText
        textField.placeholder = placeholderText
    }
    
    func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.clear
        
        addSubviews(label, textField)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.textColor = Colors.labelText
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .left
        
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.cornerRadius = 4
        textField.layer.cornerCurve = .continuous
        textField.layer.borderWidth = 2
        textField.layer.borderColor = Colors.textFieldGray.cgColor
        textField.textAlignment = .left
        textField.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.heightAnchor.constraint(equalToConstant: 14),
            
            textField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 4),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor),
            textField.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
}
