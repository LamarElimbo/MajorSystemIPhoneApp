//
//  tut3ViewController.swift
//  memory
//
//  Created by Preferred Customer on 2016-02-17.
//  Copyright © 2016 Lawinjo. All rights reserved.
//

import UIKit

class tut3ViewController: UIViewController {
        
    @IBOutlet weak var homeButtonDesign: UIButton!

    @IBAction func homeButton(sender: AnyObject) {
        
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("homeView") as! ViewController
        self.presentViewController(vc, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
