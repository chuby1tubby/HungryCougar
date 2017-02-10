//
//  WestVC.swift
//  Hungry Cougar 2.0
//
//  Created by Kyle Nakamura on 8/5/16.
//  Copyright © 2016 Kyle Nakamura. All rights reserved.
//

import UIKit

class WestVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func grillButtonPressed(_ sender: AnyObject) {
        restaurantChoice = "The Grill at Heritage"
        performSegue(withIdentifier: "restaurantSelected2", sender: nil)
    }
    
    @IBAction func hillsideButtonPressed(_ sender: AnyObject) {
        restaurantChoice = "Hillside Grounds at Heritage"
        performSegue(withIdentifier: "restaurantSelected2", sender: nil)
    }
    
    @IBAction func marketButtonPressed(_ sender: AnyObject) {
        restaurantChoice = "The Market at Heritage"
        performSegue(withIdentifier: "restaurantSelected2", sender: nil)
    }
    
    @IBAction func subsButtonPressed(_ sender: AnyObject) {
        restaurantChoice = "Sam's Subs"
        performSegue(withIdentifier: "restaurantSelected2", sender: nil)
    }
    
    @IBAction func umaiButtonPressed(_ sender: AnyObject) {
        restaurantChoice = "Umai Sushi"
        performSegue(withIdentifier: "restaurantSelected2", sender: nil)
    }
}
