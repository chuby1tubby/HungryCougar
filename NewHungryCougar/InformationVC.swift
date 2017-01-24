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
    func setRestaurantName() {
        switch restaurantChoice {
        case "Dining Hall":
            nameOfRestaurant = "dininghall"
        case "Coffeehouse":
            nameOfRestaurant = "cornerstone"
        case "The Den":
            nameOfRestaurant = "cougarsden"
        case "Cougar BBQ":
            nameOfRestaurant = "cougar-walk"
        case "Cali Grill":
            nameOfRestaurant = "mexicali"
        case "Pause 'n Go":
            nameOfRestaurant = "pawsngo"
        case "Fusion Grill":
            nameOfRestaurant = "grill"
        case "Fresh Grounds":
            nameOfRestaurant = "hillside"
        case "West Market":
            nameOfRestaurant = "market"
        case "Tam's Subs":
            nameOfRestaurant = "samssubs"
        case "Tasti Sushi":
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
