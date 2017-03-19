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

var ref: FIRDatabaseReference! = FIRDatabase.database().reference().child("venue")

func setHours() {
    
    ref.child("1899").child("day").child("MonFri").observeSingleEvent(of: .value, with: { (snapshot) in
        let value = snapshot.value as? NSDictionary
        let testNumber = value?["closeDMonFri"] as? Int ?? 0
        print("KYLE: The number from Firebase: \(testNumber)")
    })
     
    if restaurantChoice == "1899 Dining Hall" {
        setupDay(day: Sunday, open: 0800, close: 1700)
        setupDay(day: Monday, open: 0630, close: 1930)
        setupDay(day: Tuesday, open: 0630, close: 1930)
        setupDay(day: Wednesday, open: 0630, close: 1930)
        setupDay(day: Thursday, open: 0630, close: 1930)
        setupDay(day: Friday, open: 0630, close: 1930)
        setupDay(day: Saturday, open: 0800, close: 1400)
    } else if restaurantChoice == "Cornerstone Coffeehouse" {
        setupDay(day: Sunday, open: 720, close: 0)
        setupDay(day: Monday, open: 390, close: 60)
        setupDay(day: Tuesday, open: 390, close: 60)
        setupDay(day: Wednesday, open: 390, close: 60)
        setupDay(day: Thursday, open: 390, close: 60)
        setupDay(day: Friday, open: 390, close: 1020)
        setupDay(day: Saturday, open: 660, close: 960)
    } else if restaurantChoice == "Cougar's Den Café" {
        setupDay(day: Sunday, open: 960, close: 0)
        setupDay(day: Monday, open: 660, close: 0)
        setupDay(day: Tuesday, open: 660, close: 0)
        setupDay(day: Wednesday, open: 660, close: 0)
        setupDay(day: Thursday, open: 660, close: 0)
        setupDay(day: Friday, open: 660, close: 1140)
        setupDay(day: Saturday, open: 0, close: 0)
    } else if restaurantChoice == "Cougar Walk Café" {
        setupDay(day: Sunday, open: 0, close: 0)
        setupDay(day: Monday, open: 660, close: 840)
        setupDay(day: Tuesday, open: 660, close: 840)
        setupDay(day: Wednesday, open: 660, close: 840)
        setupDay(day: Thursday, open: 660, close: 840)
        setupDay(day: Friday, open: 660, close: 840)
        setupDay(day: Saturday, open: 0, close: 0)
    } else if restaurantChoice == "Mexicali Grill" {
        setupDay(day: Sunday, open: 0, close: 0)
        setupDay(day: Monday, open: 480, close: 1200)
        setupDay(day: Tuesday, open: 480, close: 1200)
        setupDay(day: Wednesday, open: 480, close: 1200)
        setupDay(day: Thursday, open: 480, close: 1200)
        setupDay(day: Friday, open: 480, close: 1140)
        setupDay(day: Saturday, open: 780, close: 1200)
    } else if restaurantChoice == "Paws 'N Go Convenience" {
        setupDay(day: Sunday, open: 960, close: 1140)
        setupDay(day: Monday, open: 450, close: 60)
        setupDay(day: Tuesday, open: 450, close: 60)
        setupDay(day: Wednesday, open: 450, close: 60)
        setupDay(day: Thursday, open: 450, close: 60)
        setupDay(day: Friday, open: 450, close: 1260)
        setupDay(day: Saturday, open: 720, close: 0)
    }
    
    else if restaurantChoice == "The Grill at Heritage" {
        setupDay(day: Sunday, open: 0, close: 0)
        setupDay(day: Monday, open: 420, close: 1200)
        setupDay(day: Tuesday, open: 420, close: 1200)
        setupDay(day: Wednesday, open: 420, close: 1200)
        setupDay(day: Thursday, open: 420, close: 1200)
        setupDay(day: Friday, open: 660, close: 900)
        setupDay(day: Saturday, open: 0, close: 0)
    } else if restaurantChoice == "Hillside Grounds at Heritage" {
        setupDay(day: Sunday, open: 0, close: 0)
        setupDay(day: Monday, open: 390, close: 1260)
        setupDay(day: Tuesday, open: 390, close: 1260)
        setupDay(day: Wednesday, open: 390, close: 1260)
        setupDay(day: Thursday, open: 390, close: 1260)
        setupDay(day: Friday, open: 390, close: 960)
        setupDay(day: Saturday, open: 0, close: 0)
    } else if restaurantChoice == "The Market at Heritage" {
        setupDay(day: Sunday, open: 0, close: 0)
        setupDay(day: Monday, open: 420, close: 1200)
        setupDay(day: Tuesday, open: 420, close: 1200)
        setupDay(day: Wednesday, open: 420, close: 1200)
        setupDay(day: Thursday, open: 420, close: 1200)
        setupDay(day: Friday, open: 420, close: 960)
        setupDay(day: Saturday, open: 0, close: 0)
    } else if restaurantChoice == "Sam's Subs" {
        setupDay(day: Sunday, open: 0, close: 0)
        setupDay(day: Monday, open: 540, close: 1200)
        setupDay(day: Tuesday, open: 540, close: 1200)
        setupDay(day: Wednesday, open: 540, close: 1200)
        setupDay(day: Thursday, open: 540, close: 1200)
        setupDay(day: Friday, open: 540, close: 960)
        setupDay(day: Saturday, open: 600, close: 900)
    } else if restaurantChoice == "Umai Sushi" {
        setupDay(day: Sunday, open: 0, close: 0)
        setupDay(day: Monday, open: 660, close: 1200)
        setupDay(day: Tuesday, open: 660, close: 1200)
        setupDay(day: Wednesday, open: 660, close: 1200)
        setupDay(day: Thursday, open: 660, close: 1200)
        setupDay(day: Friday, open: 660, close: 900)
        setupDay(day: Saturday, open: 0, close: 0)
    }
    
    daysOfTheWeek = [Sunday, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday]
    
    for day in daysOfTheWeek {
        if day.openTime == 0 && day.closeTime == 0 {
            day.hasNoHours = true
        }
    }
}

func setupDay(day: Day, open: Int, close: Int) {
    day.openTime = open
    day.closeTime = close
}
