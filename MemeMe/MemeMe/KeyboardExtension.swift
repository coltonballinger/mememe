//
//  KeyboardExtension.swift
//  MemeMe
//
//  Created by Ballinger, Colton J. on 4/14/15.
//  Copyright (c) 2015 Ballinger, Colton J. All rights reserved.
//

import Foundation
import UIKit

extension MemeEditorViewController {
    
    // creating this extension to make the ViewController more readable and less congested
    
    // setting up the function to pass to the NSNotificationCenter to show the keyboard
    func keyboardWillShow(notification: NSNotification) {
        
        if bottomTextField.isFirstResponder() {
            self.view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    // same as above, but hiding the keybaord after finished.
    func keyboardWillHide(notification: NSNotification) {
        
        if bottomTextField.isFirstResponder() {
            self.view.frame.origin.y += getKeyboardHeight(notification)
        }
    }
    
    func subscribeToShowNotification() {
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
    }
    
    func subscribeToHideNotification() {
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeToShowNotification() {
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
    }
    
    func unsubscribeToHideNotification() {
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    // the guts that shows how far the screen needs to move up based upon the size of the keyboard
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        
        
        let userInfo = notification.userInfo // this associates the notification object to the userInfo dictionary
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as? NSValue // setting size to an object in userInfo
        
        return keyboardSize!.CGRectValue().height // returning the keyboardSize as CGRectValue to use in keyboardWillShow
    }
}