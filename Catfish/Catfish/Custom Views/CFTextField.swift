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
        self.init()
        label.text = labelText
        textField.placeholder = placeholderText
    }
    
    func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubviews(label, textField)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.textAlignment = .left
        textField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.heightAnchor.constraint(equalToConstant: 22),
            
            textField.topAnchor.constraint(equalTo: label.bottomAnchor),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor),
            textField.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
}
