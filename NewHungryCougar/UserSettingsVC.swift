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
    @IBOutlet weak var messageLbl: UILabel!
    
    override func viewDidLoad() {
        self.viewDidLoad()
        
        self.navigationController?.navigationBar.barStyle = UIBarStyle.blackTranslucent
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.isTranslucent = true
    }

    override func viewWillAppear(_ animated: Bool) {
        messageLbl.text = "Welcome Back, APU! \n\n" +
            "I worked with IMT to integrate some Hungry Coug features with the APU Mobile app. \n\n" +
            "APU Mobile now displays your Dining Points, Expected Points, as well as tons of other cool features we have been working on. \n\n" +
            "Check everything new out at \nhttps://mobile.apu.edu"
        
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
