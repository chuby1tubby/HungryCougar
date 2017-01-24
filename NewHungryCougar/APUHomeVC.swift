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
    }
    
    func getHTML(){
        //Here is the line of code you need to run after it is logged in.
        let html = webView.stringByEvaluatingJavaScript(from: "document.documentElement.innerHTML")
        if let page = html {
            //calls the parse function
            parseHTML(html: page)
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
    
    // This is the function that you need to call with the string of HTML that you grab
    // Courtesy of David Bartholemew.
    var count = 0
    func parseHTML(html: String) {
        count += 1
        //Parses for the index Of specific location in the HTML
        let fontString = "font-weight: bold;\">"
        
        if let range = html.range(of: fontString) {
            let lo = html.index((range.lowerBound), offsetBy: 20)
            let hi = html.index((range.lowerBound), offsetBy: 27)
            let subRange = lo ..< hi
            
            // Access the string by the range.
            let substring = html[subRange]
            
            //Converts the number to a double
            let str = substring
            let numArray: [Character] = ["0","1","2","3","4","5","6","7","8","9","."]
            let symbolsArray: [Character] = ["$", ",",]
            var finalNumArray: [Character] = []
            
            for char in str.characters {
                if numArray.contains(char) {
                    finalNumArray.append(char)
                } else if symbolsArray.contains(char) {
                    // Do nothing
                } else {
                    break
                }
            }
            
            //Checks to see if it is N/A or a number then converts it to a double
            var newString: String = ""
            if str.contains("N/A") {
                myFinalDouble = 0.0
                shouldRepeat = false
                didReceievePointsVal = true
                
                // Store dining points in UserDefaults
                let defaults = UserDefaults.standard
                defaults.set("0.00", forKey: "userDiningPointsDefaults")
                
                if let navController = self.navigationController {
                    navController.popViewController(animated: true)
                }
            } else {
                for char in finalNumArray {
                    newString.append(char)
                }
                myFinalDouble = Double(newString)!
                shouldRepeat = false
                didReceievePointsVal = true
                
                // Update current dining points balance label
                let textNum = String(format: "%.2f", arguments: [myFinalDouble])
                
                // Store dining points in UserDefaults
                let defaults = UserDefaults.standard
                defaults.set(textNum, forKey: "userDiningPointsDefaults")
                
                if let navController = self.navigationController {
                    navController.popViewController(animated: true)
                }
            }
        }
    }
}

extension String {
    func index(of string: String) -> String.Index? {
        return range(of: string)?.lowerBound
    }
}

