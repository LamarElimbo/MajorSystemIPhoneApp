//
//  testViewController.swift
//  memory
//
//  Created by Preferred Customer on 2016-02-11.
//  Copyright © 2016 Lawinjo. All rights reserved.
//

import UIKit

class testViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeView: UIViewController = UIViewController(nibName: "homeView", bundle: nil)
        
        let testView: testViewController = testViewController(nibName: "testViewController", bundle: nil)
        
        self.addChildViewController(homeView)
        self.scrollView.addSubview(homeView.view)
        homeView.didMoveToParentViewController(self)

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
