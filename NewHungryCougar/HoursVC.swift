//
//  HoursVC.swift
//  Open Den
//
//  Created by Kyle Nakamura on 7/31/16.
//  Copyright © 2016 Kyle Nakamura. All rights reserved.
//

import UIKit
import DropDown
import Firebase

public var restaurantChoice = ""
public var loadedDataFromFirebase = false

class HoursVC: UIViewController {
    // Base values
    var now: Int = 0
    var minutesLeft: Int = 0
    var currentMinute: Int = 0
    var minutesUntilOpen: Int = 0
    var minutesUntilClose: Int = 0
    var storeIsOpen: Bool = false
    let dpDropDown = DropDown()   // Create a new drop down object
    
    var oldTodayOpenTime = 0
    var oldTodayCloseTime = 0
    var oldTomorrowOpenTime = 0
    var oldTomorrowCloseTime = 0
    
    // IBOutlets
    @IBOutlet weak var yesNoLbl: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet var userTappedHours: UITapGestureRecognizer!
    @IBOutlet var alsoTappedHours: UITapGestureRecognizer!
    
    // Loads right before view appears
    override func viewWillAppear(_ animated: Bool) {
        self.title = restaurantChoice
        loadCurrentDateTime()
        setHours()
        timeLabel.text = "Loading hours..."
        yesNoLbl.text = "..."
    }
    
    override func viewDidAppear(_ animated: Bool) {
        while true {
            if loadedDataFromFirebase == true {
                self.checkIfOpen()
                self.calculateTimeUntilOpen()
                self.displayTimeUntilOpen()
                break
            }
        }
    }
    
    // Apply custom attributes to Drop Down
    func customizeDropDown(_ sender: AnyObject) {
        
        var dayOpenString = ""
        var dayCloseString = ""
        var sundayOpenString = ""
        var mondayOpenString = ""
        var tuesdayOpenString = ""
        var wednesdayOpenString = ""
        var thursdayOpenString = ""
        var fridayOpenString = ""
        var saturdayOpenString = ""
        var sundayCloseString = ""
        var mondayCloseString = ""
        var tuesdayCloseString = ""
        var wednesdayCloseString = ""
        var thursdayCloseString = ""
        var fridayCloseString = ""
        var saturdayCloseString = ""
        
        for (index, day) in daysOfTheWeek.enumerated() {        // 9:30am  == 0930
            var dayOpen = day.openTime
            var dayClose = day.closeTime
            
            if day.openTime > 1200 {
                dayOpen = dayOpen - 1200
            }
            if day.closeTime > 1200 {
                dayClose = dayClose - 1200
            }
            
            dayOpenString = "\(dayOpen / 100):\(day.openTime - Int(day.openTime/100)*100)"
            dayCloseString = "\(dayClose / 100):\(day.closeTime - Int(day.closeTime/100)*100)"
            
            if (day.openTime - Int(day.openTime/100)*100) == 0 {
                dayOpenString.append("0")
            }
            if (day.closeTime - Int(day.closeTime/100)*100) == 0 {
                dayCloseString.append("0")
            }
            
            if day.openTime < 1200 {
                dayOpenString.append("am")
            } else {
                dayOpenString.append("pm")
            }
            if day.closeTime < 1200 {
                dayCloseString.append("am")
            } else {
                dayCloseString.append("pm")
            }
            
            if dayCloseString.contains("11:59") {
                dayCloseString = "midnight"
            }
            
            if day.openTime == 0 && day.closeTime == 0 {
                dayOpenString = "Closed"
                dayCloseString = ""
            } else {
                dayOpenString.append(" -")
            }
            
            switch index {
            case 0:
                sundayOpenString = dayOpenString
                sundayCloseString = dayCloseString
                break
            case 1:
                mondayOpenString = dayOpenString
                mondayCloseString = dayCloseString
                break
            case 2:
                tuesdayOpenString = dayOpenString
                tuesdayCloseString = dayCloseString
                break
            case 3:
                wednesdayOpenString = dayOpenString
                wednesdayCloseString = dayCloseString
                break
            case 4:
                thursdayOpenString = dayOpenString
                thursdayCloseString = dayCloseString
                break
            case 5:
                fridayOpenString = dayOpenString
                fridayCloseString = dayCloseString
                break
            case 6:
                saturdayOpenString = dayOpenString
                saturdayCloseString = dayCloseString
                break
            default:
                break
            }
        }
        
        // Set values for drop down list
        dpDropDown.dataSource = [
            "Sunday              \(sundayOpenString) \(sundayCloseString)",
            "Monday             \(mondayOpenString) \(mondayCloseString)",
            "Tuesday             \(tuesdayOpenString) \(tuesdayCloseString)",
            "Wednesday        \(wednesdayOpenString) \(wednesdayCloseString)",
            "Thursday            \(thursdayOpenString) \(thursdayCloseString)",
            "Friday                 \(fridayOpenString) \(fridayCloseString)",
            "Saturday            \(saturdayOpenString) \(saturdayCloseString)"
        ]
        
        // Preferences for behavior and location
        dpDropDown.dismissMode = .onTap // Options: .automatic or .onTap
        dpDropDown.direction = .bottom // Options: .any, .bottom, .top
        dpDropDown.bottomOffset = CGPoint(x: 5, y: 135)
        
        // Preferences for appearance
        let appearance = DropDown.appearance()
        appearance.cellHeight = 35
        appearance.cornerRadius = 5
        appearance.animationduration = 0.15 // Duration of animation can be changed!
        appearance.textColor = .white
        appearance.shadowOpacity = 0
        appearance.textFont = UIFont(name: "Helvetica Neue", size: 14.0)!
        appearance.separatorColor = UIColor(white: 0.7, alpha: 0)
        appearance.backgroundColor = UIColor(colorLiteralRed: 150/256, green: 38/256, blue: 35/256, alpha: 1)
        appearance.selectionBackgroundColor = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 0.1)
        
        dpDropDown.cellNib = UINib(nibName: "MyCell", bundle: nil)
        dpDropDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
            guard let cell = cell as? MyCell else { return }
            
            // Setup your custom UI components
            cell.suffixLabel.text = "" // Add grey sub-text for each label. Not necessary for now
        }
    }
    
    @IBAction func showRestaurantHoursDropDown(_ sender: Any) {
        customizeDropDown(userTappedHours)
        dpDropDown.show()
    }
   
    @IBAction func tappedDropdownIcon(_ sender: Any) {
        showRestaurantHoursDropDown(alsoTappedHours)
    }
    
    // Set the date manualy to test the calculator
    func manuallySetDay(_ mm: Int, dd: Int, yyyy: Int, wday: Int, hr: Int, min: Int) {
        month = mm
        day = dd
        year = yyyy
        weekday = wday
        hour = hr
        minute = min
    }
    
    func loadCurrentDateTime() {
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.minute, .hour, .weekday], from: date as Date)
        let weekday = components.weekday
        var hour = components.hour
        var minute = components.minute
        
        // Manually set current date and time
        //        manuallySetDay(1, dd: 18, yyyy: 2017, wday: 4, hr: 7, min: 37)
        
        hour = 16
        minute = 59
        
        now = hour! * 100 + minute!                         // Time is converted to format: HH:MM (9:30am = 0930)
        
        // Set current day hours
        switch weekday! {
        case 1:
            Yesterday = Saturday
            Today = Sunday
            Tomorrow = Monday
        case 2:
            Yesterday = Sunday
            Today = Monday
            Tomorrow = Tuesday
        case 3:
            Yesterday = Monday
            Today = Tuesday
            Tomorrow = Wednesday
        case 4:
            Yesterday = Tuesday
            Today = Wednesday
            Tomorrow = Thursday
        case 5:
            Yesterday = Wednesday
            Today = Thursday
            Tomorrow = Friday
        case 6:
            Yesterday = Thursday
            Today = Friday
            Tomorrow = Saturday
        case 7:
            Yesterday = Friday
            Today = Saturday
            Tomorrow = Sunday
        default:
            yesNoLbl.text = "ERR"
            storeIsOpen = true
        }
    }
    
    func checkIfOpen() {
        // Default values
        yesNoLbl.text = "OPEN"
        storeIsOpen = true
        
        // If current time is between midnight and open time
        if now < Today.openTime {
            // If yesterday closed at normal hours
            if Yesterday.closeTime > 0200 {
                storeIsOpen = false
                print("KYLE: OPEN-CLOSE BOOL #1")
            } else {
                // If time has past yesterday close time
                if now >= Yesterday.closeTime {
                    storeIsOpen = false
                    print("KYLE: OPEN-CLOSE BOOL #2")
                }
            }
        }
        // Else if current time is between open time and 11:59pm
        else {
            // If today closes after midnight
            if Today.closeTime <= 0200 {
                print("KYLE: OPEN-CLOSE BOOL #3")
                print("KYLE: STORE IS OPEN")
                storeIsOpen = true
            } else {
                // If current time is after today close time
                if now >= Today.closeTime {
                    storeIsOpen = false
                    print("KYLE: OPEN-CLOSE BOOL #4")
                }
            }
        }
        
        // Extra cases for Dining Hall and Fusion Grill due to mid-day breaks
        if restaurantChoice == "1899 Dining Hall" && Today.openTime == Monday.openTime && Today.closeTime == Monday.closeTime {
            if now >= 0950 && now < 1100 {
                storeIsOpen = false
            } else if now >= 1400 && now < 1020 {
                storeIsOpen = false

            }
        } else if restaurantChoice == "The Grill at Heritage" && Today.openTime == Monday.openTime && Today.closeTime == Monday.closeTime {
            if now >= 1000 && now < 1030 {
                storeIsOpen = false
            }
        }
        
        if Today.hasNoHours {
            storeIsOpen = false
        }
        
        // Set yesNoLabel
        if storeIsOpen {
            yesNoLbl.text = "OPEN"
        } else {
            yesNoLbl.text = "CLOSED"
        }
    }
    
    func calculateTimeUntilOpen() {
        // If the store is CLOSED
        if storeIsOpen == false {
            if Today.openTime > now {
                minutesUntilOpen = Today.openTime - now
            } else {
                minutesUntilOpen = Tomorrow.openTime + (2359 - now)
            }
        }
        // If the store is OPEN
        else {
            if Today.closeTime > now {
                if now < 0200 {
                    minutesUntilClose = Yesterday.closeTime - now - 40      // PROBLEMATIC CODE HERE! MINUTESUNTILCLOSE NEEDS TO COMPENSATE FOR DIFFERENT TIMES WHERE 1700-1659, FOR EXAMPLE, SHOULD BE 1 (SO SUBTRACT 40), BUT 1730-1700 SHOULD BE 30, AND 1700-1601 SHOULD BE 59 (SO SUBTRACT 40)
                } else {
                    minutesUntilClose = Today.closeTime - now - 40
                }
            } else {
                minutesUntilClose = 2360 - now + Today.closeTime
            }
        }
        
        // Extra cases for Dining Hall and Fusion Grill due to mid-day breaks
        if restaurantChoice == "1899 Dining Hall" && Today.openTime == Monday.openTime && Today.closeTime == Monday.closeTime {
            if now >= 0930 && now < 1100 {
                minutesUntilOpen = 1100 - now
            } else if now >= 1400 && now < 1700 {
                minutesUntilOpen = 1700 - now
            }
        } else if restaurantChoice == "The Grill at Heritage" && Today.openTime == Monday.openTime && Today.closeTime == Monday.closeTime {
            if now >= 1000 && now < 1030 {
                minutesUntilOpen = 1030 - now
            }
        }
        
        // Set minutesLeft value
        if minutesUntilClose != 0 {
            minutesLeft = minutesUntilClose
        } else if minutesUntilOpen != 0 {
            minutesLeft = minutesUntilOpen
        }
    }
    
    func displayTimeUntilOpen() {
        var HHOpen = Today.openTime/100
        if HHOpen > 12 {
            HHOpen = HHOpen - 12
        }
        let MMOpen = Today.openTime - Int(Today.openTime/100)*100
        var HHClose = Today.closeTime/100
        if HHClose > 12 {
            HHClose = HHClose - 12
        }
        let MMClose = Today.closeTime - Int(Today.closeTime/100)*100
        
        var HHOpenTomorrow = Tomorrow.openTime/100
        if HHOpenTomorrow > 12 {
            HHOpenTomorrow = HHOpenTomorrow - 12
        }
        let MMOpenTomorrow = Tomorrow.openTime - Int(Tomorrow.openTime/100)*100
        var HHCloseTomorrow = Tomorrow.closeTime/100
        if HHCloseTomorrow > 12 {
            HHCloseTomorrow = HHCloseTomorrow - 12
        }
        let MMCloseTomorrow = Tomorrow.closeTime - Int(Tomorrow.closeTime/100)*100
        
        // If the store is CLOSED
        if storeIsOpen == false {
            // If store has no hours today
            if Today.hasNoHours {
                timeLabel.text = "Closed all day today"
                Today.hasNoHours = false
                // If store also has no hours tomorrow
                if Tomorrow.hasNoHours {
                    timeLabel.text = "Closed until Monday"
                    Tomorrow.hasNoHours = false
                }
            }
            else {
                if Tomorrow.hasNoHours && now > Today.openTime {   // Note: Should find a more elegant solution for this
                    timeLabel.text = "Closed all day tomorrow"
                    if Sunday.hasNoHours {
                        timeLabel.text = "Closed until Monday"
                    }
                } else {
                    // Calculate hours until open only if store is opening soon
                    if minutesLeft < 60 {
                        timeLabel.text = "Opening in \(minutesLeft) minutes"
                    }
                    else {
                        // If currently between midnight and open hours (0 to 7am roughly)
                        if now < Today.openTime {
                            timeLabel.text = "Opening at \(HHOpen):\(MMOpen)"
                        }
                        // If currently between roughly 7am and midnight
                        else {
                            timeLabel.text = "Opening at \(HHOpenTomorrow):\(MMOpenTomorrow)"
                        }
                    }
                }
            }
        }
        // If the store is OPEN
        else {
            if minutesLeft < 60 {
                timeLabel.text = "Closing in \(minutesLeft) minutes"
            } else {
                if ((Yesterday.closeTime == 0 || Yesterday.closeTime == 2359) && now < 0200) || ((Today.closeTime == 0 || Today.closeTime == 2359) && now >= 0200) {
                    print("KYLE: Display time BOOL #9")
                    timeLabel.text = "Closing at midnight"
                } else if (Yesterday.closeTime == 0100 && now < 0200) || (Today.closeTime == 0100 && now >= 0200) {
                    print("KYLE: Display time BOOL #10")
                    timeLabel.text = "Closing at 1am"
                } else {
                    var timeString = ""
                    timeString = "Closing at \(HHClose):\(MMClose)"
                    
                    if (Today.closeTime - Int(Today.closeTime/100)*100) == 0 {
                        timeString.append("0")
                    }
                    if Today.closeTime < 1200 {
                        timeString.append("am")
                    } else {
                        timeString.append("pm")
                    }
                    timeLabel.text = timeString
                }
            }
        }
        
        // Extra cases for Dining Hall and Fusion Grill due to mid-day breaks
        if restaurantChoice == "1899 Dining Hall" && Today.openTime == Monday.openTime && Today.closeTime == Monday.closeTime {
            if now >= 0930 && now < 1100 {
                timeLabel.text = "Opening at 11am\nfor lunch"
            } else if now >= 1400 && now < 1700 {
                timeLabel.text = "Opening at 5pm\nfor dinner"
            }
        } else if restaurantChoice == "The Grill at Heritage" && Today.openTime == Monday.openTime && Today.closeTime == Monday.closeTime {
            if now >= 1000 && now < 1030 {
                timeLabel.text = "Opening at 10:30am\nfor lunch"
            }
        }
    }
}
