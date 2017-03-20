//
//  RestaurantHours.swift
//  Hungry Cougar 2.0
//
//  Created by Kyle Nakamura on 8/6/16.
//  Copyright © 2016 Kyle Nakamura. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import Foundation

// Initialized Days
var Sunday: Day = Day(openTime: 0, closeTime: 0, hasNoHours: false)
var Monday: Day = Day(openTime: 0, closeTime: 0, hasNoHours: false)
var Tuesday: Day = Day(openTime: 0, closeTime: 0, hasNoHours: false)
var Wednesday: Day = Day(openTime: 0, closeTime: 0, hasNoHours: false)
var Thursday: Day = Day(openTime: 0, closeTime: 0, hasNoHours: false)
var Friday: Day = Day(openTime: 0, closeTime: 0, hasNoHours: false)
var Saturday: Day = Day(openTime: 0, closeTime: 0, hasNoHours: false)
var Yesterday: Day = Day(openTime: 0, closeTime: 0, hasNoHours: false)
var Today: Day = Day(openTime: 0, closeTime: 0, hasNoHours: false)
var Tomorrow: Day = Day(openTime: 0, closeTime: 0, hasNoHours: false)
var ZeroDay: Day = Day(openTime: 0, closeTime: 0, hasNoHours: false)

var daysOfTheWeek = [Day]()

var ref: FIRDatabaseReference! = FIRDatabase.database().reference().child("venue")  // Base reference for Firebase Database venues

func setHours() {
    loadedDataFromFirebase = false
    ref = FIRDatabase.database().reference().child("venue")
    if restaurantChoice == "1899 Dining Hall" {
        ref = ref.child("1899").child("day")
        
        // Monday through Friday
        ref.child("MonFri").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let openBMonFri = value?["openBMonFri"] as? Int ?? 0
            let openLMonFri = value?["openLMonFri"] as? Int ?? 0
            let openDMonFri = value?["openDMonFri"] as? Int ?? 0
            let closeBMonFri = value?["closeBMonFri"] as? Int ?? 0
            let closeLMonFri = value?["closeLMonFri"] as? Int ?? 0
            let closeDMonFri = value?["closeDMonFri"] as? Int ?? 0
            print("KYLE: openBMonFri = \(openBMonFri)")
            
            setupDay(day: Monday, open: openBMonFri, close: closeDMonFri)
            setupDay(day: Tuesday, open: openBMonFri, close: closeDMonFri)
            setupDay(day: Wednesday, open: openBMonFri, close: closeDMonFri)
            setupDay(day: Thursday, open: openBMonFri, close: closeDMonFri)
            setupDay(day: Friday, open: openBMonFri, close: closeDMonFri)
        })
        // Saturday
        ref.child("Sat").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let openSat = value?["openSat"] as? Int ?? 0
            let closeSat = value?["closeSat"] as? Int ?? 0
            
            setupDay(day: Saturday, open: openSat, close: closeSat)
        })
        // Sunday
        ref.child("Sun").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let openSun = value?["openSun"] as? Int ?? 0
            let closeSun = value?["closeSun"] as? Int ?? 0
            
            setupDay(day: Sunday, open: openSun, close: closeSun)
        })
    } else if restaurantChoice == "Cornerstone Coffeehouse" {
        ref = ref.child("cornerstone").child("day")
        
        // Monday through Thursday
        ref.child("MonThur").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let openMonThur = value?["openMonThur"] as? Int ?? 0
            let closeMonThur = value?["closeMonThur"] as? Int ?? 0
            
            print("KYLE: openMonThur for Coffeehouse = \(openMonThur)")
            
            setupDay(day: Monday, open: openMonThur, close: closeMonThur)
            setupDay(day: Tuesday, open: openMonThur, close: closeMonThur)
            setupDay(day: Wednesday, open: openMonThur, close: closeMonThur)
            setupDay(day: Thursday, open: openMonThur, close: closeMonThur)
        })
        // Friday
        ref.child("Fri").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let openFri = value?["openFri"] as? Int ?? 0
            let closeFri = value?["closeFri"] as? Int ?? 0
            
            setupDay(day: Friday, open: openFri, close: closeFri)
        })
        // Saturday
        ref.child("Sat").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let openSat = value?["openSat"] as? Int ?? 0
            let closeSat = value?["closeSat"] as? Int ?? 0
            
            setupDay(day: Saturday, open: openSat, close: closeSat)
        })
        // Sunday
        ref.child("Sun").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let openSun = value?["openSun"] as? Int ?? 0
            let closeSun = value?["closeSun"] as? Int ?? 0
            
            setupDay(day: Sunday, open: openSun, close: closeSun)
        })
    } else if restaurantChoice == "Cougar's Den Café" {
        ref = ref.child("den").child("day")
        
        // Monday through Thursday
        ref.child("MonThur").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let openMonThur = value?["openMonThur"] as? Int ?? 0
            let closeMonThur = value?["closeMonThur"] as? Int ?? 0
            
            setupDay(day: Monday, open: openMonThur, close: closeMonThur)
            setupDay(day: Tuesday, open: openMonThur, close: closeMonThur)
            setupDay(day: Wednesday, open: openMonThur, close: closeMonThur)
            setupDay(day: Thursday, open: openMonThur, close: closeMonThur)
        })
        // Friday
        ref.child("Fri").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let openFri = value?["openFri"] as? Int ?? 0
            let closeFri = value?["closeFri"] as? Int ?? 0
            
            setupDay(day: Friday, open: openFri, close: closeFri)
        })
        // Saturday
        ref.child("Sat").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let openSat = value?["openSat"] as? Int ?? 0
            let closeSat = value?["closeSat"] as? Int ?? 0
            
            setupDay(day: Saturday, open: openSat, close: closeSat)
        })
        // Sunday
        ref.child("Sun").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let openSun = value?["openSun"] as? Int ?? 0
            let closeSun = value?["closeSun"] as? Int ?? 0
            
            setupDay(day: Sunday, open: openSun, close: closeSun)
        })
    } else if restaurantChoice == "Cougar Walk Café" {
        ref = ref.child("cafe").child("day")
        
        // Monday through Thursday
        ref.child("MonFri").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let openMonFri = value?["openMonFri"] as? Int ?? 0
            let closeMonFri = value?["closeMonFri"] as? Int ?? 0
            
            setupDay(day: Monday, open: openMonFri, close: closeMonFri)
            setupDay(day: Tuesday, open: openMonFri, close: closeMonFri)
            setupDay(day: Wednesday, open: openMonFri, close: closeMonFri)
            setupDay(day: Thursday, open: openMonFri, close: closeMonFri)
            setupDay(day: Friday, open: openMonFri, close: closeMonFri)
        })
        // Saturday
        ref.child("Sat").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let openSat = value?["openSat"] as? Int ?? 0
            let closeSat = value?["closeSat"] as? Int ?? 0
            
            setupDay(day: Saturday, open: openSat, close: closeSat)
        })
        // Sunday
        ref.child("Sun").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let openSun = value?["openSun"] as? Int ?? 0
            let closeSun = value?["closeSun"] as? Int ?? 0
            
            setupDay(day: Sunday, open: openSun, close: closeSun)
        })
    } else if restaurantChoice == "Mexicali Grill" {
        // Hours for Mexicali
        var openMonThur = 0
        var closeMonThur = 0
        var openFri = 0
        var closeFri = 0
        var openSat = 0
        var closeSat = 0
        var openSun = 0
        var closeSun = 0
        
        ref = ref.child("mexicali").child("day")
        
        // Monday through Thursday
        ref.child("MonThur").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            openMonThur = value?["openMonThur"] as? Int ?? 0
            closeMonThur = value?["closeMonThur"] as? Int ?? 0
            
            setupDay(day: Monday, open: openMonThur, close: closeMonThur)
            setupDay(day: Tuesday, open: openMonThur, close: closeMonThur)
            setupDay(day: Wednesday, open: openMonThur, close: closeMonThur)
            setupDay(day: Thursday, open: openMonThur, close: closeMonThur)
        })
        // Friday
        ref.child("Fri").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            openFri = value?["openFri"] as? Int ?? 0
            closeFri = value?["closeFri"] as? Int ?? 0
            
            setupDay(day: Friday, open: openFri, close: closeFri)
        })
        // Saturday
        ref.child("Sat").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            openSat = value?["openSat"] as? Int ?? 0
            closeSat = value?["closeSat"] as? Int ?? 0
            
            setupDay(day: Saturday, open: openSat, close: closeSat)
        })
        // Sunday
        ref.child("Sun").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            openSun = value?["openSun"] as? Int ?? 0
            closeSun = value?["closeSun"] as? Int ?? 0
            
            setupDay(day: Sunday, open: openSun, close: closeSun)
        })
    } else if restaurantChoice == "Paws 'N Go Convenience" {
        // Hours for Pawsngo
        var openMonThur = 0
        var closeMonThur = 0
        var openFri = 0
        var closeFri = 0
        var openSat = 0
        var closeSat = 0
        var openSun = 0
        var closeSun = 0
        
        ref = ref.child("pawsngo").child("day")
        
        // Monday through Thursday
        ref.child("MonThur").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            openMonThur = value?["openMonThur"] as? Int ?? 0
            closeMonThur = value?["closeMonThur"] as? Int ?? 0
            
            setupDay(day: Monday, open: openMonThur, close: closeMonThur)
            setupDay(day: Tuesday, open: openMonThur, close: closeMonThur)
            setupDay(day: Wednesday, open: openMonThur, close: closeMonThur)
            setupDay(day: Thursday, open: openMonThur, close: closeMonThur)
        })
        // Friday
        ref.child("Fri").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            openFri = value?["openFri"] as? Int ?? 0
            closeFri = value?["closeFri"] as? Int ?? 0
            
            setupDay(day: Friday, open: openFri, close: closeFri)
        })
        // Saturday
        ref.child("Sat").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            openSat = value?["openSat"] as? Int ?? 0
            closeSat = value?["closeSat"] as? Int ?? 0
            
            setupDay(day: Saturday, open: openSat, close: closeSat)
        })
        // Sunday
        ref.child("Sun").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            openSun = value?["openSun"] as? Int ?? 0
            closeSun = value?["closeSun"] as? Int ?? 0
            
            setupDay(day: Sunday, open: openSun, close: closeSun)
        })
    }
    
    else if restaurantChoice == "The Grill at Heritage" {
        // Hours for Grill
        var openMonThur = 0
        var closeMonThur = 0
        var openFri = 0
        var closeFri = 0
        var openSat = 0
        var closeSat = 0
        var openSun = 0
        var closeSun = 0
        
        ref = ref.child("grill").child("day")
        
        // Monday through Thursday
        ref.child("MonThur").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            openMonThur = value?["openMonThur"] as? Int ?? 0
            closeMonThur = value?["closeMonThur"] as? Int ?? 0
            
            setupDay(day: Monday, open: openMonThur, close: closeMonThur)
            setupDay(day: Tuesday, open: openMonThur, close: closeMonThur)
            setupDay(day: Wednesday, open: openMonThur, close: closeMonThur)
            setupDay(day: Thursday, open: openMonThur, close: closeMonThur)
        })
        // Friday
        ref.child("Fri").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            openFri = value?["openFri"] as? Int ?? 0
            closeFri = value?["closeFri"] as? Int ?? 0
            
            setupDay(day: Friday, open: openFri, close: closeFri)
        })
        // Saturday
        ref.child("Sat").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            openSat = value?["openSat"] as? Int ?? 0
            closeSat = value?["closeSat"] as? Int ?? 0
            
            setupDay(day: Saturday, open: openSat, close: closeSat)
        })
        // Sunday
        ref.child("Sun").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            openSun = value?["openSun"] as? Int ?? 0
            closeSun = value?["closeSun"] as? Int ?? 0
            
            setupDay(day: Sunday, open: openSun, close: closeSun)
        })
    } else if restaurantChoice == "Hillside Grounds at Heritage" {
        // Hours for Hillside
        var openMonThur = 0
        var closeMonThur = 0
        var openFri = 0
        var closeFri = 0
        var openSat = 0
        var closeSat = 0
        var openSun = 0
        var closeSun = 0
        
        ref = ref.child("hillside").child("day")
        
        // Monday through Thursday
        ref.child("MonThur").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            openMonThur = value?["openMonThur"] as? Int ?? 0
            closeMonThur = value?["closeMonThur"] as? Int ?? 0
            
            setupDay(day: Monday, open: openMonThur, close: closeMonThur)
            setupDay(day: Tuesday, open: openMonThur, close: closeMonThur)
            setupDay(day: Wednesday, open: openMonThur, close: closeMonThur)
            setupDay(day: Thursday, open: openMonThur, close: closeMonThur)
        })
        // Friday
        ref.child("Fri").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            openFri = value?["openFri"] as? Int ?? 0
            closeFri = value?["closeFri"] as? Int ?? 0
            
            setupDay(day: Friday, open: openFri, close: closeFri)
        })
        // Saturday
        ref.child("Sat").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            openSat = value?["openSat"] as? Int ?? 0
            closeSat = value?["closeSat"] as? Int ?? 0
            
            setupDay(day: Saturday, open: openSat, close: closeSat)
        })
        // Sunday
        ref.child("Sun").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            openSun = value?["openSun"] as? Int ?? 0
            closeSun = value?["closeSun"] as? Int ?? 0
            
            setupDay(day: Sunday, open: openSun, close: closeSun)
        })
    } else if restaurantChoice == "The Market at Heritage" {
        // Hours for Market
        var openMonThur = 0
        var closeMonThur = 0
        var openFri = 0
        var closeFri = 0
        var openSat = 0
        var closeSat = 0
        var openSun = 0
        var closeSun = 0
        
        ref = ref.child("market").child("day")
        
        // Monday through Thursday
        ref.child("MonThur").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            openMonThur = value?["openMonThur"] as? Int ?? 0
            closeMonThur = value?["closeMonThur"] as? Int ?? 0
            
            setupDay(day: Monday, open: openMonThur, close: closeMonThur)
            setupDay(day: Tuesday, open: openMonThur, close: closeMonThur)
            setupDay(day: Wednesday, open: openMonThur, close: closeMonThur)
            setupDay(day: Thursday, open: openMonThur, close: closeMonThur)
        })
        // Friday
        ref.child("Fri").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            openFri = value?["openFri"] as? Int ?? 0
            closeFri = value?["closeFri"] as? Int ?? 0
            
            setupDay(day: Friday, open: openFri, close: closeFri)
        })
        // Saturday
        ref.child("Sat").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            openSat = value?["openSat"] as? Int ?? 0
            closeSat = value?["closeSat"] as? Int ?? 0
            
            setupDay(day: Saturday, open: openSat, close: closeSat)
        })
        // Sunday
        ref.child("Sun").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            openSun = value?["openSun"] as? Int ?? 0
            closeSun = value?["closeSun"] as? Int ?? 0
            
            setupDay(day: Sunday, open: openSun, close: closeSun)
        })
    } else if restaurantChoice == "Sam's Subs" {
        // Hours for Sams
        var openMonThur = 0
        var closeMonThur = 0
        var openFri = 0
        var closeFri = 0
        var openSat = 0
        var closeSat = 0
        var openSun = 0
        var closeSun = 0
        
        ref = ref.child("sams").child("day")
        
        // Monday through Thursday
        ref.child("MonThur").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            openMonThur = value?["openMonThur"] as? Int ?? 0
            closeMonThur = value?["closeMonThur"] as? Int ?? 0
            
            setupDay(day: Monday, open: openMonThur, close: closeMonThur)
            setupDay(day: Tuesday, open: openMonThur, close: closeMonThur)
            setupDay(day: Wednesday, open: openMonThur, close: closeMonThur)
            setupDay(day: Thursday, open: openMonThur, close: closeMonThur)
        })
        // Friday
        ref.child("Fri").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            openFri = value?["openFri"] as? Int ?? 0
            closeFri = value?["closeFri"] as? Int ?? 0
            
            setupDay(day: Friday, open: openFri, close: closeFri)
        })
        // Saturday
        ref.child("Sat").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            openSat = value?["openSat"] as? Int ?? 0
            closeSat = value?["closeSat"] as? Int ?? 0
            
            setupDay(day: Saturday, open: openSat, close: closeSat)
        })
        // Sunday
        ref.child("Sun").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            openSun = value?["openSun"] as? Int ?? 0
            closeSun = value?["closeSun"] as? Int ?? 0
            
            setupDay(day: Sunday, open: openSun, close: closeSun)
        })
    } else if restaurantChoice == "Umai Sushi" {
        // Hours for Umai
        var openMonThur = 0
        var closeMonThur = 0
        var openFri = 0
        var closeFri = 0
        var openSat = 0
        var closeSat = 0
        var openSun = 0
        var closeSun = 0
        
        ref = ref.child("umai").child("day")
        
        // Monday through Thursday
        ref.child("MonThur").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            openMonThur = value?["openMonThur"] as? Int ?? 0
            closeMonThur = value?["closeMonThur"] as? Int ?? 0
            
            setupDay(day: Monday, open: openMonThur, close: closeMonThur)
            setupDay(day: Tuesday, open: openMonThur, close: closeMonThur)
            setupDay(day: Wednesday, open: openMonThur, close: closeMonThur)
            setupDay(day: Thursday, open: openMonThur, close: closeMonThur)
        })
        // Friday
        ref.child("Fri").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            openFri = value?["openFri"] as? Int ?? 0
            closeFri = value?["closeFri"] as? Int ?? 0
            
            setupDay(day: Friday, open: openFri, close: closeFri)
        })
        // Saturday
        ref.child("Sat").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            openSat = value?["openSat"] as? Int ?? 0
            closeSat = value?["closeSat"] as? Int ?? 0
            
            setupDay(day: Saturday, open: openSat, close: closeSat)
        })
        // Sunday
        ref.child("Sun").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            openSun = value?["openSun"] as? Int ?? 0
            closeSun = value?["closeSun"] as? Int ?? 0
            
            setupDay(day: Sunday, open: openSun, close: closeSun)
        })
    }
    
    daysOfTheWeek = [Sunday, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday]
    

    for day in daysOfTheWeek {
        if day.openTime == 0 && day.closeTime == 0 {
            day.hasNoHours = true
        }
        print("KYLE: \(day.openTime)\t-\t\(day.closeTime)")
    }
}

func setupDay(day: Day, open: Int, close: Int) {
    day.openTime = open
    day.closeTime = close
    loadedDataFromFirebase = true
}
