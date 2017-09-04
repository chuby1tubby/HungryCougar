//
//  DiningPointsVC.swift
//  Hungry Cougar 2.0
//
//  Created by Kyle Nakamura on 8/9/16.
//  Copyright © 2016 Kyle Nakamura. All rights reserved.
//

import UIKit
import DropDown
import Firebase
import StoreKit // Used to display Review request
import Locksmith

// Global Variables
var expectedBalance = 0.0
var mealBudget = 0.0
var weeklyBudget = 0.0
var dailyBudget = 0.0
var schoolWeek: Int = 0
var minute: Int = 0
var hour: Int = 0
var day: Int = 0
var weekday: Int = 0
var weekOfYear: Int = 0
var month: Int = 0
var year: Int = 0
var todayDate: String? = ""
var todayTime: String? = ""

class DiningPointsVC: UIViewController, UITextFieldDelegate {
    
    // Constants
    let mealBudgets: [Double] = [1139, 975, 711, 561, 364]
    let dpDropDown = DropDown()   // Create a new drop down object
    let defaults = UserDefaults.standard
    let prefs = UserDefaults.standard
    
    // Outlets
    @IBOutlet weak var diningPlanLbl: UILabel!
    @IBOutlet weak var diningPointsLbl: UILabel!
    @IBOutlet weak var expectedDiningPointsView: CustomView!
    @IBOutlet weak var dropDown: UIPickerView!
    @IBOutlet var userTappedTitle: UITapGestureRecognizer!  // Tapped Dining Plan Title
    
    var diningPlanChoice = ""
    
    override func viewDidLoad() {
        customizeDropDown(userTappedTitle)
        
        DB_BASE.child("stats").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            var firebaseCount = value?["refresh"] as? Int ?? 0
            firebaseCount += 1
            DB_BASE.child("stats").child("refresh").setValue(firebaseCount)
        })
        
        // Count number of views on this page
        if let val1 = prefs.string(forKey: "userViewsDiningPointsVC") {
            if Int(val1)! == 20 || Int(val1)! % 60 == 0 {   // If the user has viewed this page 10 times or if their view is divisible by 40
                if #available(iOS 10.3, *) {
                    SKStoreReviewController.requestReview()     // Display a request for a review
                }
            }
            defaults.set((Int(val1)!+1), forKey: "userViewsDiningPointsVC")
        } else {
            defaults.set(0, forKey: "userViewsDiningPointsVC")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        customizeDropDown(userTappedTitle)
        
        // If user already saved a dining plan
        if let plan = prefs.string(forKey: "userDiningPlanDefaults") {
            diningPlanLbl.text = plan
            diningPlanChoice = plan
            
            self.calculateDiningPoints()
            self.setSchoolWeek()
            self.calculateBalance()
            
            switch plan {
            case "No Worries":
                dpDropDown.selectRow(at: 0)
            case "We've Got You Covered":
                dpDropDown.selectRow(at: 1)
            case "Weekend Away":
                dpDropDown.selectRow(at: 2)
            case "Forgot To Cook":
                dpDropDown.selectRow(at: 3)
            case "Grab And Go":
                dpDropDown.selectRow(at: 4)
            default:
                for index in 0...4 {
                    dpDropDown.deselectRow(at: index)
                }
            }
        } else {
            diningPlanChoice = "No Worries"
            diningPlanLbl.text = diningPlanChoice
            for index in 0...4 {
                dpDropDown.deselectRow(at: index)
            }
        }
        
        if prefs.string(forKey: "didDisplayMessageOnDiningPoints") != "Yes" {
            prefs.set("Yes", forKey: "didDisplayMessageOnDiningPoints")
            let alert = UIAlertController(title: "Where is the login button?", message: "I worked with IMT to move my Hungry Coug expected points functionality to the APU Mobile app. \nYou can now view your expected points and more information at mobile.apu.edu.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    // Apply custom attributes to Drop Down
    func customizeDropDown(_ sender: AnyObject) {
        
        // ACTION: User selected an item
        dpDropDown.selectionAction = { [] (index: Int, item: String) in
            self.defaults.set(item, forKey: "userDiningPlanDefaults")
            
            self.diningPlanLbl.text = item
            self.diningPlanChoice = item
            self.calculateDiningPoints()
            self.setSchoolWeek()
            self.calculateBalance()
        }
        
        // Set values for drop down list
        dpDropDown.dataSource = [
            "No Worries",
            "We've Got You Covered",
            "Weekend Away",
            "Forgot To Cook",
            "Grab And Go"
        ]
        
        // Preferences for behavior and location
        dpDropDown.dismissMode = .onTap // Options: .automatic or .onTap
        dpDropDown.direction = .any // Options: .any, .bottom, .top
        dpDropDown.bottomOffset = CGPoint(x: 0, y: -5)
        
        // Preferences for appearance
        let appearance = DropDown.appearance()
        appearance.cellHeight = 60
        appearance.cornerRadius = 10
        appearance.shadowRadius = 10
        appearance.shadowOpacity = 0.65
        appearance.animationduration = 0.25 // Duration of animation can be changed!
        appearance.textColor = .darkGray
        appearance.textFont = UIFont(name: "Georgia", size: 14.0)!
        appearance.shadowColor = .darkGray
        appearance.shadowOffset = CGSize(width: 5, height: 5)
        appearance.separatorColor = UIColor(white: 0.7, alpha: 0.8)
        appearance.backgroundColor = UIColor(white: 1.0, alpha: 1.0)
        appearance.selectionBackgroundColor = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 0.1)
        
        dpDropDown.cellNib = UINib(nibName: "MyCell", bundle: nil)
        dpDropDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
            guard let cell = cell as? MyCell else { return }
            
            // Setup your custom UI components
            cell.suffixLabel.text = "         " // Add grey sub-text for each label. Not necessary for now
        }
        
        // If user already saved a dining plan
        if let plan = prefs.string(forKey: "userDiningPlanDefaults") {
            switch plan {
            case "No Worries":
                dpDropDown.selectRow(at: 0)
            case "We've Got You Covered":
                dpDropDown.selectRow(at: 1)
            case "Weekend Away":
                dpDropDown.selectRow(at: 2)
            case "Forgot To Cook":
                dpDropDown.selectRow(at: 3)
            case "Grab And Go":
                dpDropDown.selectRow(at: 4)
            default:
                for index in 0...4 {
                    dpDropDown.deselectRow(at: index)
                }
            }
        }
    }
    
    // Segue to Settings
    @IBAction func settingsButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "settingsSegue", sender: nil)
    }
    
    // User selected Dining Plan drop down
    @IBAction func chooseDiningPlan(_ sender: AnyObject) {
        customizeDropDown(userTappedTitle)
        dpDropDown.show()
    }
    
    @IBAction func tappedTinyLabel(_ sender: Any) {
        customizeDropDown(userTappedTitle)
        dpDropDown.show()
    }
    
    @IBAction func tappedAPUMobile(_ sender: Any) {
        performSegue(withIdentifier: "mobileSegue", sender: nil)
    }
    
    
    /*
     Dining Points calculation functions
     */
    
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
    }
    
    func calculateBalance() {
        dailyBudget = mealBudget / 105.0
        weeklyBudget = dailyBudget * 7.0
        
        // Balance for summer vacation and winter vacation
        if schoolWeek == -1 {
            expectedBalance = mealBudget
        }
        
        // Balance for mid-semester break
        else if schoolWeek == -2 {
            expectedBalance = mealBudget/2
        }
        // Balance for rest of the year
        else {
            expectedBalance = mealBudget - (weeklyBudget * Double(schoolWeek)) - (dailyBudget * Double(weekday)) + dailyBudget
        }
        
        // Update expected balance label
        let textNum = String(format: "%.2f", arguments: [expectedBalance])
        diningPointsLbl.text = textNum
    }
    
    // Set the date manualy to test the calculator
    func manuallySetDay(_ mm: Int, dd: Int, woy: Int, yyyy: Int, wday: Int) {
        month = mm
        day = dd
        weekOfYear = woy
        year = yyyy
        weekday = wday
    }
    
    /*
     
     How it works: 
     The switch covers every week of the year from 1 to 52 (also 53).
     One must manually enter the schoolweek for each week of the year within the switch. 
     Looking at a calendar, I see that the school year starts on August 28, which is week 35 on a calendar, 
     so I adjust the switch cases accordingly for this school year. Some school years will be the same as the
     previous year, so no adjustments are necessary.
     
    */
    func setSchoolWeek() {
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.weekday, .day, .weekOfYear, .month, .year], from: date as Date)
        weekday = components.weekday!
        weekOfYear = components.weekOfYear!
        day = components.day!
        month = components.month!
        year = components.year!
        
        // Optional function for testing a day
        // manuallySetDay(1, dd: 18, woy: 1, yyyy: 2017, wday: 4)
        
        todayDate = String("\(month).\(day).\(year-2000)")
        
        switch weekOfYear {
        case 1:                 // week 1 is winter vacation
            schoolWeek = -1     // -1 means school is not currently in session
            break
            
        case 2, 35:
            schoolWeek = 0      // 0 means first day of semester
            break
        case 3, 36:
            schoolWeek = 1
            break
        case 4, 37:
            schoolWeek = 2
            break
        case 5, 38:
            schoolWeek = 3
            break
        case 6, 39:
            schoolWeek = 4
            break
        case 7, 40:
            schoolWeek = 5
            break
        case 8, 41:
            schoolWeek = 6
            break
        case 9, 42:
            schoolWeek = 7
            break
            
        case 10:
            schoolWeek = -2     // -2 means mid-semester break
            break
            
        case 11, 43:
            schoolWeek = 8
            break
        case 12, 44:
            schoolWeek = 9
            break
        case 13, 45:
            schoolWeek = 10
            break
        case 14, 46:
            schoolWeek = 11
            break
        case 15, 47:
            schoolWeek = 12
            break
        case 16, 48:
            schoolWeek = 13
            break
        case 17, 49:
            schoolWeek = 14
            break
        case 18, 50:
            schoolWeek = 15
            break
            
        case 19...34:           // weeks 19 to 34 are summer vacation
            schoolWeek = -1     // -1 means school is not currently in session
            break

        case 51...53:           // weeks 51 and 52 are winter vacation, week 53 will occur in the year 2020
            schoolWeek = -1     // -1 means school is not currently in session
            break
            
        default:
            // switch is exhaustive, so default will not execute
            break
        }
    }
    
    func monthBetweenDays(MM: Int, ST: Int, ED: Int) -> Bool {
        if month == MM && (day >= ST && day <= ED) {
            return true
        } else {
            return false
        }
    }
}
