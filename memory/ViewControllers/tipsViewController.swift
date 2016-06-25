//
//  tipsViewController.swift
//  memory
//
//  Created by Preferred Customer on 2016-02-10.
//  Copyright © 2016 Lawinjo. All rights reserved.
//

import UIKit

class tipsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func homeAction(sender: AnyObject) {
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("homeView") as! ViewController
        self.presentViewController(vc, animated: true, completion: nil)
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
