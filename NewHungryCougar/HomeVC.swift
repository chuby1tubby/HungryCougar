//
//  HomeVC.swift
//  Hungry Cougar 2.0
//
//  Created by Kyle Nakamura on 8/1/16.
//  Copyright © 2016 Kyle Nakamura. All rights reserved.
//

import UIKit
import Foundation
import Firebase

class HomeVC: UIViewController {
    
    @IBOutlet weak var currentDiningPointsHomeLbl: UILabel!
    @IBOutlet weak var currentCougarBucksHomeLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Campus Restaurants"
        self.navigationController?.navigationBar.tintColor = UIColor.darkGray
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let prefs = UserDefaults.standard
        if let val1 = prefs.string(forKey: "userDiningPointsDefaults") {
            currentDiningPointsHomeLbl.isHidden = false
            currentDiningPointsHomeLbl.text = "Current Dining Points: \(val1)"
        } else {
            currentDiningPointsHomeLbl.isHidden = true
        }
        
        if let val2 = prefs.string(forKey: "userCougarBucksDefaults") {
            currentCougarBucksHomeLbl.isHidden = false
            currentCougarBucksHomeLbl.text = "Current Cougar Bucks: \(val2)"
        } else {
            currentCougarBucksHomeLbl.isHidden = true
        }
    }
}
