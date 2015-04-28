//
//  TextFieldExtension.swift
//  MemeMe
//
//  Created by Ballinger, Colton J. on 4/13/15.
//  Copyright (c) 2015 Ballinger, Colton J. All rights reserved.
//

import UIKit

extension MemeEditorViewController {
    
    func textFieldDidBeginEditing(textField: UITextField) {
        
        textField.placeholder? = ""
        textField.textAlignment = .Center
        textField.autocapitalizationType = UITextAutocapitalizationType.AllCharacters
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        // resigning keyboard when someone touches elsewhere on the screen
        topTextField.resignFirstResponder()
        bottomTextField.resignFirstResponder()
    }
}