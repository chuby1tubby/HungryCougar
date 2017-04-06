//
//  InformationVC.swift
//  Hungry Cougar 2.0
//
//  Created by Kyle Nakamura on 8/20/16.
//  Copyright © 2016 Kyle Nakamura. All rights reserved.
//

import UIKit
import WebKit

class InformationVC: UIViewController, WKNavigationDelegate, WKUIDelegate, UIWebViewDelegate {
    
    // Outlets
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var progressBar: UIProgressView!
    
    // Variables
    var nameOfRestaurant = ""
    var url: URL!
    var timeBool: Bool!
    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.delegate = self
        
        var name = ""
        switch restaurantChoice {
        // East campus
        case "1899 Dining Hall":
            name = "1899"
        case "Cornerstone Coffeehouse":
            name = "cornerstone"
        case "Cougar's Den Café":
            name = "den"
        case "Cougar Walk Café":
            name = "cafe"
        case "Mexicali Grill":
            name = "mexicali"
        case "Paws 'N Go Convenience":
            name = "pawsngo"
            
        // West campus
        case "The Grill at Heritage":
            name = "grill"
        case "Hillside Grounds at Heritage":
            name = "hillside"
        case "The Market at Heritage":
            name = "market"
        case "Sam's Subs":
            name = "sams"
        case "Umai Sushi":
            name = "umai"
        default:
            name = "error"
        }
        
        DB_BASE.child("venue").child(name).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            var firebaseViews = value?["menu"] as? Int ?? 0
            firebaseViews += 1
            DB_BASE.child("venue").child(name).child("menu").setValue(firebaseViews)
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = "\(restaurantChoice) Menu"
        progressBar.progress = 0.0
        
        setRestaurantName()
        loadMenuPage()
    }
    
    // Load web page
    func loadMenuPage() {
        if nameOfRestaurant == "pawsngo" {
            url = URL(string: "https://www.apu.edu/diningservices/\(nameOfRestaurant)")!
        } else {
            url = URL(string: "https://www.apu.edu/diningservices/menus/\(nameOfRestaurant)")!
        }
        webView.loadRequest(URLRequest(url: url))
    }
    
    // Names for APU Website URL
    func setRestaurantName() {
        switch restaurantChoice {
            
        // East campus
        case "1899 Dining Hall":
            nameOfRestaurant = "dininghall"
        case "Cornerstone Coffeehouse":
            nameOfRestaurant = "cornerstone"
        case "Cougar's Den Café":
            nameOfRestaurant = "cougarsden"
        case "Cougar Walk Café":
            nameOfRestaurant = "cougar-walk"
        case "Mexicali Grill":
            nameOfRestaurant = "mexicali"
        case "Paws 'N Go Convenience":
            nameOfRestaurant = "pawsngo"
            
        // West campus
        case "The Grill at Heritage":
            nameOfRestaurant = "grill"
        case "Hillside Grounds at Heritage":
            nameOfRestaurant = "hillside"
        case "The Market at Heritage":
            nameOfRestaurant = "market"
        case "Sam's Subs":
            nameOfRestaurant = "samssubs"
        case "Umai Sushi":
            nameOfRestaurant = "umaisushi"
        default:
            nameOfRestaurant = "cornerstone"
        }
    }
    
    // Load progress bar
    func webViewDidStartLoad(_ webView: UIWebView) {
        timeBool = false
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(InformationVC.timerCallBack), userInfo: nil, repeats: true)
    }
    func webViewDidFinishLoad(_ webView: UIWebView) {
        timeBool = false
        progressBar.progress = 1.0
    }
    
    // Prevent web view from navigating away from APU dining services web pages.
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        if String(describing: request.url).range(of: "www.apu.edu/diningservices/") != nil {
            return true
        } else {
            presentAlertToUser()
            return false
        }
    }
    
    // Alert user that navigation away from Dining Services is denied
    func presentAlertToUser() {
        let alert = UIAlertController(title: "Navigation Denied", message: "Access to external web pages is not allowed.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func timerCallBack() {
        if timeBool != nil {
            if progressBar.progress >= 1 {
                progressBar.isHidden = true
                timer.invalidate()
            } else {
                if progressBar.progress < 0.5 {
                    progressBar.progress += 0.005
                } else {
                    progressBar.progress += (1-progressBar.progress)/50
                }
            }
        } else {
            progressBar.progress += 0.05
            if progressBar.progress >= 0.95 {
                progressBar.progress = 0.95
            }
        }
    }
}
