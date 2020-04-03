//
//  PickerTextFieldManager.swift
//  Catfish
//
//  Created by Shawn Gee on 4/3/20.
//  Copyright © 2020 James Pacheco. All rights reserved.
//

import UIKit

/// Manages a UITextField's input using a UIPickerView.
///
/// Note that this class sets the text field's delegate to itself in order to disable manual editing.
class PickerTextFieldManager: NSObject, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    
    // MARK: - Public
    
    var options: [String]
    let textField: UITextField
    
    // MARK: - Init
    
    init(textField: UITextField, options: [String], initialIndex: Int) {
        self.textField = textField
        self.options = options
        
        super.init()
        
        textField.inputView = picker
        textField.delegate = self
        
        picker.dataSource = self
        picker.delegate = self
        picker.selectRow(initialIndex, inComponent: 0, animated: false)
    }
    
    // MARK: - Private
    
    private var initialIndex = 0
    private let picker = UIPickerView()
    
    // MARK: - Picker Delegate & Data Source
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        options.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        options[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textField.text = options[row]
    }
    
    // MARK: - Text Field Delegate
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        false
    }
}
