//
//  searchViewController.swift
//  memory
//
//  Created by Preferred Customer on 2016-02-10.
//  Copyright © 2016 Lawinjo. All rights reserved.
//

import UIKit
import WebKit

class searchViewController: UIViewController, WKNavigationDelegate, UISearchBarDelegate {
    
   var webView: WKWebView!
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
        
        webView.resignFirstResponder()
        let url:NSURL = NSURL(string: "http://www.phoneticmnemonic.com")!
        let request = NSURLRequest(URL: url)
        webView.loadRequest(request)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func homeButton(sender: AnyObject) {
        
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("homeView") as! ViewController
        self.presentViewController(vc, animated: true, completion: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func webViewDidStartLoad(webView: UIWebView){
    }
    
    func webViewDidFinishLoad(webView: UIWebView){
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
