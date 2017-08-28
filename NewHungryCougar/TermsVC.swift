//
//  TermsVC.swift
//  NewHungryCougar
//
//  Created by Kyle Nakamura on 3/24/17.
//  Copyright © 2017 Kyle Nakamura. All rights reserved.
//

import UIKit
import Firebase

class TermsVC: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Count number of views for the button
        DB_BASE.child("stats").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            var firebaseCount = value?["terms"] as? Int ?? 0
            firebaseCount += 1
            DB_BASE.child("stats").child("terms").setValue(firebaseCount)
        })
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        textView.text =
            "1. You acknowledge that Hungry Coug was not developed by APU, but rather students Kyle Nakamura and Monte Thigpen.\n" +
            "2. You acknowledge that the restaurant hours reflected inside Hungry Coug may be different from the actual hours due to holidays, closes, or unforeseen changes.\n" +
            "3. You acknowledge that Hungry Coug logs anonymous statistics such as the number of times the app is opened or how many times The Den was chosen to view hours.\n" +
            "4. You acknowledge that you will direct any and all questions to Kyle Nakamura (knakamura13@apu.edu) or Monte Thigpen (mthigpen13@apu.edu) and not IMT or any other department affiliated with APU.\n" +
            "5. You acknowledge that Hungry Coug is not responsible for any personal damages that are resulted from breaking the TERMS OF SERVICE Agreement.\n" +
            "6. You acknowledge that by using Hungry Coug you agree to all the TERMS OF SERVICE."
    }
    
    override func viewDidAppear(_ animated: Bool) {
        textView.scrollRangeToVisible(NSMakeRange(0, 0))
    }
    
    @IBAction func dismissTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
