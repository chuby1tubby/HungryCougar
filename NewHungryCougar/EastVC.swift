//
//  EastVC.swift
//  Hungry Cougar 2.0
//
//  Created by Kyle Nakamura on 8/5/16.
//  Copyright © 2016 Kyle Nakamura. All rights reserved.
//

import UIKit
import Firebase

class EastVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barStyle = UIBarStyle.blackTranslucent
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.isTranslucent = true
        
        DB_BASE.child("stats").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            var firebaseCount = value?["east"] as? Int ?? 0
            firebaseCount += 1
            DB_BASE.child("stats").child("east").setValue(firebaseCount)
        })
    }
    
    @IBAction func diningHallButtonPressed(_ sender: AnyObject) {
        restaurantChoice = "1899 Dining Hall"
        
        // Count number of views for the restaurant
        DB_BASE.child("venue2").child("1899").child("views").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            var firebaseViews = value?["count"] as? Int ?? 0
            firebaseViews += 1
            DB_BASE.child("venue2").child("1899").child("views").child("count").setValue(firebaseViews)
        })
        
        performSegue(withIdentifier: "restaurantSelected1", sender: nil)
    }
    
    @IBAction func cornerstoneButtonPressed(_ sender: AnyObject) {
        restaurantChoice = "Cornerstone Coffeehouse"
        
        // Count number of views for the restaurant
        DB_BASE.child("venue2").child("cornerstone").child("views").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            var firebaseViews = value?["count"] as? Int ?? 0
            firebaseViews += 1
            DB_BASE.child("venue2").child("cornerstone").child("views").child("count").setValue(firebaseViews)
        })
        
        performSegue(withIdentifier: "restaurantSelected1", sender: nil)
    }
    
    @IBAction func denButtonPressed(_ sender: AnyObject) {
        restaurantChoice = "Cougar's Den Café"
        
        // Count number of views for the restaurant
        DB_BASE.child("venue2").child("den").child("views").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            var firebaseViews = value?["count"] as? Int ?? 0
            firebaseViews += 1
            DB_BASE.child("venue2").child("den").child("views").child("count").setValue(firebaseViews)
        })
        
        performSegue(withIdentifier: "restaurantSelected1", sender: nil)
    }
    
    @IBAction func cougarButtonPressed(_ sender: AnyObject) {
        restaurantChoice = "Cougar Walk Café"
        
        // Count number of views for the restaurant
        DB_BASE.child("venue2").child("cafe").child("views").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            var firebaseViews = value?["count"] as? Int ?? 0
            firebaseViews += 1
            DB_BASE.child("venue2").child("cafe").child("views").child("count").setValue(firebaseViews)
        })
        
        performSegue(withIdentifier: "restaurantSelected1", sender: nil)
    }
    
    @IBAction func mexicaliButtonPressed(_ sender: AnyObject) {
        restaurantChoice = "Mexicali Grill"
        
        // Count number of views for the restaurant
        DB_BASE.child("venue2").child("mexicali").child("views").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            var firebaseViews = value?["count"] as? Int ?? 0
            firebaseViews += 1
            DB_BASE.child("venue2").child("mexicali").child("views").child("count").setValue(firebaseViews)
        })
        
        performSegue(withIdentifier: "restaurantSelected1", sender: nil)
    }
    
    @IBAction func pawsButtonPressed(_ sender: AnyObject) {
        restaurantChoice = "Paws 'N Go Convenience"
        
        // Count number of views for the restaurant
        DB_BASE.child("venue2").child("pawsngo").child("views").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            var firebaseViews = value?["count"] as? Int ?? 0
            firebaseViews += 1
            DB_BASE.child("venue2").child("pawsngo").child("views").child("count").setValue(firebaseViews)
        })
        
        performSegue(withIdentifier: "restaurantSelected1", sender: nil)
    }
}
