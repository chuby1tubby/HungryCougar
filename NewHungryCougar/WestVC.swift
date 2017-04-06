//
//  WestVC.swift
//  Hungry Cougar 2.0
//
//  Created by Kyle Nakamura on 8/5/16.
//  Copyright © 2016 Kyle Nakamura. All rights reserved.
//

import UIKit
import Firebase

class WestVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DB_BASE.child("stats").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            var firebaseCount = value?["west"] as? Int ?? 0
            firebaseCount += 1
            DB_BASE.child("stats").child("west").setValue(firebaseCount)
        })
    }
    
    @IBAction func grillButtonPressed(_ sender: AnyObject) {
        restaurantChoice = "The Grill at Heritage"
        
        // Count number of views for the restaurant
        DB_BASE.child("venue").child("grill").child("views").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            var firebaseViews = value?["count"] as? Int ?? 0
            firebaseViews += 1
            DB_BASE.child("venue").child("grill").child("views").child("count").setValue(firebaseViews)
        })
        
        performSegue(withIdentifier: "restaurantSelected2", sender: nil)
    }
    
    @IBAction func hillsideButtonPressed(_ sender: AnyObject) {
        restaurantChoice = "Hillside Grounds at Heritage"
        
        // Count number of views for the restaurant
        DB_BASE.child("venue").child("hillside").child("views").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            var firebaseViews = value?["count"] as? Int ?? 0
            firebaseViews += 1
            DB_BASE.child("venue").child("hillside").child("views").child("count").setValue(firebaseViews)
        })
        
        performSegue(withIdentifier: "restaurantSelected2", sender: nil)
    }
    
    @IBAction func marketButtonPressed(_ sender: AnyObject) {
        restaurantChoice = "The Market at Heritage"
        
        // Count number of views for the restaurant
        DB_BASE.child("venue").child("market").child("views").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            var firebaseViews = value?["count"] as? Int ?? 0
            firebaseViews += 1
            DB_BASE.child("venue").child("market").child("views").child("count").setValue(firebaseViews)
        })
        
        performSegue(withIdentifier: "restaurantSelected2", sender: nil)
    }
    
    @IBAction func subsButtonPressed(_ sender: AnyObject) {
        restaurantChoice = "Sam's Subs"
        
        // Count number of views for the restaurant
        DB_BASE.child("venue").child("sams").child("views").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            var firebaseViews = value?["count"] as? Int ?? 0
            firebaseViews += 1
            DB_BASE.child("venue").child("sams").child("views").child("count").setValue(firebaseViews)
        })
        
        performSegue(withIdentifier: "restaurantSelected2", sender: nil)
    }
    
    @IBAction func umaiButtonPressed(_ sender: AnyObject) {
        restaurantChoice = "Umai Sushi"
        
        // Count number of views for the restaurant
        DB_BASE.child("venue").child("umai").child("views").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            var firebaseViews = value?["count"] as? Int ?? 0
            firebaseViews += 1
            DB_BASE.child("venue").child("umai").child("views").child("count").setValue(firebaseViews)
        })
        
        performSegue(withIdentifier: "restaurantSelected2", sender: nil)
    }
}
