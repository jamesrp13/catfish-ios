//
//  UITextField+Convenience.swift
//  Catfish
//
//  Created by Shawn Gee on 4/1/20.
//  Copyright © 2020 James Pacheco. All rights reserved.
//

import UIKit

extension UITextField {
    convenience init(placeholder: String? = nil, font: UIFont? = .systemFont(ofSize: 14), color: UIColor = .black, keyboardType: UIKeyboardType = .default, borderStyle: UITextField.BorderStyle = .roundedRect) {
        self.init()
        self.placeholder = placeholder
        self.font = font
        self.textColor = textColor
        self.keyboardType = keyboardType
        self.borderStyle = borderStyle
    }
}
