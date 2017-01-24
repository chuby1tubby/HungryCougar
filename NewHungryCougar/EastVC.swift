//
//  EastVC.swift
//  Hungry Cougar 2.0
//
//  Created by Kyle Nakamura on 8/5/16.
//  Copyright © 2016 Kyle Nakamura. All rights reserved.
//

import UIKit

class EastVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func diningHallButtonPressed(_ sender: AnyObject) {
        restaurantChoice = "Dining Hall"
        performSegue(withIdentifier: "restaurantSelected1", sender: nil)
    }
    
    @IBAction func cornerstoneButtonPressed(_ sender: AnyObject) {
        restaurantChoice = "Coffeehouse"
        performSegue(withIdentifier: "restaurantSelected1", sender: nil)
    }
    
    @IBAction func denButtonPressed(_ sender: AnyObject) {
        restaurantChoice = "The Den"
        performSegue(withIdentifier: "restaurantSelected1", sender: nil)
    }
    
    @IBAction func cougarButtonPressed(_ sender: AnyObject) {
        restaurantChoice = "Cougar BBQ"
        performSegue(withIdentifier: "restaurantSelected1", sender: nil)
    }
    
    @IBAction func mexicaliButtonPressed(_ sender: AnyObject) {
        restaurantChoice = "Cali Grill"
        performSegue(withIdentifier: "restaurantSelected1", sender: nil)
    }
    
    @IBAction func pawsButtonPressed(_ sender: AnyObject) {
        restaurantChoice = "Pause 'n Go"
        performSegue(withIdentifier: "restaurantSelected1", sender: nil)
    }
}
