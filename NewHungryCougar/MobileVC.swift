
import UIKit
import WebKit

class MobileVC: UIViewController, WKNavigationDelegate, WKUIDelegate, UIWebViewDelegate {
    
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
        
        let url = URL(string: "https://mobile.apu.edu/app/apu/welcome/onecard")
        webView.loadRequest(URLRequest(url: url!))
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
        webView.scrollView.contentOffset = CGPoint(x: 0, y: 0)
        let requestString = String(describing: request)
        if navigationType == .linkClicked {
            if requestString.contains("mobile.apu.edu/") {
                // navigate normally
            } else {
                presentAlertToUser()
                return false
            }
        }
        return true
    }
    
    // Alert user that navigation away from Dining Services is denied
    func presentAlertToUser() {
        let alert = UIAlertController(title: "Navigation Denied", message: "Access to other web pages is not allowed.", preferredStyle: UIAlertControllerStyle.alert)
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
