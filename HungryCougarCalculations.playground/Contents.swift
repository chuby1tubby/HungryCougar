//
//  DiningPlanDisplayVC.swift
//  Hungry Cougar 2.0
//
//  Created by Kyle Nakamura on 8/9/16.
//  Copyright © 2016 Kyle Nakamura. All rights reserved.
//

import UIKit

// Variables
var currentBalance = 0.0
var mealBudget = 0.0
var weeklyBudget = 0.0
var dailyBudget = 0.0
var diningPlanChoice = ""
var schoolWeek: Int = 0
var weekday: Int = 0
var day: Int = 0
var month: Int = 0
var year: Int = 0
var todayDate: String = ""

// Formatter
let twoDecimalFormatter = NumberFormatter()
twoDecimalFormatter.minimumFractionDigits = 2

func setDiningPlan() {
    diningPlanChoice = "No Worries"
}

// Constants
let mealBudgets: [Double] = [1162, 978, 696, 554, 363]

func calculateDiningPoints() {
    switch diningPlanChoice {
    case "No Worries":
        mealBudget = mealBudgets[0]
    case "We've Got You Covered":
        mealBudget = mealBudgets[1]
    case "Weekend Away":
        mealBudget = mealBudgets[2]
    case "Forgot To Cook":
        mealBudget = mealBudgets[3]
    case "Grab And Go":
        mealBudget = mealBudgets[4]
    default:
        mealBudget = 0.0
        weeklyBudget = 0.0
    }
    
    dailyBudget = mealBudget / 112            // Set daily budget to subtract from currentBalance
    weeklyBudget = dailyBudget * 7
    currentBalance = mealBudget               // Set current balance equal to meal plan total balance
}

func calculateBalance() {
    setSchoolWeek()
    
    if schoolWeek == -1 {
        currentBalance = 0.0
    } else if schoolWeek == -2 {
        currentBalance = mealBudget - ((mealBudget/112)*7*9) + (mealBudget/112)
    } else {
        currentBalance = mealBudget - (weeklyBudget * Double(schoolWeek)) - (dailyBudget * Double(weekday))
    }
    
    currentBalance = NSString(string: twoDecimalFormatter.string(from: NSNumber(value: currentBalance))!).doubleValue
    
    print()
    print("The weekday is \(weekday)")
    print("Today's Date is \(todayDate)")
    print("Today's balance = \(currentBalance)")
    
}

// Set the date manualy to test the calculator
func manuallySetDay(mm: Int, dd: Int, yyyy: Int, wday: Int) {
    month = mm
    day = dd
    year = yyyy
    weekday = wday
}

func setSchoolWeek() {
    let date = NSDate()
    let calendar = Calendar.current
    let components = calendar.dateComponents([.weekday, .day, .month, .year], from: date as Date)
    weekday = components.weekday!    // 4
    day = components.day!            // 17
    month = components.month!        // 8
    year = components.year!          // 2016
    
    // Optional function-call for testing
    manuallySetDay(mm: 10, dd: 30, yyyy: 2016, wday: 0)
    
    todayDate = String("\(month).\(day).\(year-2000)")
    
    // School has yet to begin
    if month == 8 && day < 31 {
        schoolWeek = -1
    }
    
    // September
    if (month == 8 && (day >= 28 && day <= 31)) || (month == 9 && (day >= 1 && day <= 3)) {
        schoolWeek = 0
    } else if (month == 9 && (day >= 4 && day <= 10)) {
        schoolWeek = 1
    } else if (month == 9 && (day >= 11 && day <= 17)) {
        schoolWeek = 2
    } else if (month == 9 && (day >= 18 && day <= 24)) {
        schoolWeek = 3
    } else if (month == 9 && (day >= 25 && day <= 30)) || todayDate == "10.1.16" {
        schoolWeek = 4
    }
    
    // October
    if (month == 10 && (day >= 2 && day <= 8)) {
        schoolWeek = 5
    } else if (month == 10 && (day >= 9 && day <= 15)) {
        schoolWeek = 6
    } else if (month == 10 && (day >= 16 && day <= 22)) {
        schoolWeek = 7
    } else if (month == 10 && (day >= 23 && day <= 29)) {
        schoolWeek = 8
    }
    
    // Mid-semester break
    if (month == 10 && (day >= 30 && day <= 31)) || (month == 11 && (day >= 1 && day <= 5)) {
        schoolWeek = -2
    }
    
    // November
    if (month == 11 && (day >= 6 && day <= 12)) {
        schoolWeek = 9
    } else if (month == 11 && (day >= 13 && day <= 19)) {
        schoolWeek = 10
    } else if (month == 11 && (day >= 20 && day <= 26)) {
        schoolWeek = 11
    } else if (month == 11 && (day >= 27 && day <= 30)) || (month == 11 && (day >= 1 && day <= 3)) {
        schoolWeek = 12
    }
    
    // December
    if (month == 12 && (day >= 4 && day <= 10)) {
        schoolWeek = 13
    } else if (month == 12 && (day >= 11 && day <= 17)) {
        schoolWeek = 14
    } else if (month == 12 && (day >= 18 && day <= 24)) {           // When does the semester end?
        schoolWeek = 15
    }
    
    // Christmas break
    if (month == 12 && (day >= 18 && day <= 31)) || (month == 1 && (day >= 1 && day <= 14)) {
        schoolWeek = 15 // Change
        print("Enjoy your Christmas vacation!")
    }
    
    // January
    if (month == 1 && (day >= 15 && day <= 21)) {
        schoolWeek = 1
    } else if (month == 1 && (day >= 22 && day <= 28)) {
        schoolWeek = 2
    } else if (month == 1 && (day >= 29 && day <= 31)) || (month == 2 && (day >= 1 && day <= 4)) {
        schoolWeek = 3
    }
    
    // February
    if (month == 2 && (day >= 5 && day <= 11)) {
        schoolWeek = 4
    } else if (month == 2 && (day >= 12 && day <= 18)) {
        schoolWeek = 5
    } else if (month == 2 && (day >= 19 && day <= 25)) {
        schoolWeek = 6
    } else if (month == 2 && (day >= 26 && day <= 28)) || (month == 3 && (day >= 1 && day <= 4)) {
        schoolWeek = 7
    }
    
    // March
    if (month == 3 && (day >= 5 && day <= 11)) {
        schoolWeek = 8
    } else if (month == 3 && (day >= 12 && day <= 18)) {
        schoolWeek = 9
    }  else if (month == 3 && (day >= 19 && day <= 25)) {
        schoolWeek = 10
    }  else if (month == 3 && (day >= 26 && day <= 31)) || todayDate == "4.1.17" {
        schoolWeek = 11
    }
    
    // April
    if (month == 4 && (day >= 2 && day <= 8)) {
        schoolWeek = 12
    } else if (month == 4 && (day >= 9 && day <= 15)) {
        schoolWeek = 13
    } else if (month == 4 && (day >= 16 && day <= 22)) {
        schoolWeek = 14
    } else if (month == 4 && (day >= 23 && day <= 29)) {
        schoolWeek = 15
    }
}

// Run the functions
setDiningPlan()
calculateDiningPoints()
calculateBalance()
