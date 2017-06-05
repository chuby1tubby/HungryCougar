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

func setHours() {
    let prefs = UserDefaults.standard
    let defaults = UserDefaults.standard
    
    var openMonThur = 0
    var openMonFri = 0
    var openFri = 0
    var openSat = 0
    var openSun = 0
    var closeMonThur = 0
    var closeMonFri = 0
    var closeFri = 0
    var closeSat = 0
    var closeSun = 0
    
    if restaurantChoice == "1899 Dining Hall" {
        var openBMonFri = 0
        var openLMonFri = 0
        var openDMonFri = 0
        var openSat = 0
        var openSun = 0
        var closeBMonFri = 0
        var closeLMonFri = 0
        var closeDMonFri = 0
        var closeSat = 0
        var closeSun = 0
        
        if let val = prefs.string(forKey: "diningHallOpenBMonFri") {
            openBMonFri = Int(val)!
            print("KYLE: Hours were retreived from UserDefaults.")
        } else {
            print("KYLE: No hours were found in prefs. #1")
        }
        if let val = prefs.string(forKey: "diningHallOpenLMonFri") {
            openLMonFri = Int(val)!
            print("KYLE: Hours were retreived from UserDefaults.")
        } else {
            print("KYLE: No hours were found in prefs. #2")
        }
        if let val = prefs.string(forKey: "diningHallOpenDMonFri") {
            openDMonFri = Int(val)!
            print("KYLE: Hours were retreived from UserDefaults.")
        } else {
            print("KYLE: No hours were found in prefs. #3")
        }
        if let val = prefs.string(forKey: "diningHallOpenSat") {
            openSat = Int(val)!
            print("KYLE: Hours were retreived from UserDefaults.")
        } else {
            print("KYLE: No hours were found in prefs. #4")
        }
        if let val = prefs.string(forKey: "diningHallOpenSun") {
            openSun = Int(val)!
            print("KYLE: Hours were retreived from UserDefaults.")
        } else {
            print("KYLE: No hours were found in prefs. #5")
        }
        if let val = prefs.string(forKey: "diningHallCloseBMonFri") {
            closeBMonFri = Int(val)!
            print("KYLE: Hours were retreived from UserDefaults.")
        } else {
            print("KYLE: No hours were found in prefs. #6")
        }
        if let val = prefs.string(forKey: "diningHallCloseLMonFri") {
            closeLMonFri = Int(val)!
            print("KYLE: Hours were retreived from UserDefaults.")
        } else {
            print("KYLE: No hours were found in prefs. #7")
        }
        if let val = prefs.string(forKey: "diningHallCloseDMonFri") {
            closeDMonFri = Int(val)!
            print("KYLE: Hours were retreived from UserDefaults.")
        } else {
            print("KYLE: No hours were found in prefs. #8")
        }
        if let val = prefs.string(forKey: "diningHallCloseSat") {
            closeSat = Int(val)!
            print("KYLE: Hours were retreived from UserDefaults.")
        } else {
            print("KYLE: No hours were found in prefs. #9")
        }
        if let val = prefs.string(forKey: "diningHallCloseSun") {
            closeSun = Int(val)!
            print("KYLE: Hours were retreived from UserDefaults.")
        } else {
            print("KYLE: No hours were found in prefs. #10")
        }
        
        setupDay(day: Monday, open: openBMonFri, close: closeDMonFri)
        setupDay(day: Tuesday, open: openBMonFri, close: closeDMonFri)
        setupDay(day: Wednesday, open: openBMonFri, close: closeDMonFri)
        setupDay(day: Thursday, open: openBMonFri, close: closeDMonFri)
        setupDay(day: Friday, open: openBMonFri, close: closeDMonFri)
        setupDay(day: Saturday, open: openSat, close: closeSat)
        setupDay(day: Sunday, open: openSun, close: closeSun)
        
    } else if restaurantChoice == "Cornerstone Coffeehouse" {
        
        if let val = prefs.string(forKey: "cornerstoneOpenMonThur") {
            openMonThur = Int(val)!
            print("KYLE: Hours were retreived from UserDefaults.")
        } else {
            print("KYLE: No hours were found in prefs. #10")
        }
        if let val = prefs.string(forKey: "cornerstoneOpenFri") {
            openFri = Int(val)!
            print("KYLE: Hours were retreived from UserDefaults.")
        } else {
            print("KYLE: No hours were found in prefs. #10")
        }
        if let val = prefs.string(forKey: "cornerstoneOpenSat") {
            openSat = Int(val)!
            print("KYLE: Hours were retreived from UserDefaults.")
        } else {
            print("KYLE: No hours were found in prefs. #10")
        }
        if let val = prefs.string(forKey: "cornerstoneOpenSun") {
            openSun = Int(val)!
            print("KYLE: Hours were retreived from UserDefaults.")
        } else {
            print("KYLE: No hours were found in prefs. #10")
        }
        if let val = prefs.string(forKey: "cornerstoneCloseMonThur") {
            closeMonThur = Int(val)!
            print("KYLE: Hours were retreived from UserDefaults.")
        } else {
            print("KYLE: No hours were found in prefs. #10")
        }
        if let val = prefs.string(forKey: "cornerstoneCloseFri") {
            closeFri = Int(val)!
            print("KYLE: Hours were retreived from UserDefaults.")
        } else {
            print("KYLE: No hours were found in prefs. #10")
        }
        if let val = prefs.string(forKey: "cornerstoneCloseSat") {
            closeSat = Int(val)!
            print("KYLE: Hours were retreived from UserDefaults.")
        } else {
            print("KYLE: No hours were found in prefs. #10")
        }
        if let val = prefs.string(forKey: "cornerstoneCloseSun") {
            closeSun = Int(val)!
            print("KYLE: Hours were retreived from UserDefaults.")
        } else {
            print("KYLE: No hours were found in prefs. #10")
        }
        setupDay(day: Monday, open: openMonThur, close: closeMonThur)
        setupDay(day: Tuesday, open: openMonThur, close: closeMonThur)
        setupDay(day: Wednesday, open: openMonThur, close: closeMonThur)
        setupDay(day: Thursday, open: openMonThur, close: closeMonThur)
        setupDay(day: Friday, open: openFri, close: closeFri)
        setupDay(day: Saturday, open: openSat, close: closeSat)
        setupDay(day: Sunday, open: openSun, close: closeSun)
        
    } else if restaurantChoice == "Cougar's Den Café" {
        
        if let val = prefs.string(forKey: "denOpenMonThur") {
            openMonThur = Int(val)!
            print("KYLE: Hours were retreived from UserDefaults.")
        } else {
            print("KYLE: No hours were found in prefs. #10")
        }
        if let val = prefs.string(forKey: "denOpenFri") {
            openFri = Int(val)!
            print("KYLE: Hours were retreived from UserDefaults.")
        } else {
            print("KYLE: No hours were found in prefs. #10")
        }
        if let val = prefs.string(forKey: "denOpenSat") {
            openSat = Int(val)!
            print("KYLE: Hours were retreived from UserDefaults.")
        } else {
            print("KYLE: No hours were found in prefs. #10")
        }
        if let val = prefs.string(forKey: "denOpenSun") {
            openSun = Int(val)!
            print("KYLE: Hours were retreived from UserDefaults.")
        } else {
            print("KYLE: No hours were found in prefs. #10")
        }
        if let val = prefs.string(forKey: "denCloseMonThur") {
            closeMonThur = Int(val)!
            print("KYLE: Hours were retreived from UserDefaults.")
        } else {
            print("KYLE: No hours were found in prefs. #10")
        }
        if let val = prefs.string(forKey: "denCloseFri") {
            closeFri = Int(val)!
            print("KYLE: Hours were retreived from UserDefaults.")
        } else {
            print("KYLE: No hours were found in prefs. #10")
        }
        if let val = prefs.string(forKey: "denCloseSat") {
            closeSat = Int(val)!
            print("KYLE: Hours were retreived from UserDefaults.")
        } else {
            print("KYLE: No hours were found in prefs. #10")
        }
        if let val = prefs.string(forKey: "denCloseSun") {
            closeSun = Int(val)!
            print("KYLE: Hours were retreived from UserDefaults.")
        } else {
            print("KYLE: No hours were found in prefs. #10")
        }
        
        setupDay(day: Monday, open: openMonThur, close: closeMonThur)
        setupDay(day: Tuesday, open: openMonThur, close: closeMonThur)
        setupDay(day: Wednesday, open: openMonThur, close: closeMonThur)
        setupDay(day: Thursday, open: openMonThur, close: closeMonThur)
        setupDay(day: Friday, open: openFri, close: closeFri)
        setupDay(day: Saturday, open: openSat, close: closeSat)
        setupDay(day: Sunday, open: openSun, close: closeSun)
        
    } else if restaurantChoice == "Cougar Walk Café" {
        
        if let val = prefs.string(forKey: "cafeOpenMonFri") {
            openMonFri = Int(val)!
            print("KYLE: Hours were retreived from UserDefaults.")
        } else {
            print("KYLE: No hours were found in prefs. #10")
        }
        if let val = prefs.string(forKey: "cafeOpenSat") {
            openSat = Int(val)!
            print("KYLE: Hours were retreived from UserDefaults.")
        } else {
            print("KYLE: No hours were found in prefs. #10")
        }
        if let val = prefs.string(forKey: "cafeOpenSun") {
            openSun = Int(val)!
            print("KYLE: Hours were retreived from UserDefaults.")
        } else {
            print("KYLE: No hours were found in prefs. #10")
        }
        if let val = prefs.string(forKey: "cafeCloseMonFri") {
            closeMonFri = Int(val)!
            print("KYLE: Hours were retreived from UserDefaults.")
        } else {
            print("KYLE: No hours were found in prefs. #10")
        }
        if let val = prefs.string(forKey: "cafeCloseSat") {
            closeSat = Int(val)!
            print("KYLE: Hours were retreived from UserDefaults.")
        } else {
            print("KYLE: No hours were found in prefs. #10")
        }
        if let val = prefs.string(forKey: "cafeCloseSun") {
            closeSun = Int(val)!
            print("KYLE: Hours were retreived from UserDefaults.")
        } else {
            print("KYLE: No hours were found in prefs. #10")
        }
        
        setupDay(day: Monday, open: openMonFri, close: closeMonFri)
        setupDay(day: Tuesday, open: openMonFri, close: closeMonFri)
        setupDay(day: Wednesday, open: openMonFri, close: closeMonFri)
        setupDay(day: Thursday, open: openMonFri, close: closeMonFri)
        setupDay(day: Friday, open: openMonFri, close: closeMonFri)
        setupDay(day: Saturday, open: openSat, close: closeSat)
        setupDay(day: Sunday, open: openSun, close: closeSun)
        
    } else if restaurantChoice == "Mexicali Grill" {
        
        if let val = prefs.string(forKey: "mexicaliOpenMonThur") {
            openMonThur = Int(val)!
            print("KYLE: Hours were retreived from UserDefaults.")
        } else {
            print("KYLE: No hours were found in prefs. #10")
        }
        if let val = prefs.string(forKey: "mexicaliOpenFri") {
            openFri = Int(val)!
            print("KYLE: Hours were retreived from UserDefaults.")
        } else {
            print("KYLE: No hours were found in prefs. #10")
        }
        if let val = prefs.string(forKey: "mexicaliOpenSat") {
            openSat = Int(val)!
            print("KYLE: Hours were retreived from UserDefaults.")
        } else {
            print("KYLE: No hours were found in prefs. #10")
        }
        if let val = prefs.string(forKey: "mexicaliOpenSun") {
            openSun = Int(val)!
            print("KYLE: Hours were retreived from UserDefaults.")
        } else {
            print("KYLE: No hours were found in prefs. #10")
        }
        if let val = prefs.string(forKey: "mexicaliCloseMonThur") {
            closeMonThur = Int(val)!
            print("KYLE: Hours were retreived from UserDefaults.")
        } else {
            print("KYLE: No hours were found in prefs. #10")
        }
        if let val = prefs.string(forKey: "mexicaliCloseFri") {
            closeFri = Int(val)!
            print("KYLE: Hours were retreived from UserDefaults.")
        } else {
            print("KYLE: No hours were found in prefs. #10")
        }
        if let val = prefs.string(forKey: "mexicaliCloseSat") {
            closeSat = Int(val)!
            print("KYLE: Hours were retreived from UserDefaults.")
        } else {
            print("KYLE: No hours were found in prefs. #10")
        }
        if let val = prefs.string(forKey: "mexicaliCloseSun") {
            closeSun = Int(val)!
            print("KYLE: Hours were retreived from UserDefaults.")
        } else {
            print("KYLE: No hours were found in prefs. #10")
        }
        
        setupDay(day: Monday, open: openMonThur, close: closeMonThur)
        setupDay(day: Tuesday, open: openMonThur, close: closeMonThur)
        setupDay(day: Wednesday, open: openMonThur, close: closeMonThur)
        setupDay(day: Thursday, open: openMonThur, close: closeMonThur)
        setupDay(day: Friday, open: openFri, close: closeFri)
        setupDay(day: Saturday, open: openSat, close: closeSat)
        setupDay(day: Sunday, open: openSun, close: closeSun)
        
    } else if restaurantChoice == "Paws 'N Go Convenience" {
        
        if let val = prefs.string(forKey: "pawsOpenMonThur") {
            openMonThur = Int(val)!
            print("KYLE: Hours were retreived from UserDefaults.")
        } else {
            print("KYLE: No hours were found in prefs. #10")
        }
        if let val = prefs.string(forKey: "pawsOpenFri") {
            openFri = Int(val)!
            print("KYLE: Hours were retreived from UserDefaults.")
        } else {
            print("KYLE: No hours were found in prefs. #10")
        }
        if let val = prefs.string(forKey: "pawsOpenSat") {
            openSat = Int(val)!
            print("KYLE: Hours were retreived from UserDefaults.")
        } else {
            print("KYLE: No hours were found in prefs. #10")
        }
        if let val = prefs.string(forKey: "pawsOpenSun") {
            openSun = Int(val)!
            print("KYLE: Hours were retreived from UserDefaults.")
        } else {
            print("KYLE: No hours were found in prefs. #10")
        }
        if let val = prefs.string(forKey: "pawsCloseMonThur") {
            closeMonThur = Int(val)!
            print("KYLE: Hours were retreived from UserDefaults.")
        } else {
            print("KYLE: No hours were found in prefs. #10")
        }
        if let val = prefs.string(forKey: "pawsCloseFri") {
            closeFri = Int(val)!
            print("KYLE: Hours were retreived from UserDefaults.")
        } else {
            print("KYLE: No hours were found in prefs. #10")
        }
        if let val = prefs.string(forKey: "pawsCloseSat") {
            closeSat = Int(val)!
            print("KYLE: Hours were retreived from UserDefaults.")
        } else {
            print("KYLE: No hours were found in prefs. #10")
        }
        if let val = prefs.string(forKey: "pawsCloseSun") {
            closeSun = Int(val)!
            print("KYLE: Hours were retreived from UserDefaults.")
        } else {
            print("KYLE: No hours were found in prefs. #10")
        }
        
        setupDay(day: Monday, open: openMonThur, close: closeMonThur)
        setupDay(day: Tuesday, open: openMonThur, close: closeMonThur)
        setupDay(day: Wednesday, open: openMonThur, close: closeMonThur)
        setupDay(day: Thursday, open: openMonThur, close: closeMonThur)
        setupDay(day: Friday, open: openFri, close: closeFri)
        setupDay(day: Saturday, open: openSat, close: closeSat)
        setupDay(day: Sunday, open: openSun, close: closeSun)
        
    } else if restaurantChoice == "The Grill at Heritage" {     // GRILL HOURS NEED TO BE UPDATED TO DISPLAY TRANSITION CLOSED HOURS
        
        if let val = prefs.string(forKey: "grillOpenBMonThur") {
            openMonThur = Int(val)!
            print("KYLE: Hours were retreived from UserDefaults.")
        } else {
            print("KYLE: No hours were found in prefs. #10")
        }
        if let val = prefs.string(forKey: "grillOpenBFri") {
            openFri = Int(val)!
            print("KYLE: Hours were retreived from UserDefaults.")
        } else {
            print("KYLE: No hours were found in prefs. #10")
        }
        if let val = prefs.string(forKey: "grillOpenSat") {
            openSat = Int(val)!
            print("KYLE: Hours were retreived from UserDefaults.")
        } else {
            print("KYLE: No hours were found in prefs. #10")
        }
        if let val = prefs.string(forKey: "grillOpenSun") {
            openSun = Int(val)!
            print("KYLE: Hours were retreived from UserDefaults.")
        } else {
            print("KYLE: No hours were found in prefs. #10")
        }
        if let val = prefs.string(forKey: "grillCloseLMonThur") {
            closeMonThur = Int(val)!
            print("KYLE: Hours were retreived from UserDefaults.")
        } else {
            print("KYLE: No hours were found in prefs. #10")
        }
        if let val = prefs.string(forKey: "grillCloseLFri") {   // Currently only works for lunch closing hour
            closeFri = Int(val)!
            print("KYLE: Hours were retreived from UserDefaults.")
        } else {
            print("KYLE: No hours were found in prefs. #10")
        }
        if let val = prefs.string(forKey: "grillCloseSat") {
            closeSat = Int(val)!
            print("KYLE: Hours were retreived from UserDefaults.")
        } else {
            print("KYLE: No hours were found in prefs. #10")
        }
        if let val = prefs.string(forKey: "grillCloseSun") {
            closeSun = Int(val)!
            print("KYLE: Hours were retreived from UserDefaults.")
        } else {
            print("KYLE: No hours were found in prefs. #10")
        }
        
        setupDay(day: Monday, open: openMonThur, close: closeMonThur)
        setupDay(day: Tuesday, open: openMonThur, close: closeMonThur)
        setupDay(day: Wednesday, open: openMonThur, close: closeMonThur)
        setupDay(day: Thursday, open: openMonThur, close: closeMonThur)
        setupDay(day: Friday, open: openFri, close: closeFri)
        setupDay(day: Saturday, open: openSat, close: closeSat)
        setupDay(day: Sunday, open: openSun, close: closeSun)
        
    } else if restaurantChoice == "Hillside Grounds at Heritage" {
        
        if let val = prefs.string(forKey: "hillsideOpenMonThur") {
            openMonThur = Int(val)!
            print("KYLE: Hours were retreived from UserDefaults.")
        } else {
            print("KYLE: No hours were found in prefs. #10")
        }
        if let val = prefs.string(forKey: "hillsideOpenFri") {
            openFri = Int(val)!
            print("KYLE: Hours were retreived from UserDefaults.")
        } else {
            print("KYLE: No hours were found in prefs. #10")
        }
        if let val = prefs.string(forKey: "hillsideOpenSat") {
            openSat = Int(val)!
            print("KYLE: Hours were retreived from UserDefaults.")
        } else {
            print("KYLE: No hours were found in prefs. #10")
        }
        if let val = prefs.string(forKey: "hillsideOpenSun") {
            openSun = Int(val)!
            print("KYLE: Hours were retreived from UserDefaults.")
        } else {
            print("KYLE: No hours were found in prefs. #10")
        }
        if let val = prefs.string(forKey: "hillsideCloseMonThur") {
            closeMonThur = Int(val)!
            print("KYLE: Hours were retreived from UserDefaults.")
        } else {
            print("KYLE: No hours were found in prefs. #10")
        }
        if let val = prefs.string(forKey: "hillsideCloseFri") {
            closeFri = Int(val)!
            print("KYLE: Hours were retreived from UserDefaults.")
        } else {
            print("KYLE: No hours were found in prefs. #10")
        }
        if let val = prefs.string(forKey: "hillsideCloseSat") {
            closeSat = Int(val)!
            print("KYLE: Hours were retreived from UserDefaults.")
        } else {
            print("KYLE: No hours were found in prefs. #10")
        }
        if let val = prefs.string(forKey: "hillsideCloseSun") {
            closeSun = Int(val)!
            print("KYLE: Hours were retreived from UserDefaults.")
        } else {
            print("KYLE: No hours were found in prefs. #10")
        }
        
        setupDay(day: Monday, open: openMonThur, close: closeMonThur)
        setupDay(day: Tuesday, open: openMonThur, close: closeMonThur)
        setupDay(day: Wednesday, open: openMonThur, close: closeMonThur)
        setupDay(day: Thursday, open: openMonThur, close: closeMonThur)
        setupDay(day: Friday, open: openFri, close: closeFri)
        setupDay(day: Saturday, open: openSat, close: closeSat)
        setupDay(day: Sunday, open: openSun, close: closeSun)
        
    } else if restaurantChoice == "The Market at Heritage" {
        
        if let val = prefs.string(forKey: "marketOpenMonThur") {
            openMonThur = Int(val)!
            print("KYLE: Hours were retreived from UserDefaults.")
        } else {
            print("KYLE: No hours were found in prefs. #10")
        }
        if let val = prefs.string(forKey: "marketOpenFri") {
            openFri = Int(val)!
            print("KYLE: Hours were retreived from UserDefaults.")
        } else {
            print("KYLE: No hours were found in prefs. #10")
        }
        if let val = prefs.string(forKey: "marketOpenSat") {
            openSat = Int(val)!
            print("KYLE: Hours were retreived from UserDefaults.")
        } else {
            print("KYLE: No hours were found in prefs. #10")
        }
        if let val = prefs.string(forKey: "marketOpenSun") {
            openSun = Int(val)!
            print("KYLE: Hours were retreived from UserDefaults.")
        } else {
            print("KYLE: No hours were found in prefs. #10")
        }
        if let val = prefs.string(forKey: "marketCloseMonThur") {
            closeMonThur = Int(val)!
            print("KYLE: Hours were retreived from UserDefaults.")
        } else {
            print("KYLE: No hours were found in prefs. #10")
        }
        if let val = prefs.string(forKey: "marketCloseFri") {
            closeFri = Int(val)!
            print("KYLE: Hours were retreived from UserDefaults.")
        } else {
            print("KYLE: No hours were found in prefs. #10")
        }
        if let val = prefs.string(forKey: "marketCloseSat") {
            closeSat = Int(val)!
            print("KYLE: Hours were retreived from UserDefaults.")
        } else {
            print("KYLE: No hours were found in prefs. #10")
        }
        if let val = prefs.string(forKey: "marketCloseSun") {
            closeSun = Int(val)!
            print("KYLE: Hours were retreived from UserDefaults.")
        } else {
            print("KYLE: No hours were found in prefs. #10")
        }
        
        setupDay(day: Monday, open: openMonThur, close: closeMonThur)
        setupDay(day: Tuesday, open: openMonThur, close: closeMonThur)
        setupDay(day: Wednesday, open: openMonThur, close: closeMonThur)
        setupDay(day: Thursday, open: openMonThur, close: closeMonThur)
        setupDay(day: Friday, open: openFri, close: closeFri)
        setupDay(day: Saturday, open: openSat, close: closeSat)
        setupDay(day: Sunday, open: openSun, close: closeSun)
        
    } else if restaurantChoice == "Sam's Subs" {
        
        if let val = prefs.string(forKey: "samsOpenMonThur") {
            openMonThur = Int(val)!
            print("KYLE: Hours were retreived from UserDefaults.")
        } else {
            print("KYLE: No hours were found in prefs. #10")
        }
        if let val = prefs.string(forKey: "samsOpenFri") {
            openFri = Int(val)!
            print("KYLE: Hours were retreived from UserDefaults.")
        } else {
            print("KYLE: No hours were found in prefs. #10")
        }
        if let val = prefs.string(forKey: "samsOpenSat") {
            openSat = Int(val)!
            print("KYLE: Hours were retreived from UserDefaults.")
        } else {
            print("KYLE: No hours were found in prefs. #10")
        }
        if let val = prefs.string(forKey: "samsOpenSun") {
            openSun = Int(val)!
            print("KYLE: Hours were retreived from UserDefaults.")
        } else {
            print("KYLE: No hours were found in prefs. #10")
        }
        if let val = prefs.string(forKey: "samsCloseMonThur") {
            closeMonThur = Int(val)!
            print("KYLE: Hours were retreived from UserDefaults.")
        } else {
            print("KYLE: No hours were found in prefs. #10")
        }
        if let val = prefs.string(forKey: "samsCloseFri") {
            closeFri = Int(val)!
            print("KYLE: Hours were retreived from UserDefaults.")
        } else {
            print("KYLE: No hours were found in prefs. #10")
        }
        if let val = prefs.string(forKey: "samsCloseSat") {
            closeSat = Int(val)!
            print("KYLE: Hours were retreived from UserDefaults.")
        } else {
            print("KYLE: No hours were found in prefs. #10")
        }
        if let val = prefs.string(forKey: "samsCloseSun") {
            closeSun = Int(val)!
            print("KYLE: Hours were retreived from UserDefaults.")
        } else {
            print("KYLE: No hours were found in prefs. #10")
        }
        
        setupDay(day: Monday, open: openMonThur, close: closeMonThur)
        setupDay(day: Tuesday, open: openMonThur, close: closeMonThur)
        setupDay(day: Wednesday, open: openMonThur, close: closeMonThur)
        setupDay(day: Thursday, open: openMonThur, close: closeMonThur)
        setupDay(day: Friday, open: openFri, close: closeFri)
        setupDay(day: Saturday, open: openSat, close: closeSat)
        setupDay(day: Sunday, open: openSun, close: closeSun)
        
    } else if restaurantChoice == "Umai Sushi" {
        
        if let val = prefs.string(forKey: "umaiOpenMonThur") {
            openMonThur = Int(val)!
            print("KYLE: Hours were retreived from UserDefaults.")
        } else {
            print("KYLE: No hours were found in prefs. #10")
        }
        if let val = prefs.string(forKey: "umaiOpenFri") {
            openFri = Int(val)!
            print("KYLE: Hours were retreived from UserDefaults.")
        } else {
            print("KYLE: No hours were found in prefs. #10")
        }
        if let val = prefs.string(forKey: "umaiOpenSat") {
            openSat = Int(val)!
            print("KYLE: Hours were retreived from UserDefaults.")
        } else {
            print("KYLE: No hours were found in prefs. #10")
        }
        if let val = prefs.string(forKey: "umaiOpenSun") {
            openSun = Int(val)!
            print("KYLE: Hours were retreived from UserDefaults.")
        } else {
            print("KYLE: No hours were found in prefs. #10")
        }
        if let val = prefs.string(forKey: "umaiCloseMonThur") {
            closeMonThur = Int(val)!
            print("KYLE: Hours were retreived from UserDefaults.")
        } else {
            print("KYLE: No hours were found in prefs. #10")
        }
        if let val = prefs.string(forKey: "umaiCloseFri") {
            closeFri = Int(val)!
            print("KYLE: Hours were retreived from UserDefaults.")
        } else {
            print("KYLE: No hours were found in prefs. #10")
        }
        if let val = prefs.string(forKey: "umaiCloseSat") {
            closeSat = Int(val)!
            print("KYLE: Hours were retreived from UserDefaults.")
        } else {
            print("KYLE: No hours were found in prefs. #10")
        }
        if let val = prefs.string(forKey: "umaiCloseSun") {
            closeSun = Int(val)!
            print("KYLE: Hours were retreived from UserDefaults.")
        } else {
            print("KYLE: No hours were found in prefs. #10")
        }
        
        setupDay(day: Monday, open: openMonThur, close: closeMonThur)
        setupDay(day: Tuesday, open: openMonThur, close: closeMonThur)
        setupDay(day: Wednesday, open: openMonThur, close: closeMonThur)
        setupDay(day: Thursday, open: openMonThur, close: closeMonThur)
        setupDay(day: Friday, open: openFri, close: closeFri)
        setupDay(day: Saturday, open: openSat, close: closeSat)
        setupDay(day: Sunday, open: openSun, close: closeSun)
        
    }
    
    daysOfTheWeek = [Sunday, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday]
}

func setupDay(day: Day, open: Int, close: Int) {
    day.openTime = open
    day.closeTime = close
    loadedDataFromFirebase = true
}
