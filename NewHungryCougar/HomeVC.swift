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
import Locksmith

/*
 *  Global hours variables
 */
// Dining Hall
var diningHallOpenBMonFri = 0
var diningHallOpenLMonFri = 0
var diningHallOpenDMonFri = 0
var diningHallOpenSat = 0
var diningHallOpenSun = 0
var diningHallCloseBMonFri = 0
var diningHallCloseLMonFri = 0
var diningHallCloseDMonFri = 0
var diningHallCloseSat = 0
var diningHallCloseSun = 0
// Cornerstone
var cornerstoneOpenMonThur = 0
var cornerstoneOpenFri = 0
var cornerstoneOpenSat = 0
var cornerstoneOpenSun = 0
var cornerstoneCloseMonThur = 0
var cornerstoneCloseFri = 0
var cornerstoneCloseSat = 0
var cornerstoneCloseSun = 0
// Cougars' Den
var denOpenMonThur = 0
var denOpenFri = 0
var denOpenSat = 0
var denOpenSun = 0
var denCloseMonThur = 0
var denCloseFri = 0
var denCloseSat = 0
var denCloseSun = 0
// Café
var cafeOpenMonFri = 0
var cafeOpenSat = 0
var cafeOpenSun = 0
var cafeCloseMonFri = 0
var cafeCloseSat = 0
var cafeCloseSun = 0
// Mexicali
var mexicaliOpenMonThur = 0
var mexicaliOpenFri = 0
var mexicaliOpenSat = 0
var mexicaliOpenSun = 0
var mexicaliCloseMonThur = 0
var mexicaliCloseFri = 0
var mexicaliCloseSat = 0
var mexicaliCloseSun = 0
// Paws N' Go
var pawsOpenMonThur = 0
var pawsOpenFri = 0
var pawsOpenSat = 0
var pawsOpenSun = 0
var pawsCloseMonThur = 0
var pawsCloseFri = 0
var pawsCloseSat = 0
var pawsCloseSun = 0
// Heritage Grill
var grillOpenBMonThur = 0
var grillOpenLMonThur = 0
var grillOpenBFri = 0
var grillOpenLFri = 0
var grillOpenSat = 0
var grillOpenSun = 0
var grillCloseBMonThur = 0
var grillCloseLMonThur = 0
var grillCloseBFri = 0
var grillCloseLFri = 0
var grillCloseSat = 0
var grillCloseSun = 0
// Hillside Grounds
var hillsideOpenMonThur = 0
var hillsideOpenFri = 0
var hillsideOpenSat = 0
var hillsideOpenSun = 0
var hillsideCloseMonThur = 0
var hillsideCloseFri = 0
var hillsideCloseSat = 0
var hillsideCloseSun = 0
// The Market
var marketOpenMonThur = 0
var marketOpenFri = 0
var marketOpenSat = 0
var marketOpenSun = 0
var marketCloseMonThur = 0
var marketCloseFri = 0
var marketCloseSat = 0
var marketCloseSun = 0
// Sam's Subs
var samsOpenMonThur = 0
var samsOpenFri = 0
var samsOpenSat = 0
var samsOpenSun = 0
var samsCloseMonThur = 0
var samsCloseFri = 0
var samsCloseSat = 0
var samsCloseSun = 0
// Umai Sushi
var umaiOpenMonThur = 0
var umaiOpenFri = 0
var umaiOpenSat = 0
var umaiOpenSun = 0
var umaiCloseMonThur = 0
var umaiCloseFri = 0
var umaiCloseSat = 0
var umaiCloseSun = 0

class HomeVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Campus Restaurants"
        
        self.navigationController?.navigationBar.barStyle = UIBarStyle.blackTranslucent
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DB_BASE.child("stats").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            var firebaseCount = value?["home"] as? Int ?? 0
            firebaseCount += 1
            DB_BASE.child("stats").child("home").setValue(firebaseCount)
        })
        
        var updatedVersionNum = 0
        DB_BASE.observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            updatedVersionNum = value?["hourVersion2"] as? Int ?? 0
            
            let prefs = UserDefaults.standard
            if let userVersionNum = prefs.string(forKey: "downloadedHoursVersionNum") {
                if Int(userVersionNum) != updatedVersionNum {
                    self.downloadHours()
                    let defaults = UserDefaults.standard
                    defaults.set(updatedVersionNum, forKey: "downloadedHoursVersionNum")
                } else {
                    // Do not update the hours
                }
            } else {
                self.downloadHours()
                let defaults = UserDefaults.standard
                defaults.set(updatedVersionNum, forKey: "downloadedHoursVersionNum")
            }
            setHours()
        })
    }
    
    @IBAction func termsOfServiceTapped(_ sender: Any) {
        // Action Code
    }
    
    /*
     *  downloadHours()
     Description:    Load Firebase and download open and close times for each restaurant, all at the same time.
     Save each downloaded time as a string in UserDefaults. These numbers will be retreived later in RestaurantHours.swift
     This process takes only a matter of milliseconds.
     */
    func downloadHours() {
        let defaults = UserDefaults.standard
        
        /*
         *  1899 Dining Hall
         */
        
        // Monday through Friday
        DB_BASE.child("venue2").child("1899").child("day").child("MonFri").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            diningHallOpenBMonFri = value?["openBMonFri"] as? Int ?? 0
            diningHallOpenLMonFri = value?["openLMonFri"] as? Int ?? 0
            diningHallOpenDMonFri = value?["openDMonFri"] as? Int ?? 0
            diningHallCloseBMonFri = value?["closeBMonFri"] as? Int ?? 0
            diningHallCloseLMonFri = value?["closeLMonFri"] as? Int ?? 0
            diningHallCloseDMonFri = value?["closeDMonFri"] as? Int ?? 0
            
            defaults.set(diningHallOpenBMonFri, forKey: "diningHallOpenBMonFri")
            defaults.set(diningHallOpenLMonFri, forKey: "diningHallOpenLMonFri")
            defaults.set(diningHallOpenDMonFri, forKey: "diningHallOpenDMonFri")
            defaults.set(diningHallCloseBMonFri, forKey: "diningHallCloseBMonFri")
            defaults.set(diningHallCloseLMonFri, forKey: "diningHallCloseLMonFri")
            defaults.set(diningHallCloseDMonFri, forKey: "diningHallCloseDMonFri")
        })
        // Saturday
        DB_BASE.child("venue2").child("1899").child("day").child("Sat").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            diningHallOpenSat = value?["openSat"] as? Int ?? 0
            diningHallCloseSat = value?["closeSat"] as? Int ?? 0
            
            defaults.set(diningHallOpenSat, forKey: "diningHallOpenSat")
            defaults.set(diningHallCloseSat, forKey: "diningHallCloseSat")
        })
        // Sunday
        DB_BASE.child("venue2").child("1899").child("day").child("Sun").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            diningHallOpenSun = value?["openSun"] as? Int ?? 0
            diningHallCloseSun = value?["closeSun"] as? Int ?? 0
            
            defaults.set(diningHallOpenSun, forKey: "diningHallOpenSun")
            defaults.set(diningHallCloseSun, forKey: "diningHallCloseSun")
        })
        
        /*
         *  Cornerstone Coffeehouse
         */
        
        // Monday through Thursday
        DB_BASE.child("venue2").child("cornerstone").child("day").child("MonThur").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            cornerstoneOpenMonThur = value?["openMonThur"] as? Int ?? 0
            cornerstoneCloseMonThur = value?["closeMonThur"] as? Int ?? 0
            
            defaults.set(cornerstoneOpenMonThur, forKey: "cornerstoneOpenMonThur")
            defaults.set(cornerstoneCloseMonThur, forKey: "cornerstoneCloseMonThur")
        })
        // Friday
        DB_BASE.child("venue2").child("cornerstone").child("day").child("Fri").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            cornerstoneOpenFri = value?["openFri"] as? Int ?? 0
            cornerstoneCloseFri = value?["closeFri"] as? Int ?? 0
            
            defaults.set(cornerstoneOpenFri, forKey: "cornerstoneOpenFri")
            defaults.set(cornerstoneCloseFri, forKey: "cornerstoneCloseFri")
        })
        // Saturday
        DB_BASE.child("venue2").child("cornerstone").child("day").child("Sat").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            cornerstoneOpenSat = value?["openSat"] as? Int ?? 0
            cornerstoneCloseSat = value?["closeSat"] as? Int ?? 0
            
            defaults.set(cornerstoneOpenSat, forKey: "cornerstoneOpenSat")
            defaults.set(cornerstoneCloseSat, forKey: "cornerstoneCloseSat")
        })
        // Sunday
        DB_BASE.child("venue2").child("cornerstone").child("day").child("Sun").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            cornerstoneOpenSun = value?["openSun"] as? Int ?? 0
            cornerstoneCloseSun = value?["closeSun"] as? Int ?? 0
            
            defaults.set(cornerstoneOpenSun, forKey: "cornerstoneOpenSun")
            defaults.set(cornerstoneCloseSun, forKey: "cornerstoneCloseSun")
        })
        
        /*
         *  Cougars' Den Café
         */
        
        // Monday through Thursday
        DB_BASE.child("venue2").child("den").child("day").child("MonThur").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            denOpenMonThur = value?["openMonThur"] as? Int ?? 0
            denCloseMonThur = value?["closeMonThur"] as? Int ?? 0
            
            defaults.set(denOpenMonThur, forKey: "denOpenMonThur")
            defaults.set(denCloseMonThur, forKey: "denCloseMonThur")
        })
        // Friday
        DB_BASE.child("venue2").child("den").child("day").child("Fri").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            denOpenFri = value?["openFri"] as? Int ?? 0
            denCloseFri = value?["closeFri"] as? Int ?? 0
            
            defaults.set(denOpenFri, forKey: "denOpenFri")
            defaults.set(denCloseFri, forKey: "denCloseFri")
        })
        // Saturday
        DB_BASE.child("venue2").child("den").child("day").child("Sat").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            denOpenSat = value?["openSat"] as? Int ?? 0
            denCloseSat = value?["closeSat"] as? Int ?? 0
            
            defaults.set(denOpenSat, forKey: "denOpenSat")
            defaults.set(denCloseSat, forKey: "denCloseSat")
        })
        // Sunday
        DB_BASE.child("venue2").child("den").child("day").child("Sun").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            denOpenSun = value?["openSun"] as? Int ?? 0
            denCloseSun = value?["closeSun"] as? Int ?? 0
            
            defaults.set(denOpenSun, forKey: "denOpenSun")
            defaults.set(denCloseSun, forKey: "denCloseSun")
        })
        
        /*
         *  Cougar Walk Café
         */
        
        // Monday through Thursday
        DB_BASE.child("venue2").child("cafe").child("day").child("MonFri").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            cafeOpenMonFri = value?["openMonFri"] as? Int ?? 0
            cafeCloseMonFri = value?["closeMonFri"] as? Int ?? 0
            
            defaults.set(cafeOpenMonFri, forKey: "cafeOpenMonFri")
            defaults.set(cafeCloseMonFri, forKey: "cafeCloseMonFri")
        })
        // Saturday
        DB_BASE.child("venue2").child("cafe").child("day").child("Sat").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            cafeOpenSat = value?["openSat"] as? Int ?? 0
            cafeCloseSat = value?["closeSat"] as? Int ?? 0
            
            defaults.set(cafeOpenSat, forKey: "cafeOpenSat")
            defaults.set(cafeCloseSat, forKey: "cafeCloseSat")
        })
        // Sunday
        DB_BASE.child("venue2").child("cafe").child("day").child("Sun").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            cafeOpenSun = value?["openSun"] as? Int ?? 0
            cafeCloseSun = value?["closeSun"] as? Int ?? 0
            
            defaults.set(cafeOpenSun, forKey: "cafeOpenSun")
            defaults.set(cafeCloseSun, forKey: "cafeCloseSun")
        })
        
        /*
         *  Mexicali Grill
         */
        
        // Monday through Thursday
        DB_BASE.child("venue2").child("mexicali").child("day").child("MonThur").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            mexicaliOpenMonThur = value?["openMonThur"] as? Int ?? 0
            mexicaliCloseMonThur = value?["closeMonThur"] as? Int ?? 0
            
            defaults.set(mexicaliOpenMonThur, forKey: "mexicaliOpenMonThur")
            defaults.set(mexicaliCloseMonThur, forKey: "mexicaliCloseMonThur")
        })
        // Friday
        DB_BASE.child("venue2").child("mexicali").child("day").child("Fri").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            mexicaliOpenFri = value?["openFri"] as? Int ?? 0
            mexicaliCloseFri = value?["closeFri"] as? Int ?? 0
            
            defaults.set(mexicaliOpenFri, forKey: "mexicaliOpenFri")
            defaults.set(mexicaliCloseFri, forKey: "mexicaliCloseFri")
        })
        // Saturday
        DB_BASE.child("venue2").child("mexicali").child("day").child("Sat").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            mexicaliOpenSat = value?["openSat"] as? Int ?? 0
            mexicaliCloseSat = value?["closeSat"] as? Int ?? 0
            
            defaults.set(mexicaliOpenSat, forKey: "mexicaliOpenSat")
            defaults.set(mexicaliCloseSat, forKey: "mexicaliCloseSat")
        })
        // Sunday
        DB_BASE.child("venue2").child("mexicali").child("day").child("Sun").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            mexicaliOpenSun = value?["openSun"] as? Int ?? 0
            mexicaliCloseSun = value?["closeSun"] as? Int ?? 0
            
            defaults.set(mexicaliOpenSun, forKey: "mexicaliOpenSun")
            defaults.set(mexicaliCloseSun, forKey: "mexicaliCloseSun")
        })
        
        /*
         *  Paws N' Go
         */
        
        // Monday through Thursday
        DB_BASE.child("venue2").child("pawsngo").child("day").child("MonThur").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            pawsOpenMonThur = value?["openMonThur"] as? Int ?? 0
            pawsCloseMonThur = value?["closeMonThur"] as? Int ?? 0
            
            defaults.set(pawsOpenMonThur, forKey: "pawsOpenMonThur")
            defaults.set(pawsCloseMonThur, forKey: "pawsCloseMonThur")
        })
        // Friday
        DB_BASE.child("venue2").child("pawsngo").child("day").child("Fri").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            pawsOpenFri = value?["openFri"] as? Int ?? 0
            pawsCloseFri = value?["closeFri"] as? Int ?? 0
            
            defaults.set(pawsOpenFri, forKey: "pawsOpenFri")
            defaults.set(pawsCloseFri, forKey: "pawsCloseFri")
        })
        // Saturday
        DB_BASE.child("venue2").child("pawsngo").child("day").child("Sat").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            pawsOpenSat = value?["openSat"] as? Int ?? 0
            pawsCloseSat = value?["closeSat"] as? Int ?? 0
            
            defaults.set(pawsOpenSat, forKey: "pawsOpenSat")
            defaults.set(pawsCloseSat, forKey: "pawsCloseSat")
        })
        // Sunday
        DB_BASE.child("venue2").child("pawsngo").child("day").child("Sun").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            pawsOpenSun = value?["openSun"] as? Int ?? 0
            pawsCloseSun = value?["closeSun"] as? Int ?? 0
            
            defaults.set(pawsOpenSun, forKey: "pawsOpenSun")
            defaults.set(pawsCloseSun, forKey: "pawsCloseSun")
        })
        
        /*
         *  The Grill at Heritage
         */
        
        // Monday through Thursday
        DB_BASE.child("venue2").child("grill").child("day").child("MonThur").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            grillOpenBMonThur = value?["openBMonThur"] as? Int ?? 0
            grillOpenLMonThur = value?["openLMonThur"] as? Int ?? 0
            grillCloseBMonThur = value?["closeBMonThur"] as? Int ?? 0
            grillCloseLMonThur = value?["closeLMonThur"] as? Int ?? 0
            
            defaults.set(grillOpenBMonThur, forKey: "grillOpenBMonThur")
            defaults.set(grillOpenLMonThur, forKey: "grillOpenLMonThur")
            defaults.set(grillCloseBMonThur, forKey: "grillCloseBMonThur")
            defaults.set(grillCloseLMonThur, forKey: "grillCloseLMonThur")
        })
        // Friday
        DB_BASE.child("venue2").child("grill").child("day").child("Fri").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            grillOpenBFri = value?["openBFri"] as? Int ?? 0
            grillOpenLFri = value?["openLFri"] as? Int ?? 0
            grillCloseBFri = value?["closeBFri"] as? Int ?? 0
            grillCloseLFri = value?["closeLFri"] as? Int ?? 0
            
            defaults.set(grillOpenBFri, forKey: "grillOpenBFri")
            defaults.set(grillOpenLFri, forKey: "grillOpenLFri")
            defaults.set(grillCloseBFri, forKey: "grillCloseBFri")
            defaults.set(grillCloseLFri, forKey: "grillCloseLFri")
        })
        // Saturday
        DB_BASE.child("venue2").child("grill").child("day").child("Sat").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            grillOpenSat = value?["openSat"] as? Int ?? 0
            grillCloseSat = value?["closeSat"] as? Int ?? 0
            
            defaults.set(grillOpenSat, forKey: "grillOpenSat")
            defaults.set(grillCloseSat, forKey: "grillCloseSat")
        })
        // Sunday
        DB_BASE.child("venue2").child("grill").child("day").child("Sun").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            grillOpenSun = value?["openSun"] as? Int ?? 0
            grillCloseSun = value?["closeSun"] as? Int ?? 0
            
            defaults.set(grillOpenSun, forKey: "grillOpenSun")
            defaults.set(grillCloseSun, forKey: "grillCloseSun")
        })
        
        /*
         *  Hillside Grounds
         */
        
        // Monday through Thursday
        DB_BASE.child("venue2").child("hillside").child("day").child("MonThur").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            hillsideOpenMonThur = value?["openMonThur"] as? Int ?? 0
            hillsideCloseMonThur = value?["closeMonThur"] as? Int ?? 0
            
            defaults.set(hillsideOpenMonThur, forKey: "hillsideOpenMonThur")
            defaults.set(hillsideCloseMonThur, forKey: "hillsideCloseMonThur")
        })
        // Friday
        DB_BASE.child("venue2").child("hillside").child("day").child("Fri").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            hillsideOpenFri = value?["openFri"] as? Int ?? 0
            hillsideCloseFri = value?["closeFri"] as? Int ?? 0
            
            defaults.set(hillsideOpenFri, forKey: "hillsideOpenFri")
            defaults.set(hillsideCloseFri, forKey: "hillsideCloseFri")
        })
        // Saturday
        DB_BASE.child("venue2").child("hillside").child("day").child("Sat").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            hillsideOpenSat = value?["openSat"] as? Int ?? 0
            hillsideCloseSat = value?["closeSat"] as? Int ?? 0
            
            defaults.set(hillsideOpenSat, forKey: "hillsideOpenSat")
            defaults.set(hillsideCloseSat, forKey: "hillsideCloseSat")
        })
        // Sunday
        DB_BASE.child("venue2").child("hillside").child("day").child("Sun").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            hillsideOpenSun = value?["openSun"] as? Int ?? 0
            hillsideCloseSun = value?["closeSun"] as? Int ?? 0
            
            defaults.set(hillsideOpenSun, forKey: "hillsideOpenSun")
            defaults.set(hillsideCloseSun, forKey: "hillsideCloseSun")
        })
        
        /*
         *  The Market at Heritage
         */
        
        // Monday through Thursday
        DB_BASE.child("venue2").child("market").child("day").child("MonThur").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            marketOpenMonThur = value?["openMonThur"] as? Int ?? 0
            marketCloseMonThur = value?["closeMonThur"] as? Int ?? 0
            
            defaults.set(marketOpenMonThur, forKey: "marketOpenMonThur")
            defaults.set(marketCloseMonThur, forKey: "marketCloseMonThur")
        })
        // Friday
        DB_BASE.child("venue2").child("market").child("day").child("Fri").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            marketOpenFri = value?["openFri"] as? Int ?? 0
            marketCloseFri = value?["closeFri"] as? Int ?? 0
            
            defaults.set(marketOpenFri, forKey: "marketOpenFri")
            defaults.set(marketCloseFri, forKey: "marketCloseFri")
        })
        // Saturday
        DB_BASE.child("venue2").child("market").child("day").child("Sat").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            marketOpenSat = value?["openSat"] as? Int ?? 0
            marketCloseSat = value?["closeSat"] as? Int ?? 0
            
            defaults.set(marketOpenSat, forKey: "marketOpenSat")
            defaults.set(marketCloseSat, forKey: "marketCloseSat")
        })
        // Sunday
        DB_BASE.child("venue2").child("market").child("day").child("Sun").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            marketOpenSun = value?["openSun"] as? Int ?? 0
            marketCloseSun = value?["closeSun"] as? Int ?? 0
            
            defaults.set(marketOpenSun, forKey: "marketOpenSun")
            defaults.set(marketCloseSun, forKey: "marketCloseSun")
        })
        
        /*
         *  Sam's Subs
         */
        
        // Monday through Thursday
        DB_BASE.child("venue2").child("sams").child("day").child("MonThur").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            samsOpenMonThur = value?["openMonThur"] as? Int ?? 0
            samsCloseMonThur = value?["closeMonThur"] as? Int ?? 0
            
            defaults.set(samsOpenMonThur, forKey: "samsOpenMonThur")
            defaults.set(samsCloseMonThur, forKey: "samsCloseMonThur")
        })
        // Friday
        DB_BASE.child("venue2").child("sams").child("day").child("Fri").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            samsOpenFri = value?["openFri"] as? Int ?? 0
            samsCloseFri = value?["closeFri"] as? Int ?? 0
            
            defaults.set(samsOpenFri, forKey: "samsOpenFri")
            defaults.set(samsCloseFri, forKey: "samsCloseFri")
        })
        // Saturday
        DB_BASE.child("venue2").child("sams").child("day").child("Sat").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            samsOpenSat = value?["openSat"] as? Int ?? 0
            samsCloseSat = value?["closeSat"] as? Int ?? 0
            
            defaults.set(samsOpenSat, forKey: "samsOpenSat")
            defaults.set(samsCloseSat, forKey: "samsCloseSat")
        })
        // Sunday
        DB_BASE.child("venue2").child("sams").child("day").child("Sun").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            samsOpenSun = value?["openSun"] as? Int ?? 0
            samsCloseSun = value?["closeSun"] as? Int ?? 0
            
            defaults.set(samsOpenSun, forKey: "samsOpenSun")
            defaults.set(samsCloseSun, forKey: "samsCloseSun")
        })
        
        /*
         *  Umai Sushi
         */
        
        // Monday through Thursday
        DB_BASE.child("venue2").child("umai").child("day").child("MonThur").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            umaiOpenMonThur = value?["openMonThur"] as? Int ?? 0
            umaiCloseMonThur = value?["closeMonThur"] as? Int ?? 0
            
            defaults.set(umaiOpenMonThur, forKey: "umaiOpenMonThur")
            defaults.set(umaiCloseMonThur, forKey: "umaiCloseMonThur")
        })
        // Friday
        DB_BASE.child("venue2").child("umai").child("day").child("Fri").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            umaiOpenFri = value?["openFri"] as? Int ?? 0
            umaiCloseFri = value?["closeFri"] as? Int ?? 0
            
            defaults.set(umaiOpenFri, forKey: "umaiOpenFri")
            defaults.set(umaiCloseFri, forKey: "umaiCloseFri")
        })
        // Saturday
        DB_BASE.child("venue2").child("umai").child("day").child("Sat").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            umaiOpenSat = value?["openSat"] as? Int ?? 0
            umaiCloseSat = value?["closeSat"] as? Int ?? 0
            
            defaults.set(umaiOpenSat, forKey: "umaiOpenSat")
            defaults.set(umaiCloseSat, forKey: "umaiCloseSat")
        })
        // Sunday
        DB_BASE.child("venue2").child("umai").child("day").child("Sun").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            umaiOpenSun = value?["openSun"] as? Int ?? 0
            umaiCloseSun = value?["closeSun"] as? Int ?? 0
            
            defaults.set(umaiOpenSun, forKey: "umaiOpenSun")
            defaults.set(umaiCloseSun, forKey: "umaiCloseSun")
        })
    }
}
