//
//  UserSettingsVC.swift
//  Hungry Cougar 2.0
//
//  Created by Kyle Nakamura on 1/21/17.
//  Copyright © 2017 Kyle Nakamura. All rights reserved.
//

import UIKit
import Locksmith

class UserSettingsVC: UIViewController {
    
    // Outlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var versionNumberLbl: UILabel!

    override func viewWillAppear(_ animated: Bool) {
        // Keychain
        do {
            try Locksmith.updateData(data: ["keychainUsername":"", "keychainPassword":""], forUserAccount: "userAccount")
        } catch {
            // Could not save data to keychain
        }
        
        scrollView.contentSize.height = 700
        
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

    @IBAction func emailLabelTapped(_ sender: Any) {
        let url = URL(string: "mailto:knakamura13@apu.edu")
        UIApplication.shared.openURL(url!)
    }
}
