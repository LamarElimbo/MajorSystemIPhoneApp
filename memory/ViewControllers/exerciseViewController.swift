//
//  exerciseViewController.swift
//  memory
//
//  Created by Preferred Customer on 2016-02-10.
//  Copyright © 2016 Lawinjo. All rights reserved.
//

import UIKit
import GameplayKit
import WebKit

class exerciseViewController: UIViewController, UITextFieldDelegate, WKNavigationDelegate {

    var allWords = [String]()
    var input: String?
    
    @IBOutlet weak var exerciseSwitch: UISegmentedControl!
    
    @IBOutlet weak var displayView: UILabel!
    
    @IBOutlet weak var inputField: UITextField!
    
    @IBOutlet weak var resultDisplay: UIImageView!
    
    @IBOutlet weak var answerView: UIView!
    
    @IBOutlet weak var RefreshButton: UIButton!
    
    @IBOutlet weak var answerTextField: UILabel!
    
    var webView: UIWebView!
    
    var numString: String = ""
    var numStringExtra: String!
    
    var showAnswerButton: UIButton!
    
    @IBOutlet weak var instructionsView: UIView!
    @IBOutlet weak var instructionsLabel1: UILabel!
    @IBOutlet weak var instructionsLabel2: UILabel!
    
    @IBAction func inputAction(sender: AnyObject) {
        input = self.inputField.text
        
        if exerciseSwitch.selectedSegmentIndex == 1 {
            convertSounds()
        }
            
        gradeInput()
        numString = ""
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        displayView.layer.borderColor = UIColor.blackColor().CGColor
        displayView.layer.borderWidth = 4
        displayView.layer.cornerRadius = 5
        
        inputField.layer.borderColor = UIColor.blackColor().CGColor
        inputField.layer.borderWidth = 4
        inputField.layer.cornerRadius = 5
        
        resultDisplay.layer.borderColor = UIColor.blackColor().CGColor
        resultDisplay.layer.borderWidth = 4
        resultDisplay.layer.cornerRadius = 5
        
        answerView.layer.borderColor = UIColor.blackColor().CGColor
        answerView.layer.borderWidth = 4
        answerView.layer.cornerRadius = 5
        
        RefreshButton.layer.borderColor = UIColor.blackColor().CGColor
        RefreshButton.layer.borderWidth = 4
        RefreshButton.layer.cornerRadius = 5
        
        showAnswerButton = UIButton(type: .System)
        showAnswerButton.bounds = CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, 30)
        showAnswerButton.center = CGPoint(x: UIScreen.mainScreen().bounds.size.width/2.1, y: 15)
        showAnswerButton.addTarget(self, action: Selector("showAnswerButton:"), forControlEvents: UIControlEvents.TouchUpInside)
        showAnswerButton.setTitle("Show Correct Answer", forState: UIControlState.Normal)
        showAnswerButton.titleLabel!.font = UIFont(name: "System", size: 26)
        answerView.addSubview(showAnswerButton)
        
        instructionsLabel2.hidden = true
        
        if exerciseSwitch.selectedSegmentIndex == 0 {
            if let wordListPath = NSBundle.mainBundle().pathForResource("start", ofType: "txt") {
                if let wordList = try? String(contentsOfFile: wordListPath, usedEncoding: nil) {
                    allWords = wordList.componentsSeparatedByString("\n")
                } else {
                    allWords = ["abnormal"]
                }
            }
            newWord()
            inputField.placeholder = "Enter Number"
            RefreshButton.setTitle("New Word", forState: UIControlState.Normal)
            RefreshButton.titleLabel!.font = UIFont(name: "System", size: 26)
        }
    }
    
    @IBAction func homeButon(sender: AnyObject) {
        
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("homeView") as! ViewController
        self.presentViewController(vc, animated: true, completion: nil)
    
    }

    @IBAction func exerciseSwitchAction(sender: AnyObject) {
        
        // word > number
        if sender.selectedSegmentIndex == 0 {
            if let wordListPath = NSBundle.mainBundle().pathForResource("start", ofType: "txt") {
                if let wordList = try? String(contentsOfFile: wordListPath, usedEncoding: nil) {
                    allWords = wordList.componentsSeparatedByString("\n")
                } else {
                    allWords = ["abnormal"]
                }
            }
            newWord()
            inputField.text = ""
            inputField.placeholder = "Enter Number"
            clearResult()
            showAnswerButton.setTitle("Show Correct Answer", forState: UIControlState.Normal)
            webView.hidden = true
            RefreshButton.setTitle("New Word", forState: UIControlState.Normal)
            RefreshButton.titleLabel!.font = UIFont(name: "System", size: 26)
            
        } else {
            // number > word
            inputField.text  = ""
            inputField.placeholder = "Enter Word/Words"
            answerTextField.text = ""
            newNumber()
            clearResult()
            webView.hidden = true
            showAnswerButton.setTitle("Show Correct Answer", forState: UIControlState.Normal)
            showAnswerButton.titleLabel!.font = UIFont(name: "System", size: 26)
            RefreshButton.setTitle("New Number", forState: UIControlState.Normal)
            RefreshButton.titleLabel!.font = UIFont(name: "System", size: 26)
        }
    }
    
    @IBAction func searchButton(sender: AnyObject) {
        
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("searchView") as! searchViewController
        self.presentViewController(vc, animated: true, completion: nil)
        
    }
    
    @IBAction func refreshAction(sender: AnyObject) {
        
        if exerciseSwitch.selectedSegmentIndex == 0 {
            newWord()
        } else {
            webView.removeFromSuperview()
            newNumber()
        }
        clearInput()
        clearResult()
    }
    
    func newWord() {
        // present new word to display
        showAnswerButton.hidden = false
        instructionsView.hidden = false
        instructionsLabel1.hidden = false
        instructionsLabel2.hidden = true
        numString = ""
        allWords = GKRandomSource.sharedRandom().arrayByShufflingObjectsInArray(allWords) as! [String]
        displayView.text = allWords[0]
        answerTextField.text = ""
        convertSounds()
    }

    func newNumber() {
        // present new number to display
        showAnswerButton.hidden = false
        instructionsView.hidden = false
        instructionsLabel1.hidden = true
        instructionsLabel2.hidden = false
        numString = ""
        let randomNum = Int(arc4random_uniform(1000))
        displayView.text = String(randomNum)
        activateWebView()
        webView.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func convertSounds() {
        // does the input satisfy the display
        
        var i: Int
        var characterConversion: [Character]

        if exerciseSwitch.selectedSegmentIndex == 0 {
            characterConversion = [Character](displayView.text!.characters)
        } else {
            characterConversion = [Character](inputField.text!.characters)
        }
        
        for i = 0; i < characterConversion.count; i++ {
            
            // b
            if characterConversion[i] == "b" {
                // b as in shabby
                if i <= characterConversion.count - 2 && characterConversion[i + 1] == "b" {
                    numString += ""
                }
                    // b as in numb
                else if i >= 1 && characterConversion[i - 1] == "m" {
                    numString += ""
                }
                    // b as in ball
                else {
                    numString += "9"
                }
            }
                
                // c
            else if characterConversion[i] == "c" {
                // c as in rock
                if i <= characterConversion.count - 2 && characterConversion[i + 1] == "k" {
                    numString += ""
                }
                    // c as in christmas
                else if i <= characterConversion.count - 3 && characterConversion[i + 1] == "h" && characterConversion[i + 2] == "r" {
                    numString += "7"
                }
                    // ch as in chemisry
                else if i <= characterConversion.count - 4 && characterConversion[i + 1] == "h" && characterConversion[i + 2] == "e" && characterConversion[i + 3] == "m" {
                    numString += "7"
                }
                    // c as in catch
                else if i <= characterConversion.count - 2 && i >= 1 && characterConversion[i + 1] == "h" && characterConversion[i - 1] == "t" {
                    numString += ""
                }
                    // c as in school
                else if i <= characterConversion.count - 2 && i >= 1 && characterConversion[i + 1] == "h" && characterConversion[i - 1] == "s" {
                    numString += "7"
                }
                    // ch as in cheese
                else if i <= characterConversion.count - 2 && characterConversion[i + 1] == "h" {
                    numString += "6"
                }
                    // c as in accent
                else if i <= characterConversion.count - 2 && characterConversion[i + 1] == "c" {
                    numString += ""
                }
                    // c as in icy
                else if i <= characterConversion.count - 2 && characterConversion[i + 1] == "y" {
                    numString += "0"
                }
                    // c as in social
                else if i <= characterConversion.count - 3 && characterConversion[i + 1] == "i" && characterConversion[i + 2] == "a" {
                    numString += "6"
                }
                    // c as in cisgender
                else if i <= characterConversion.count - 2 && characterConversion[i + 1] == "i" {
                    numString += "0"
                }
                    // c as in science
                else if i >= 1 && characterConversion[i - 1] == "s" && characterConversion[i + 1] == "i" {
                    numString += ""
                }
                    // c as in cent
                else if i <= characterConversion.count - 2 && characterConversion[i + 1] == "e" {
                    numString += "0"
                }
                    // c as in auspicious
                else if i <= characterConversion.count - 3 && characterConversion[i + 1] == "i" && characterConversion[i + 2] == "o" {
                    numString += "6"
                }
                    // c as in act
                else {
                    numString += "7"
                }
            }
                
                // d
            else if characterConversion[i] == "d" {
                // d as in add
                if i <= characterConversion.count - 2 && characterConversion[i + 1] == "d" {
                    numString += ""
                }
                    // dg as in dodge
                else if i <= characterConversion.count - 2 && characterConversion[i + 1] == "g" {
                    numString += "6"
                }
                    // d as in dog
                else {
                    numString += "1"
                }
            }
                
                // f
            else if characterConversion[i] == "f" {
                // f as in stuffy
                if i <= characterConversion.count - 2 && characterConversion[i + 1] == "f" {
                    numString += ""
                }
                    // f as in fun
                else {
                    numString += "8"
                }
            }
                
                // g
            else if characterConversion[i] == "g" {
                // g as in exaggerate
                if i <= characterConversion.count - 3 && characterConversion[i + 1] == "g" && characterConversion[i + 2] == "e" && characterConversion[i + 3] == "r" {
                    numString += "6"
                }
                    // g as in soggy
                else if i <= characterConversion.count - 2 && characterConversion[i + 1] == "g" {
                    numString += ""
                }
                    // gh as in though
                else if i >= 2 && characterConversion[i - 2] == "o" && characterConversion[i - 1] == "u" {
                    numString += ""
                }
                    // gh as in eight
                else if i >= 2 && characterConversion[i - 1] == "i" && characterConversion[i + 1] == "h" {
                    numString += ""
                }
                    // gh as in laugh
                else if i >= 2 && characterConversion[i - 2] == "a" && characterConversion[i - 1] == "u" {
                    numString += "8"
                }
                    // g as in sing
                else if i >= 2 && characterConversion[i - 1] == "n" && characterConversion[i - 2] == "i" {
                    numString += ""
                }
                    // g as in gnat
                else if i <= characterConversion.count - 2 && characterConversion[i + 1] == "n" {
                    numString += ""
                }
                    // g as in age
                else if i >= 1 && i <= characterConversion.count - 2 && characterConversion[i - 1] == "a" && characterConversion[i + 1] == "e" {
                    numString += "6"
                }
                    // g as in edge
                else if i >= 1 && characterConversion[i - 1] == "d" {
                    numString += ""
                }
                    // g as in grape
                else {
                    numString += "7"
                }
            }
            
            // j as in jelly
            if characterConversion[i] == "j" {
                numString += "6"
            }
                
                // k
            else if characterConversion[i] == "k" {
                // k as in knit
                if i == 0 && characterConversion[i + 1] == "n" {
                    numString += ""
                }
                    // k as in kittens
                else {
                    numString += "7"
                }
            }
                
                // l
            else if characterConversion[i] == "l" {
                // l as in yolk
                if i <= characterConversion.count - 2 && characterConversion[i + 1] == "k" {
                    numString += ""
                }
                    // l as in fellow
                else if i <= characterConversion.count - 2 && characterConversion[i + 1] == "l" {
                    numString += ""
                }
                    // l as in calf
                else if i <= characterConversion.count - 2 && i >= 1 && characterConversion[i - 1] == "a" && characterConversion[i + 1] == "f" {
                    numString += ""
                }
                    // l as in palm
                else if i <= characterConversion.count - 2 && characterConversion[i + 1] == "m" {
                    numString += ""
                }
                    // l as in clown
                else {
                    numString += "5"
                }
            }
                
                // m
            else if characterConversion[i] == "m" {
                // m as in hammer
                if i <= characterConversion.count - 2 && characterConversion[i + 1] == "m" {
                    numString += ""
                }
                    // m as in ham
                else {
                    numString += "3"
                }
            }
                
                // n
            else if characterConversion[i] == "n" {
                // n as in sunny
                if i <= characterConversion.count - 2 && characterConversion[i + 1] == "n" {
                    numString += ""
                }
                    // n as in autumn
                else if i >= 1 && characterConversion[i - 1] == "m" {
                    numString += ""
                }
                    // n as in nest
                else {
                    numString += "2"
                }
            }
                
                // p
            else if characterConversion[i] == "p" {
                // p as in happy
                if i <= characterConversion.count - 2 && characterConversion[i + 1] == "p" {
                    numString += ""
                }
                    // p as in pneumonia
                else if i <= characterConversion.count - 2 && characterConversion[i + 1] == "n" {
                    numString += ""
                }
                    // p as in phone
                else if i <= characterConversion.count - 2 && characterConversion[i + 1] == "h" {
                    numString += "8"
                }
                    // p as in psychology
                else if i <= characterConversion.count - 3 && characterConversion[i + 1] == "s" && characterConversion[i + 2] == "y" {
                    numString += ""
                }
                    // p as in pig
                else {
                    numString += "9"
                }
            }
                
                // q as in quick
            else if characterConversion[i] == "q" {
                numString += "7"
            }
                
                // r
            else if characterConversion[i] == "r" {
                // r as in hurry
                if i <= characterConversion.count - 2 && characterConversion[i + 1] == "r" {
                    numString += ""
                }
                    // r as in robot
                else {
                    numString += "4"
                }
            }
                
                // s
            else if characterConversion[i] == "s" {
                // s as in less
                if i <= characterConversion.count - 2 && characterConversion[i + 1] == "s" {
                    numString += ""
                }
                    // sh as in shell
                else if i <= characterConversion.count - 2 && characterConversion[i + 1] == "h" {
                    numString += "6"
                }
                    // sh as in schmooze
                else if i <= characterConversion.count - 3 && characterConversion[i + 1] == "c" && characterConversion[i + 2] == "h" {
                    numString += "6"
                }
                    // s as in horse
                else {
                    numString += "0"
                }
            }
                
                // t as in tape
            else if characterConversion[i] == "t" {
                if i <= characterConversion.count - 2 && characterConversion[i + 1] == "t" {
                    numString += ""
                }
                    // t as in catch
                else if i <= characterConversion.count - 2 && characterConversion[i + 1] == "c" {
                    numString += "6"
                }
                    // t as in caption
                else if i <= characterConversion.count - 3 && characterConversion[i + 1] == "i" && characterConversion[i + 2] == "o" {
                    numString += "6"
                }
                    // th as in throw
                else {
                    numString += "1"
                }
            }
                
                // v as in van
            else if characterConversion[i] == "v" {
                numString += "8"
            }
                
                // x
            else if characterConversion[i] == "x" {
                // x as in foxy
                if i >= 1 && characterConversion[i - 1] == "a" || characterConversion[i - 1] == "e" || characterConversion[i - 1] == "i" || characterConversion[i - 1] == "o" || characterConversion[i - 1] == "u" {
                    numString += "70"
                }
                    // x as in xylophone
                else {
                    numString += "0"
                }
            }
                
                // z
            else if characterConversion[i] == "z" {
                // z as in buzz
                if i <= characterConversion.count - 2 && characterConversion[i + 1] == "z" {
                    numString += ""
                }
                    // z as in zebra
                else {
                    numString += "0"
                }
            }
                
                // vowels
            else if characterConversion[i] == "a" || characterConversion[i] == "e" || characterConversion[i] == "i" || characterConversion[i] == "o" || characterConversion[i] == "u" || characterConversion[i] == "h" || characterConversion[i] == "w" || characterConversion[i] == "y" || characterConversion[i] == "x" {
            }
                
                // invalid input
            else {
                // let ac = UIAlertController(title: "Try Again", message: "Invalid Input", preferredStyle: .Alert)
                // self.presentViewController(ac, animated: true, completion: nil)
            }
            
        }
        numStringExtra = numString
        print("numStringExtra value after convertSounds: \(numStringExtra)")
        print("numString value after convertSounds: \(numString)")
    }
    
    func gradeInput() {
    
        if exerciseSwitch.selectedSegmentIndex == 0 {
            
            if numStringExtra == inputField.text {
                print("Great Job!")
                // set correct image view for resultDisplay
                resultDisplay.image = UIImage(named: "RightAnswer")
            } else {
                print("\(displayView.text) | user: \(inputField.text!) | answer: \(numStringExtra)")
                // set incorrect image view for resultDisplay
                resultDisplay.image = UIImage(named: "WrongAnswer")
            }
        } else {

            // check letter to number correspondence
            if numString == displayView.text {
                // check if word is real
                if wordIsReal(input!) {
                    print("Great Job!")
                    // set correct image view for resultDisplay
                    resultDisplay.image = UIImage(named: "RightAnswer")
                } else {
                    answerTextField.text = "Invalid Word"
                    resultDisplay.image = UIImage(named: "WrongAnswer")
                }
            } else {
                print("\(displayView.text) | user: \(inputField.text!) | answer: \(numString)")
                // set incorrect image view for resultDisplay
                resultDisplay.image = UIImage(named: "WrongAnswer")
            }
            
        }
    }
    
    func wordIsReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSMakeRange(0, word.characters.count)
        let misspelledRange = checker.rangeOfMisspelledWordInString(word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    func clearInput() {
        inputField.text = ""
    }
    
    func clearResult() {
        resultDisplay.image = nil
    }
    
    func showAnswerButton(sender: UIButton!) {
        
        showAnswerButton.hidden = true
        
        if exerciseSwitch.selectedSegmentIndex == 0 {
            instructionsView.hidden = true

            answerTextField.text = ""
            activateTextField()
            print("It worked!")
        } else {
            webView.hidden = false
        }
    }
    
    func activateTextField() {
        answerTextField.text = "\(numStringExtra)"
    }
    

    
    func activateWebView() {
        webView = UIWebView(frame: CGRectMake(0, 0, answerView.bounds.size.width, answerView.bounds.size.height))
        print("displayView.text = \(displayView.text!)")
        var url = "http://www.phoneticmnemonic.com/lookup.php?num=\(displayView.text!)"
        print("url = \(url)")
        webView.loadRequest(NSURLRequest(URL: NSURL(string: url)!))
        answerView.addSubview(webView)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
}
