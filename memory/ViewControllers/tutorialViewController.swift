//
//  tutorialViewController.swift
//  memory
//
//  Created by Preferred Customer on 2016-05-09.
//  Copyright © 2016 Lawinjo. All rights reserved.
//

import UIKit

class tutorialViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

    @IBAction func homeAction(sender: AnyObject) {
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("homeView") as! ViewController
        self.presentViewController(vc, animated: true, completion: nil)
    }

}
