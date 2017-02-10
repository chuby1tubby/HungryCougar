//
//  HomeVC.swift
//  Hungry Cougar 2.0
//
//  Created by Kyle Nakamura on 8/1/16.
//  Copyright © 2016 Kyle Nakamura. All rights reserved.
//

import UIKit
import Foundation

class HomeVC: UIViewController {
    @IBOutlet weak var currentDiningPointsHomeLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Campus Restaurants"
        self.navigationController?.navigationBar.tintColor = UIColor.darkGray
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let prefs = UserDefaults.standard
        if let value = prefs.string(forKey: "userDiningPointsDefaults") {
            currentDiningPointsHomeLbl.isHidden = false
            currentDiningPointsHomeLbl.text = "Current Dining Points: \(value)"
        } else {
            currentDiningPointsHomeLbl.isHidden = true
        }
    }
}
