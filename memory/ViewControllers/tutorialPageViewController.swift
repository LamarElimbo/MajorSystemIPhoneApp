//
//  tutorialPageViewController.swift
//  memory
//
//  Created by Preferred Customer on 2016-02-17.
//  Copyright © 2016 Lawinjo. All rights reserved.
//

import UIKit


class tutorialPageViewController: UIPageViewController, UIPageViewControllerDataSource {
        
    func getTutPageOne() -> tut1ViewController {
        return storyboard!.instantiateViewControllerWithIdentifier("tut1Page") as! tut1ViewController
    }
    
    func getTutPageTwo() -> tut2ViewController {
        return storyboard!.instantiateViewControllerWithIdentifier("tut2Page") as! tut2ViewController
    }
    
    func getTutPageThree() -> tut3ViewController {
        return storyboard!.instantiateViewControllerWithIdentifier("tut3Page") as! tut3ViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        
        setViewControllers([getTutPageOne()], direction: .Forward, animated: false, completion: nil)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        if viewController.isKindOfClass(tut3ViewController) {
            return getTutPageTwo()
        } else if viewController.isKindOfClass(tut2ViewController) {
            return getTutPageOne()
        } else {
            return nil
        }
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        if viewController.isKindOfClass(tut1ViewController) {
            return getTutPageTwo()
        } else if viewController.isKindOfClass(tut2ViewController) {
            return getTutPageThree()
        } else {
            return nil
        }
    }
    
    @IBAction func homeAction(sender: AnyObject) {
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("homeView") as! ViewController
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    
}