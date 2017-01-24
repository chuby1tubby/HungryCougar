//
//  UserSettingsVC.swift
//  Hungry Cougar 2.0
//
//  Created by Kyle Nakamura on 1/21/17.
//  Copyright © 2017 Kyle Nakamura. All rights reserved.
//

import UIKit

class UserSettingsVC: UIViewController, UITextFieldDelegate {
    
    // Outlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!

    override func viewWillAppear(_ animated: Bool) {
        usernameField.delegate = self
        passwordField.delegate = self
        
        scrollView.contentSize.height = 700
        
        let prefs = UserDefaults.standard
        if let name = prefs.string(forKey: "username") {
            if let pass = prefs.string(forKey: "password") {
                usernameStr = name
                passwordStr = pass
                usernameField.text = usernameStr
                passwordField.text = passwordStr
            }
        }
    }
    
    // Alert user that navigation away from Dining Services is denied
    func presentAlertToUser() {
        let alert = UIAlertController(title: "Details Saved", message: "Your user login information has been saved.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func updateUserData() {
        let defaults = UserDefaults.standard
        defaults.set(usernameField.text, forKey: "username")
        defaults.set(passwordField.text, forKey: "password")
        defaults.set(true, forKey: "userSavedDetails")
        
        presentAlertToUser()
    }
    
    // Allow user to save their information
    @IBAction func updateData(_ sender: Any) {
        updateUserData()
    }
    
    @IBAction func userTouchedBackground(_ sender: Any) {
        view.endEditing(true)
        usernameField.resignFirstResponder()
        passwordField.resignFirstResponder()
    }
    
    @IBAction func phoneLabelTapped(_ sender: Any) {
        let url = URL(string: "tel://6263885416")
        UIApplication.shared.openURL(url!)
    }
    
    @IBAction func emailLabelTapped(_ sender: Any) {
        let url = URL(string: "mailto:knakamura13@apu.edu")
        UIApplication.shared.openURL(url!)
    }
    
    // Jump from usernameField to passwordField, then hide the keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameField {
            passwordField.becomeFirstResponder()
        } else {
            usernameField.resignFirstResponder()
            passwordField.resignFirstResponder()
            
            updateUserData()
        }
        return true
    }
}
