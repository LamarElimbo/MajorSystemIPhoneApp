//
//  ViewController.swift
//  memory
//
//  Created by Preferred Customer on 2016-02-09.
//  Copyright © 2016 Lawinjo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var mainTitle: UILabel!
    
    @IBOutlet weak var aboutButton: UIButton!
    
    @IBOutlet weak var tutorialButton: UIButton!
    
    @IBOutlet weak var tipsButton: UIButton!
    
    @IBOutlet weak var searchButton: UIButton!
    
    @IBOutlet weak var exerciseButton: UIButton!
    
    @IBAction func aboutAction(sender: AnyObject) {

        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc: UINavigationController = storyboard.instantiateViewControllerWithIdentifier("aboutViewController") as! UINavigationController
        
        self.presentViewController(vc, animated: true, completion: nil)

    }
    
    @IBAction func tutorialAction(sender: AnyObject) {
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc: UINavigationController = storyboard.instantiateViewControllerWithIdentifier("tutorialPageViewController") as! UINavigationController
        
        self.presentViewController(vc, animated: true, completion: nil)
        
    }
    
    @IBAction func searchAction(sender: AnyObject) {
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc: UINavigationController = storyboard.instantiateViewControllerWithIdentifier("searchViewController") as! UINavigationController
        
        self.presentViewController(vc, animated: true, completion: nil)
        
    }
    

    @IBAction func tipsAction(sender: AnyObject) {
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc: UINavigationController = storyboard.instantiateViewControllerWithIdentifier("tipsViewController") as! UINavigationController
        
        self.presentViewController(vc, animated: true, completion: nil)
        
    }
    
    @IBAction func exerciseViewController(sender: AnyObject) {
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc: UINavigationController = storyboard.instantiateViewControllerWithIdentifier("exerciseViewController") as!
        UINavigationController
        
        self.presentViewController(vc, animated: true, completion: nil)
        
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainTitle.layer.borderColor = UIColor.blackColor().CGColor
        mainTitle.layer.borderWidth = 6
        mainTitle.layer.cornerRadius = 3
        
        aboutButton.layer.borderColor = UIColor.blackColor().CGColor
        aboutButton.layer.borderWidth = 4
        aboutButton.layer.cornerRadius = 5
        
        tutorialButton.layer.borderColor = UIColor.blackColor().CGColor
        tutorialButton.layer.borderWidth = 4
        tutorialButton.layer.cornerRadius = 5
        
        tipsButton.layer.borderColor = UIColor.blackColor().CGColor
        tipsButton.layer.borderWidth = 4
        tipsButton.layer.cornerRadius = 5
        
        searchButton.layer.borderColor = UIColor.blackColor().CGColor
        searchButton.layer.borderWidth = 4
        searchButton.layer.cornerRadius = 5

        exerciseButton.layer.borderColor = UIColor.blackColor().CGColor
        exerciseButton.layer.borderWidth = 6
        exerciseButton.layer.cornerRadius = 9

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

