//
//  APUHomeVC.swift
//  Hungry Cougar 2.0
//
//  Created by Kyle Nakamura on 8/29/16.
//  Copyright © 2016 Kyle Nakamura. All rights reserved.
//

import UIKit
import WebKit

var usernameStr: String? = ""
var passwordStr: String? = ""
var shouldRepeat: Bool = true
var didReceievePointsVal: Bool = false
var finalDiningPointsDouble: Double = 0.0
var finalCougarBucksDouble: Double = 0.0
var myFinalDouble: Double = 0.0

class APUHomeVC: UIViewController, WKNavigationDelegate, WKUIDelegate, UIWebViewDelegate {
    
    // Outlets
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var progressBar: UIProgressView!
    
    // Variables
    var url: URL!
    var timeBool: Bool!
    var timer: Timer!
    var timer2: Timer!
    var regexConverter: String = ""
    
    // Main functions
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        progressBar.progress = 0.0
        shouldRepeat = true
        didReceievePointsVal = false
        loadHomePage()
    }
    
    // Load web view
    func loadHomePage() {
        url = URL(string: "https://den.apu.edu/cas/login?service=https%3A//home.apu.edu/psp/PRODPRT/EMPLOYEE/HRMS/h/%3Ftab%3DDEFAULT")
        let request = URLRequest(url: url, cachePolicy: NSURLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0)
        webView.loadRequest(request)
    }
    
    // Web view finished loading
    func webViewDidFinishLoad(_ webView: UIWebView) {
        // Hide the progress bar
        timeBool = false
        
        loginUser(username: usernameStr!, password: passwordStr!)
        
        // Magical pause function
        // *should not repeat, but it does anyway*
        let when = DispatchTime.now() + 1
        DispatchQueue.main.asyncAfter(deadline: when){
            if shouldRepeat == true {
                self.getHTML()
            }
        }
        
        if #available(iOS 9.0, *) {
            let websiteDataTypes = NSSet(array: [WKWebsiteDataTypeDiskCache, WKWebsiteDataTypeMemoryCache])
            let date = NSDate(timeIntervalSince1970: 0)
            WKWebsiteDataStore.default().removeData(ofTypes: websiteDataTypes as! Set<String>, modifiedSince: date as Date, completionHandler:{ })
        } else {
            var libraryPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, false).first!
            libraryPath += "/Cookies"
            
            do {
                try FileManager.default.removeItem(atPath: libraryPath)
            } catch {
                print("error")
            }
            URLCache.shared.removeAllCachedResponses()
        }
    }
    
    func loginUser(username: String?, password: String?) {
        // Run JavaScript script to automatically login the user
        _ = webView.stringByEvaluatingJavaScript(from: "var script = document.createElement('script');" +
            "script.type = 'text/javascript';" +
            "script.text = \"function insertLoginDetails() { " +
            "var userNameField = document.getElementById('username');" +
            "var passwordField = document.getElementById('password');" +
            "var loginButton = document.getElementsByName('submit')[0];" +
            "userNameField.value='\(username!)';" +
            "passwordField.value='\(password!)';" +
            "loginButton.click();" +
            "}\";" +
            "document.getElementsByTagName('head')[0].appendChild(script);")!
        webView.stringByEvaluatingJavaScript(from: "insertLoginDetails();")!
    }
    
    // Load progress bar
    func webViewDidStartLoad(_ webView: UIWebView) {
        timeBool = false
        timer2 = Timer.scheduledTimer(timeInterval: 0.015, target: self, selector: #selector(APUHomeVC.progressUpdate), userInfo: nil, repeats: true)
    }
    
    // Prevent web view from navigating away from APU web pages.
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        // If website URL contains "den.apu.edu"
        if String(describing: request.url).range(of: "apu.edu") != nil {
            return true
        }else {
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
    
    // Estimate progress for progress bar
    func progressUpdate() {
        if timeBool != nil {
            if progressBar.progress >= 1 {
                progressBar.isHidden = true
                progressBar.progress = 1
                timer2.invalidate()
            } else {
                progressBar.progress += 0.01
            }
        } else {
            progressBar.progress += 0.05
            if progressBar.progress >= 0.95 {
                progressBar.progress = 0.95
            }
        }
    }
    
    func getHTML(){
        //Here is the line of code you need to run after it is logged in.
        let html = webView.stringByEvaluatingJavaScript(from: "document.documentElement.innerHTML")
        let defaults = UserDefaults.standard
        
        // Dining Points
        var diningPointsString: String!
        var diningPointsHTML = webView.stringByEvaluatingJavaScript(from: "document.getElementById('ADMN_APU_ONE_CARD_PAGELET_HMPG_Data').getElementsByTagName('td')[1].innerHTML")
        if diningPointsHTML != "" {
            diningPointsString = diningPointsHTML
            finalDiningPointsDouble = Double(diningPointsString)!
            defaults.set(diningPointsString, forKey: "userDiningPointsDefaults")
            print("KYLE: FINAL DOUBLE VALUE = \(finalDiningPointsDouble)")
            didReceievePointsVal = true
        }
        
        // Cougar bucks
        var cougarBucksString: String!
        var cougarBucksHTML = webView.stringByEvaluatingJavaScript(from: "document.getElementById('ADMN_APU_ONE_CARD_PAGELET_HMPG_Data').getElementsByTagName('td')[0].innerHTML")
        if cougarBucksHTML != "" {
            cougarBucksString = cougarBucksHTML
            if cougarBucksString.contains("N/A") {
                defaults.set("0.00", forKey: "userCougarBucksDefaults")
            } else {
                defaults.set(cougarBucksString, forKey: "userCougarBucksDefaults")
            }
            
            // Scrub the value for conversion
            var temp = ""
            for char in cougarBucksString.characters {
                if char != "$" {
                    temp.append(char)
                }
            }
            cougarBucksString = temp
            finalCougarBucksDouble = Double(cougarBucksString)!
            print("KYLE: FINAL DOUBLE VALUE = \(finalCougarBucksDouble)")
            didReceievePointsVal = true
        }
        
        // Pop the view controller
        if didReceievePointsVal {
            shouldRepeat = false
            if let navController = self.navigationController {
                navController.popViewController(animated: true)
            }
        }
    }
}

extension String {
    func index(of string: String) -> String.Index? {
        return range(of: string)?.lowerBound
    }
}

