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
        restaurantChoice = "1899 Dining Hall"
        performSegue(withIdentifier: "restaurantSelected1", sender: nil)
    }
    
    @IBAction func cornerstoneButtonPressed(_ sender: AnyObject) {
        restaurantChoice = "Cornerstone Coffeehouse"
        performSegue(withIdentifier: "restaurantSelected1", sender: nil)
    }
    
    @IBAction func denButtonPressed(_ sender: AnyObject) {
        restaurantChoice = "Cougar's Den Café"
        performSegue(withIdentifier: "restaurantSelected1", sender: nil)
    }
    
    @IBAction func cougarButtonPressed(_ sender: AnyObject) {
        restaurantChoice = "Cougar Walk Café"
        performSegue(withIdentifier: "restaurantSelected1", sender: nil)
    }
    
    @IBAction func mexicaliButtonPressed(_ sender: AnyObject) {
        restaurantChoice = "Mexicali Grill"
        performSegue(withIdentifier: "restaurantSelected1", sender: nil)
    }
    
    @IBAction func pawsButtonPressed(_ sender: AnyObject) {
        restaurantChoice = "Paws 'N Go Convenience"
        performSegue(withIdentifier: "restaurantSelected1", sender: nil)
    }
}
