//
//  TermsVC.swift
//  NewHungryCougar
//
//  Created by Kyle Nakamura on 3/24/17.
//  Copyright © 2017 Kyle Nakamura. All rights reserved.
//

import UIKit

class TermsVC: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        textView.scrollRangeToVisible(NSRange(location:0, length:0))
    }
    
    @IBAction func dismissTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
