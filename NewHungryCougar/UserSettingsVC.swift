//
//  UserSettingsVC.swift
//  Hungry Cougar 2.0
//
//  Created by Kyle Nakamura on 1/21/17.
//  Copyright © 2017 Kyle Nakamura. All rights reserved.
//

import UIKit
import Locksmith

class UserSettingsVC: UIViewController, UITextFieldDelegate {
    
    // Outlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var versionNumberLbl: UILabel!

    override func viewWillAppear(_ animated: Bool) {
        usernameField.delegate = self
        passwordField.delegate = self
        scrollView.contentSize.height = 700
        
        // Retrieve from Keychain
        if let dictionary = Locksmith.loadDataForUserAccount(userAccount: "userAccount") {
            if let keyVal1 = dictionary["keychainUsername"] {
                if let keyVal2 = dictionary["keychainPassword"] {
                    usernameField.text = keyVal1 as! String
                    passwordField.text = keyVal2 as! String
                }
            }
        }
        
        // Retreive current app version number
        let nsObject: AnyObject? = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as AnyObject
        if let version = nsObject as? String {
            versionNumberLbl.text = "Version: \(version)"
        } else {
            versionNumberLbl.isHidden = true
        }
        
        
        DB_BASE.child("stats").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            var firebaseCount = value?["settings"] as? Int ?? 0
            firebaseCount += 1
            DB_BASE.child("stats").child("settings").setValue(firebaseCount)
        })
    }
    
    // Alert user that navigation away from Dining Services is denied
    func presentAlertToUser() {
        let alert = UIAlertController(title: "Details Saved", message: "Your user login information has been saved.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func updateUserData() {
        var str = usernameField.text
        if let dotRange = str?.range(of: "@") { // Scrub username input after the @ character
            str?.removeSubrange(dotRange.lowerBound..<(str?.endIndex)!)
        }
        
        // Keychain
        do {
            try Locksmith.updateData(data: ["keychainUsername":str!, "keychainPassword":passwordField.text!], forUserAccount: "userAccount")
        } catch {
            // Could not save data to keychain
        }

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
