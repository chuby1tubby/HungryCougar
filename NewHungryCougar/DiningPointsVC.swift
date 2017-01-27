//
//  DiningPointsVC.swift
//  Hungry Cougar 2.0
//
//  Created by Kyle Nakamura on 8/9/16.
//  Copyright © 2016 Kyle Nakamura. All rights reserved.
//

import UIKit
import DropDown

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
    let mealBudgets: [Double] = [1162, 978, 696, 554, 363]
    let dpDropDown = DropDown()   // Create a new drop down object
    
    // Outlets
    @IBOutlet weak var refreshBtn: UIButton!
    @IBOutlet weak var diningPlanLbl: UILabel!
    @IBOutlet weak var diningPointsLbl: UILabel!
    @IBOutlet weak var usersDiningPointsLbl: DontCutMe!
    @IBOutlet weak var expectedDiningPointsView: CustomView!
    @IBOutlet weak var usersDiningPointsView: CustomView!
    @IBOutlet weak var loginView: CustomView!
    @IBOutlet var userTappedTitle: UITapGestureRecognizer!  // Tapped Dining Plan Title
    @IBOutlet weak var allPointsView: UIView!
    
    override func viewDidLoad() {
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        customizeDropDown(userTappedTitle)

        let prefs = UserDefaults.standard
        if let value = prefs.string(forKey: "userDiningPointsDefaults") {
            usersDiningPointsView.isHidden = false
            refreshBtn.isHidden = false
            loginView.isHidden = true
            
            // Update current dining points balance label
            usersDiningPointsLbl.text = value
        } else {
            if didReceievePointsVal == true {
                usersDiningPointsView.isHidden = false
                refreshBtn.isHidden = false
                loginView.isHidden = true
                
                // Update current dining points balance label
                let textNum = String(format: "%.2f", arguments: [myFinalDouble])
                usersDiningPointsLbl.text = textNum
                
                // Store dining points in UserDefaults
                let defaults = UserDefaults.standard
                defaults.set(textNum, forKey: "userDiningPointsDefaults")
            }
        }
        
        // If user already saved a dining plan
        if let plan = prefs.string(forKey: "userDiningPlanDefaults") {
            diningPlanLbl.text = plan
            diningPlanChoice = plan
            
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
        
        calculateDiningPoints()
        setSchoolWeek()
        calculateBalance()
    }
    
    func setupViews() {
        usersDiningPointsView.isHidden = true
        refreshBtn.isHidden = true
        loginView.isHidden = false
        loginView.isHidden = false
        diningPlanLbl.text = diningPlanChoice
    }
    
    // Apply custom attributes to Drop Down
    func customizeDropDown(_ sender: AnyObject) {
        
        // ACTION: User selected an item
        dpDropDown.selectionAction = { [] (index: Int, item: String) in
            print("KYLE: Selected item: \(item)")
            let defaults = UserDefaults.standard
            defaults.set(item, forKey: "userDiningPlanDefaults")
            
            self.diningPlanLbl.text = item
            diningPlanChoice = item
            self.calculateDiningPoints()
            self.setSchoolWeek()
            self.calculateBalance()
            
            self.moveEverything()
        }
        
        // ACTION: User cancelled dropDown
        dpDropDown.cancelAction = { [unowned self] in
            self.moveEverything()
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
        let prefs = UserDefaults.standard
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
    
    // Main function for performing login
    func loginFunction() {
        let prefs = UserDefaults.standard
        if let name = prefs.string(forKey: "username") {
            if let pass = prefs.string(forKey: "password") {
                usernameStr = name
                passwordStr = pass
            }
        }
        performSegue(withIdentifier: "APUHome", sender: nil)
    }
    
    /*
     *  Actions
    */
    
    // Refresh dining points balance manually
    @IBAction func onRefreshPressed(_ sender: Any) {
        loginFunction()
    }
    
    // Load dining points when no balance has been stored
    @IBAction func clickToLoadPressed(_ sender: Any) {
        let prefs = UserDefaults.standard
        if let _ = prefs.string(forKey: "username") {
            if let _ = prefs.string(forKey: "password") {
                loginFunction()
            } else {
                presentAlertToUser()
            }
        } else {
            presentAlertToUser()
        }
    }
    
    // Segue to Points History
    @IBAction func pointsHistoryButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "pointsHistorySegue", sender: nil)
    }
    
    // Segue to Settings
    @IBAction func settingsButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "settingsSegue", sender: nil)
    }
    
    // User selected Dining Plan drop down
    @IBAction func chooseDiningPlan(_ sender: AnyObject) {
        customizeDropDown(userTappedTitle)
        dpDropDown.show()
        self.moveEverything()
    }
    
    func moveEverything() {
        let namedView = self.allPointsView
        let centerPoint = self.view.frame.midY
        print("KYLE: CenterPoint = \(centerPoint)")
        print("KYLE: CenterPointWithOffset = \(centerPoint + 50)")
        print("KYLE: Actual origin.y = \(self.allPointsView.frame.origin.y)")
        // Move the views
        if Double((self.allPointsView.frame.origin.y)) == Double(centerPoint - 60) {
            UIView.animate(withDuration: 0.25, delay: 0, options: [.curveEaseOut], animations: {
                namedView?.frame.origin.y += 220
            }, completion: nil)
            } else {
            UIView.animate(withDuration: 0.25, delay: 0, options: [.curveEaseOut], animations: {
                namedView?.frame.origin.y -= 220
            }, completion: nil)
        }
    }
    // Alert user that navigation away from Dining Services is denied
    func presentAlertToUser() {
        let alert = UIAlertController(title: "Missing Login Details", message: "Please update your account details in the settings page.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
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
        dailyBudget = mealBudget / 112.0
        weeklyBudget = dailyBudget * 7.0
        
        // Balance for summer vacation and winter vacation
        if schoolWeek == -1 {
            expectedBalance = 0.0
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
//        manuallySetDay(1, dd: 18, woy: 1, yyyy: 2017, wday: 4)
        
        todayDate = String("\(month).\(day).\(year-2000)")
        
        // School has yet to begin
        if month == 1 && day < 8 {
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
        
        // November
        if (month == 10 && (day >= 30 && day <= 31) || month == 11 && (day >= 1 && day <= 5)) {
            schoolWeek = 9
        } else if (month == 11 && (day >= 6 && day <= 12)) {
            schoolWeek = 10
        } else if (month == 11 && (day >= 13 && day <= 19)) {
            schoolWeek = 11
        } else if (month == 11 && (day >= 20 && day <= 26)) {
            schoolWeek = 12
        }
        
        // December
        if (month == 11 && (day >= 27 && day <= 30) || month == 12 && (day >= 1 && day <= 3)) {
            schoolWeek = 13
        } else if (month == 12 && (day >= 4 && day <= 10)) {
            schoolWeek = 14
        } else if (month == 12 && (day >= 11 && day <= 17)) {
            schoolWeek = 15
        }
        
 
        /*
         *
         * NEW SEMESTER
         *
         */
        
        
        // Christmas break
        if monthBetweenDays(MM: 12, ST: 18, ED: 31) || monthBetweenDays(MM: 1, ST: 1, ED: 14) {
            schoolWeek = -1
        }
        
        // January
        if monthBetweenDays(MM: 1, ST: 8, ED: 14) {
            schoolWeek = 0
        } else if monthBetweenDays(MM: 1, ST: 15, ED: 21) {
            schoolWeek = 1
        } else if monthBetweenDays(MM: 1, ST: 22, ED: 28) {
            schoolWeek = 2
        } else if monthBetweenDays(MM: 1, ST: 29, ED: 31) || monthBetweenDays(MM: 2, ST: 1, ED: 4) {
            schoolWeek = 3
        }
        print("KYLE: The school week is: \(schoolWeek)")
        
        // February
        if monthBetweenDays(MM: 2, ST: 5, ED: 11) {
            schoolWeek = 4
        } else if monthBetweenDays(MM: 2, ST: 12, ED: 18) {
            schoolWeek = 5
        } else if monthBetweenDays(MM: 2, ST: 19, ED: 25) {
            schoolWeek = 6
        } else if monthBetweenDays(MM: 2, ST: 26, ED: 28) || monthBetweenDays(MM: 3, ST: 1, ED: 4) {
            schoolWeek = 7
        }
        
        // Mid-Semester Break
        if monthBetweenDays(MM: 3, ST: 5, ED: 11) {
            schoolWeek = -2
        }
        
        // March
        if monthBetweenDays(MM: 3, ST: 12, ED: 18) {
            schoolWeek = 8
        } else if monthBetweenDays(MM: 3, ST: 19, ED: 25) {
            schoolWeek = 9
        }
        
        // April
        if monthBetweenDays(MM: 3, ST: 26, ED: 31) || todayDate == "3.1.1" {
            schoolWeek = 10
        } else if monthBetweenDays(MM: 4, ST: 2, ED: 8) {
            schoolWeek = 11
        } else if monthBetweenDays(MM: 4, ST: 9, ED: 15) {
            schoolWeek = 12
        } else if monthBetweenDays(MM: 4, ST: 16, ED: 22) {
            schoolWeek = 13
        } else if monthBetweenDays(MM: 4, ST: 23, ED: 29) {
            schoolWeek = 14
        } else if monthBetweenDays(MM: 4, ST: 24, ED: 30) {
            schoolWeek = 15
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
