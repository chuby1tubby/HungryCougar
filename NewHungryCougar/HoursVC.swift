//
//  HoursVC.swift
//  Open Den
//
//  Created by Kyle Nakamura on 7/31/16.
//  Copyright © 2016 Kyle Nakamura. All rights reserved.
//

import UIKit
import DropDown

public var restaurantChoice = ""

class HoursVC: UIViewController {
    // Base values
    var minutesLeft: Int = 0
    var currentMinute: Int = 0
    var minutesUntilOpen: Int = 0
    var minutesUntilClose: Int = 0
    var currentTimeInMinutes: Int = 0
    var storeIsOpen: Bool = false
    let dpDropDown = DropDown()   // Create a new drop down object
    
    // IBOutlets
    @IBOutlet weak var yesNoLbl: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet var userTappedHours: UITapGestureRecognizer!
    
    // Loads right before view appears
    override func viewWillAppear(_ animated: Bool) {
        self.title = restaurantChoice
        setHours()
        loadCurrentDateTime()
        checkIfOpen()
        calculateTimeUntilOpen()
        displayTimeUntilOpen()
    }
    
    // Apply custom attributes to Drop Down
    func customizeDropDown(_ sender: AnyObject) {
        
        // Set values for drop down list
        dpDropDown.dataSource = [
            "Sunday              5:00am - 10:00pm",
            "Monday             5:00am - 10:00pm",
            "Tuesday             5:00am - 10:00pm",
            "Wednesday        5:00am - 10:00pm",
            "Thursday            5:00am - 10:00pm",
            "Friday                 5:00am - 10:00pm",
            "Saturday            5:00am - 10:00pm"
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
        let hour = components.hour
        let minute = components.minute
        
        // Manually set current date and time
        //        manuallySetDay(1, dd: 18, yyyy: 2017, wday: 4, hr: 7, min: 37)
        
        currentTimeInMinutes = (hour! * 60) + minute!
        
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
        if currentTimeInMinutes < Today.openTime {
            // If yesterday closed at normal hours
            if Yesterday.closeTime > 120 {
                storeIsOpen = false
                print("KYLE: OPEN-CLOSE BOOL #1")
            } else {
                // If time has past yesterday close time
                if currentTimeInMinutes >= Yesterday.closeTime {
                    storeIsOpen = false
                    print("KYLE: OPEN-CLOSE BOOL #2")
                }
            }
        }
        // Else if current time is between open time and 11:59pm
        else {
            // If today closes after midnight
            if Today.closeTime <= 120 {
                print("KYLE: OPEN-CLOSE BOOL #3")
                print("KYLE: STORE IS OPEN")
                storeIsOpen = true
            } else {
                // If current time is after today close time
                if currentTimeInMinutes >= Today.closeTime {
                    storeIsOpen = false
                    print("KYLE: OPEN-CLOSE BOOL #4")
                }
            }
        }
        
        // Extra cases for Dining Hall and Fusion Grill due to mid-day breaks
        if restaurantChoice == "1899 Dining Hall" && Today.openTime == Monday.openTime && Today.closeTime == Monday.closeTime {
            if currentTimeInMinutes >= 570 && currentTimeInMinutes < 660 {
                storeIsOpen = false
                print("KYLE: TRIGGERED WRONG BOOLEAN")
            } else if currentTimeInMinutes >= 840 && currentTimeInMinutes < 1020 {
                storeIsOpen = false
                print("KYLE: TRIGGERED WRONG BOOLEAN")

            }
        } else if restaurantChoice == "The Grill at Heritage" && Today.openTime == Monday.openTime && Today.closeTime == Monday.closeTime {
            if currentTimeInMinutes >= 600 && currentTimeInMinutes < 630 {
                storeIsOpen = false
                print("KYLE: TRIGGERED WRONG BOOLEAN")

            }
        }
        
        if Today.hasNoHours {
            storeIsOpen = false
            print("KYLE: TRIGGERED WRONG BOOLEAN")

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
            if Today.openTime > currentTimeInMinutes {
                minutesUntilOpen = Today.openTime - currentTimeInMinutes
            } else {
                minutesUntilOpen = Tomorrow.openTime + (1439 - currentTimeInMinutes)
            }
        }
            // If the store is OPEN
        else {
            if Today.closeTime > currentTimeInMinutes {
                if currentTimeInMinutes < 120 {
                    minutesUntilClose = Yesterday.closeTime - currentTimeInMinutes
                } else {
                    minutesUntilClose = Today.closeTime - currentTimeInMinutes
                }
            } else {
                minutesUntilClose = 1439 - currentTimeInMinutes + Today.closeTime
            }
        }
        
        // Extra cases for Dining Hall and Fusion Grill due to mid-day breaks
        if restaurantChoice == "1899 Dining Hall" && Today.openTime == Monday.openTime && Today.closeTime == Monday.closeTime {
            if currentTimeInMinutes >= 570 && currentTimeInMinutes < 660 {
                minutesUntilOpen = 660 - currentTimeInMinutes
            } else if currentTimeInMinutes >= 840 && currentTimeInMinutes < 1020 {
                minutesUntilOpen = 1020 - currentTimeInMinutes
            }
        } else if restaurantChoice == "The Grill at Heritage" && Today.openTime == Monday.openTime && Today.closeTime == Monday.closeTime {
            if currentTimeInMinutes >= 600 && currentTimeInMinutes < 630 {
                minutesUntilOpen = 630 - currentTimeInMinutes
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
                if Tomorrow.hasNoHours {
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
                        if currentTimeInMinutes < Today.openTime {
                            // For whole numbers
                            if floor(Double(Today.openTime / 60)) == Double(Today.openTime) / 60.0 {
                                // If opens before 12:00pm
                                if Today.openTime < 720 {
                                    print("KYLE: Display time BOOL #1")
                                    timeLabel.text = "Opening at \(Today.openTime / 60)am"
                                } else {
                                    print("KYLE: Display time BOOL #2")
                                    timeLabel.text = "Opening at \((Today.openTime / 60) - 12)pm"
                                }
                            } else {
                                // If opens before 12:30pm
                                if Tomorrow.openTime < 750 {
                                    print("KYLE: Display time BOOL #3")
                                    timeLabel.text = "Opening at \(Int(floor(Double(Tomorrow.openTime) / 60.0))):30am"
                                } else {
                                    print("KYLE: Display time BOOL #4")
                                    timeLabel.text = "Opening at \(Int(floor(Double(Tomorrow.openTime) / 60.0)) - 12):30pm"
                                }
                            }
                        }
                        // If currently between roughly 7am and midnight
                        else {
                            // For whole numbers
                            if floor(Double(Tomorrow.openTime) / 60.0) == Double(Tomorrow.openTime) / 60.0 {
                                // If opens before 12:00pm
                                if Tomorrow.openTime < 720 {
                                    print("KYLE: Display time BOOL #5")
                                    timeLabel.text = "Opening at \(Tomorrow.openTime / 60)am"
                                } else {
                                    print("KYLE: Display time BOOL #6")
                                    timeLabel.text = "Opening at \((Tomorrow.openTime / 60) - 12)pm"
                                }
                            } else {
                                // If opens before 12:30pm
                                if Tomorrow.openTime < 750 {
                                    print("KYLE: Display time BOOL #7")
                                    timeLabel.text = "Opening at \(Int(floor(Double(Tomorrow.openTime) / 60.0))):30am"
                                } else {
                                    print("KYLE: Display time BOOL #8")
                                    timeLabel.text = "Opening at \(Int(floor(Double(Tomorrow.openTime) / 60.0)) - 12):30pm"
                                }
                            }
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
                if (Yesterday.closeTime == 0 && currentTimeInMinutes < 120) || (Today.closeTime == 0 && currentTimeInMinutes >= 120) {
                    print("KYLE: Display time BOOL #9")
                    timeLabel.text = "Closing at midnight"
                } else if (Yesterday.closeTime == 60 && currentTimeInMinutes < 120) || (Today.closeTime == 60 && currentTimeInMinutes >= 120) {
                    print("KYLE: Display time BOOL #10")
                    timeLabel.text = "Closing at 1am"
                } else {
                    if floor(Double(Today.closeTime)/60.0) == (Double(Today.closeTime) / 60.0) {
                        if Today.closeTime < 720 {
                            print("KYLE: Display time BOOL #11")
                            timeLabel.text = "Closing at \(Today.closeTime / 60)pm"
                        } else {
                            print("KYLE: Display time BOOL #12")
                            timeLabel.text = "Closing at \(Today.closeTime / 60 - 12)pm"
                        }
                    } else {
                        if Today.closeTime < 750 {
                            print("KYLE: Display time BOOL #13")
                            timeLabel.text = "Closing at \(Int(floor(Double(Today.closeTime) / 60.0))):30pm"
                        } else {
                            print("KYLE: Display time BOOL #14")
                            timeLabel.text = "Closing at \(Int(floor(Double(Today.closeTime) / 60.0)) - 12):30pm"
                        }
                    }
                }
            }
        }
        
        // Extra cases for Dining Hall and Fusion Grill due to mid-day breaks
        if restaurantChoice == "1899 Dining Hall" && Today.openTime == Monday.openTime && Today.closeTime == Monday.closeTime {
            if currentTimeInMinutes >= 570 && currentTimeInMinutes < 660 {
                timeLabel.text = "Opening at 11am\nfor lunch"
            } else if currentTimeInMinutes >= 840 && currentTimeInMinutes < 1020 {
                timeLabel.text = "Opening at 5pm\nfor dinner"
            }
        } else if restaurantChoice == "The Grill at Heritage" && Today.openTime == Monday.openTime && Today.closeTime == Monday.closeTime {
            if currentTimeInMinutes >= 600 && currentTimeInMinutes < 630 {
                timeLabel.text = "Opening at 10:30am\nfor lunch"
            }
        }
    }
}
