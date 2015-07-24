//
//  KeyboardViewController.swift
//  CustomKeyboard
//
//  Created by Jin Seok Park on 2015. 7. 20..
//  Copyright (c) 2015년 Jin Seok Park. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {

    @IBOutlet var nextKeyboardButton: UIButton!
    var dotButton: UIButton!
    var dashButton: UIButton!
    var hideKeyboardButton: UIButton!
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
    
        // Add custom view sizing constraints here
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    
        addKeyboardButtons()
    }
    
    func addDot() {
        
        //initialize the button
        dotButton = UIButton.buttonWithType(.System) as! UIButton
        dotButton.setTitle("Photo", forState: .Normal)
        dotButton.sizeToFit()
        dotButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        //adding a callback
        dotButton.addTarget(self, action: "didTapDot", forControlEvents: .TouchUpInside)
        
        //make the font bigger
        dotButton.titleLabel!.font = UIFont.systemFontOfSize(32)
        
        //add rounded corners
        dotButton.backgroundColor = UIColor(white: 0.9, alpha: 1)
        dotButton.layer.cornerRadius = 5
        
        view.addSubview(dotButton)
        
        //makes the vertical centers equal
        var dotCenterYConstraint = NSLayoutConstraint(item: dotButton, attribute: .CenterY, relatedBy: .Equal, toItem: view, attribute: .CenterY, multiplier: 1.0, constant: 0)
        
        //set the button 50 points to the left (-) of the horizontal center
        var dotCenterXConstraint = NSLayoutConstraint(item: dotButton, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1.0, constant: -50)
        
        view.addConstraints([dotCenterXConstraint, dotCenterYConstraint])
    }
    
    
    func addDash() {
        
        //initialize the button
        dashButton = UIButton.buttonWithType(.System) as! UIButton
        dashButton.setTitle("Schedule", forState: .Normal)
        dashButton.sizeToFit()
        dashButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        //adding a callback
        dashButton.addTarget(self, action: "didTapDash", forControlEvents: .TouchUpInside)
        
        //make the font bigger
        dashButton.titleLabel!.font = UIFont.systemFontOfSize(32)
        
        //add rounded corners
        dashButton.backgroundColor = UIColor(white: 0.9, alpha: 1)
        dashButton.layer.cornerRadius = 5
        
        view.addSubview(dotButton)
        
        //makes the vertical centers equal
        var dotCenterYConstraint = NSLayoutConstraint(item: dashButton, attribute: .CenterY, relatedBy: .Equal, toItem: view, attribute: .CenterY, multiplier: 1.0, constant: 0)
        
        //set the button 50 points to the left (-) of the horizontal center
        var dotCenterXConstraint = NSLayoutConstraint(item: dashButton, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1.0, constant: 50)
        
        view.addConstraints([dotCenterXConstraint, dotCenterYConstraint])

    }
    
    
    func addHideKeyboardButton() {
        hideKeyboardButton = UIButton.buttonWithType(.System) as! UIButton
        
        hideKeyboardButton.setTitle("Hide Keyboard", forState: .Normal)
        hideKeyboardButton.sizeToFit()
        hideKeyboardButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        hideKeyboardButton.addTarget(self, action: "dismissKeyboard", forControlEvents: .TouchUpInside)
        
        view.addSubview(hideKeyboardButton)
        
        var rightSideConstraint = NSLayoutConstraint(item: hideKeyboardButton, attribute: .Right, relatedBy: .Equal, toItem: view, attribute: .Right, multiplier: 1.0, constant: -10.0)
        
        var bottomConstraint = NSLayoutConstraint(item: hideKeyboardButton, attribute: .Bottom, relatedBy: .Equal, toItem: view, attribute: .Bottom, multiplier: 1.0, constant: -10.0)
        
        view.addConstraints([rightSideConstraint, bottomConstraint])
    }

    
    
    func didTapDot() {
        var proxy = textDocumentProxy as! UITextDocumentProxy
        
        proxy.insertText(".")
    }

    func didTapDash() {
        var proxy = textDocumentProxy as! UITextDocumentProxy
        
        proxy.insertText("/")
    }
    
    func addKeyboardButtons() {
        addDot()
        addDash()
        addNextKeyboardButton()
        addHideKeyboardButton()
    }
    
    func addNextKeyboardButton() {
        
        // Perform custom UI setup here
        self.nextKeyboardButton = UIButton.buttonWithType(.System) as! UIButton
        
        self.nextKeyboardButton.setTitle(NSLocalizedString("Next Keyboard", comment: "Title for 'Next Keyboard' button"), forState: .Normal)
        self.nextKeyboardButton.sizeToFit()
        self.nextKeyboardButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        self.nextKeyboardButton.addTarget(self, action: "advanceToNextInputMode", forControlEvents: .TouchUpInside)
        
        self.view.addSubview(self.nextKeyboardButton)

        
        var nextKeyboardButtonLeftSideConstraint = NSLayoutConstraint(item: self.nextKeyboardButton, attribute: .Left, relatedBy: .Equal, toItem: self.view, attribute: .Left, multiplier: 1.0, constant: 0.0)
        var nextKeyboardButtonBottomConstraint = NSLayoutConstraint(item: self.nextKeyboardButton, attribute: .Bottom, relatedBy: .Equal, toItem: self.view, attribute: .Bottom, multiplier: 1.0, constant: 0.0)
        self.view.addConstraints([nextKeyboardButtonLeftSideConstraint, nextKeyboardButtonBottomConstraint])

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }

    override func textWillChange(textInput: UITextInput) {
        // The app is about to change the document's contents. Perform any preparation here.
    }

    override func textDidChange(textInput: UITextInput) {
        // The app has just changed the document's contents, the document context has been updated.
    
        var textColor: UIColor
        var proxy = self.textDocumentProxy as! UITextDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.Dark {
            textColor = UIColor.whiteColor()
        } else {
            textColor = UIColor.blackColor()
        }
        self.nextKeyboardButton.setTitleColor(textColor, forState: .Normal)
    }

}
