//
//  ConversationViewController.swift
//  UniversiTeam
//
//  Created by Jin Seok Park on 4/19/15.
//  Copyright (c) 2015 Jin Seok Park. All rights reserved.
//

import UIKit

var otherNames = [String]()
var otherProfileName = ""
var groupName = ""

var messageArray = [String]()
var senderArray = [String]()


class ConversationViewController: UIViewController, UIScrollViewDelegate, UITextViewDelegate, UIPopoverPresentationControllerDelegate, UINavigationControllerDelegate
, UIImagePickerControllerDelegate {

    
    
    //popover vc
    var popoverContent: UIViewController!
    var popover: UIPopoverPresentationController!

    
    
    @IBOutlet var resultsScrollView: UIScrollView!
    @IBOutlet var frameMessageView: UIView!
    @IBOutlet var messageTextView: UITextView!
    @IBOutlet var lineLabel: UILabel!
    @IBOutlet var sendBtn: UIButton!
    @IBOutlet var addBtn: UIButton!

    
    var scrollViewOriginalY:CGFloat = 0
    var frameMessageOriginalY:CGFloat = 0
    var wholeViewOriginalY:CGFloat = 0
    

    
    var bubbleColor = UIColor(red: 30, green: 144, blue: 255, alpha: 1)
  
    


    let messageLabel = UITextView(frame: CGRectMake(5, 10, 200, 20))
//    let userLabel = UILabel(frame: CGRectMake(5, 10, 200, 20))
    
    
    var messageX:CGFloat = 37.0
    var messageY:CGFloat = 26.0
    var frameX:CGFloat = 32.0
    var frameY:CGFloat = 21.0
    var imgX:CGFloat = 3
    var imgY:CGFloat = 3

    var usersList = [String]()
    
    
    var myImg:UIImage? = UIImage()
    
    var resultsImageFiles = [PFFile]()
    var resultsImageFiles2 = [PFFile]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        let theWidth = view.frame.size.width
        let theHeight = view.frame.size.height
        
        self.frameMessageView.layer.zPosition = 40

        
        scrollViewOriginalY = self.resultsScrollView.frame.origin.y
        frameMessageOriginalY = theHeight - 50
        
        
        self.messageTextView.layer.zPosition = 30
        self.lineLabel.layer.zPosition = 20


        if selectedPlayersUsername.count > 2 {
            self.title = "Group \(selectedPlayersUsername.count)"
        } else {
            self.title = otherProfileName
        }
        
        self.lineLabel.font = UIFont(name: "Helvetica", size: 16)
        
        self.messageTextView.font = UIFont(name: "Helvetica", size: 16)
//        messageLabel.text = "Type a message..."
//        messageLabel.font = UIFont(name: "Helvetica", size: 19)
//        messageLabel.backgroundColor = UIColor.clearColor()
//        messageLabel.textColor = UIColor.lightGrayColor()
//        messageTextView.addSubview(messageLabel)
        
        //keyboard notification
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWasShown:", name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)

        
        let tapScrollViewGesture = UITapGestureRecognizer(target: self, action: "didTapScrollView")
        tapScrollViewGesture.numberOfTapsRequired = 1
        resultsScrollView.addGestureRecognizer(tapScrollViewGesture)
        
        let tapScrollViewGesture2 = UITapGestureRecognizer(target: self, action: "addBtn_click")
        tapScrollViewGesture2.numberOfTapsRequired = 1
        addBtn.addGestureRecognizer(tapScrollViewGesture2)
        
        
        

        //update when get message
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "getMessageFunc", name: "getMessage", object: nil)

    }
    //update when get message
    func getMessageFunc(){
        
        refreshResults()
    }

    
    func didTapScrollView() {
        
            self.view.endEditing(true)
    }
    
    
    
    
    
    
//    func textViewDidChange(textView: UITextView) {
//        
//        if !messageTextView.hasText() {
//            
//            self.messageLabel.hidden = false
//        }
//        else {
//            
//            self.messageLabel.hidden = true
//        }
//    }
//    
//    func textViewDidEndEditing(textView: UITextView) {
//        
//        if !messageTextView.hasText(){
//            self.messageLabel.hidden = false
//        }
//    }
    
    
    
    
    
    func keyboardWasShown(notification:NSNotification) {
        
        let dict:NSDictionary = notification.userInfo!
        let s:NSValue = dict.valueForKey(UIKeyboardFrameEndUserInfoKey) as! NSValue
        let rect:CGRect = s.CGRectValue()
        
        
        UIView.animateWithDuration(0.01, animations: {
            
            
            var bottomOffset:CGPoint = CGPointMake(0, 0)

            if self.messageY < self.resultsScrollView.frame.height - rect.height {
//                self.resultsScrollView.contentSize = CGSizeMake(theWidth, self.resultsScrollView.frame.height)
                
//                self.resultsScrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.resultsScrollView.frame.height - rect.height)
                
                
                self.frameMessageView.frame.origin = CGPointMake(0, self.view.frame.height - rect.height - self.frameMessageView.frame.height)

                
            } else {
                
                self.resultsScrollView.frame.origin.y = self.scrollViewOriginalY - rect.height
//                self.frameMessageView.frame.origin.y = self.frameMessageOriginalY - rect.height
                self.frameMessageView.frame.origin = CGPointMake(0, self.view.frame.height - rect.height - self.frameMessageView.frame.height)


                bottomOffset = CGPointMake(0, self.resultsScrollView.contentSize.height - self.resultsScrollView.bounds.size.height)
            }
            
//            var bottomOffset:CGPoint = CGPointMake(0, self.resultsScrollView.contentSize.height - self.resultsScrollView.bounds.size.height)
//            self.resultsScrollView.setContentOffset(bottomOffset, animated: false)

            
            }, completion: {
                (finished:Bool) in
                
                
        })
        
    }
    
    func keyboardWillHide(notification:NSNotification) {
        
        
        let dict:NSDictionary = notification.userInfo!
        let s:NSValue = dict.valueForKey(UIKeyboardFrameEndUserInfoKey) as! NSValue
        let rect:CGRect = s.CGRectValue()
        
        UIView.animateWithDuration(0.01, animations: {
            
            self.resultsScrollView.frame.origin.y = self.scrollViewOriginalY
            self.frameMessageView.frame.origin.y = self.frameMessageOriginalY
            
            var bottomOffset:CGPoint = CGPointMake(0, self.resultsScrollView.contentSize.height - self.resultsScrollView.bounds.size.height)
            self.resultsScrollView.setContentOffset(bottomOffset, animated: false)
            
            
            }, completion: {
                (finished:Bool) in
                
                
        })

        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        


        
        
        var query = PFQuery(className: "_User")
        query.whereKey("username", equalTo: userName)
        
        var objects = query.findObjects()
        
        self.resultsImageFiles.removeAll(keepCapacity: false)
        
        for object in objects! {
            
            self.resultsImageFiles.append(object["photo"] as! PFFile)
            self.resultsImageFiles[0].getDataInBackgroundWithBlock{
                (imageData:NSData?, error:NSError?) -> Void in
                
                if error == nil {
                    
                    self.myImg = UIImage(data: imageData!)
                    
                    
                    self.refreshResults()

                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
//    override func canPerformAction(action: Selector, withSender sender: AnyObject?) -> Bool {
//        if action==Selector("paste:") {
//            return false
//        }
//    }
    
    
    func refreshResults(){
        
        let theWidth = view.frame.size.width
        let theHeight = view.frame.size.height
        
        messageX = 37.0
        messageY = 26.0
        frameX = 32.0
        frameY = 21.0
        imgX = 3
        imgY = 3
        
        messageArray.removeAll(keepCapacity: false)
        senderArray.removeAll(keepCapacity: false)
        

        
        
        var messageTable = PFObject(className: "Messages")

        var query = PFQuery(className: "Messages")
        query.whereKey("users", containsAllObjectsInArray: selectedPlayersUsername as [AnyObject])
        
        
        
        query.addAscendingOrder("createdAt")
        query.findObjectsInBackgroundWithBlock {
            (objects:[AnyObject]?, error:NSError?) -> Void in
            
            if error == nil {
                
                
                for object in objects! {
                    if object.objectForKey("users")!.count == selectedPlayersUsername.count {
                        senderArray.append(object.objectForKey("sender") as! String)
                        messageArray.append(object.objectForKey("message") as! String)
                    }
                }
                
                // empty everything we have added in our scrollview
                for subView in self.resultsScrollView.subviews {
                    subView.removeFromSuperview()
                }
                
                
                var lastFrameSize:CGFloat = 0
                
                
                for var i=0; i<messageArray.count; i++ {
                    
                    
                    

                    if senderArray[i] == userName {
                        
                        var messageLbl:UILabel = UILabel()
                        messageLbl.frame = CGRectMake(0, 0, self.resultsScrollView.frame.size.width*3/5, CGFloat.max)
                        messageLbl.backgroundColor = UIColor.lightGrayColor()
                        messageLbl.lineBreakMode = NSLineBreakMode.ByWordWrapping
                        messageLbl.textAlignment = NSTextAlignment.Left
                        messageLbl.numberOfLines = 0   // can have maximum lines possible
                        messageLbl.font = UIFont(name: "Helvetica Neuse", size: 17)
                        messageLbl.textColor = UIColor.whiteColor()
                        messageLbl.text = messageArray[i]
                        messageLbl.sizeToFit() // resize label to current view
                        messageLbl.layer.zPosition = 20
                        
                        
                        var messageTF:UITextField = UITextField()
                        messageTF.frame = messageLbl.frame
                        messageTF.text = messageArray[i]
                        messageTF.backgroundColor = UIColor.brownColor()
                        messageTF.layer.zPosition = 5

                        
                        //make label like a bubble
                        var frameLbl:UILabel = UILabel()
                        frameLbl.frame.size = CGSizeMake(messageLbl.frame.size.width+20, messageLbl.frame.size.height+10)
                        frameLbl.backgroundColor = UIColor.lightGrayColor()
                        frameLbl.layer.masksToBounds = true
                        frameLbl.layer.cornerRadius = 10
                        frameLbl.layer.zPosition = 10



//                        if i == 0 {
//                            self.messageY += messageLbl.frame.size.height + 20
//                            self.frameY += frameLbl.frame.size.height + 20
//                        }
                        
                        
                        if i == 0 {
                            
                        } else {
                            if senderArray[i-1] == userName {
                                self.messageY += 35
                                self.frameY += 35
                                self.imgY += 35

                            } else {
                                self.messageY += 50
                                self.frameY += 50
                                self.imgY += 50
                            }
                        }

//                        println("THIS IS MESSAGE: \(messageLbl.frame.size.height)")
                        
                        messageLbl.frame.origin.x = (self.resultsScrollView.frame.size.width - self.messageX) - messageLbl.frame.size.width + 12
                        messageLbl.frame.origin.y = self.messageY
                        self.resultsScrollView.addSubview(messageLbl)
                        
                        frameLbl.frame.origin.x = (self.resultsScrollView.frame.size.width - self.frameX) - frameLbl.frame.size.width + 17
                        frameLbl.frame.origin.y = self.frameY
                        self.resultsScrollView.addSubview(frameLbl)
                        
                        messageTF.frame.origin.x = messageLbl.frame.origin.x
                        messageTF.frame.origin.y = messageLbl.frame.origin.y
                        self.resultsScrollView.addSubview(messageTF)

                        
                        if messageLbl.frame.size.height > 20.5 {
                            self.messageY += messageLbl.frame.size.height - 20.5
                            self.frameY += frameLbl.frame.size.height - 30.5
                            self.imgY += frameLbl.frame.size.height - 30.5
                        }


                        if i == messageArray.count - 1 {
                            
                            lastFrameSize = frameLbl.frame.size.height
                        }


                        
                        
                    } else {
                        
                        

                        
                        //make
                        var messageLbl:UILabel = UILabel()
                        messageLbl.frame = CGRectMake(0, 0, self.resultsScrollView.frame.size.width*3/5, CGFloat.max)
                        messageLbl.backgroundColor = UIColor.groupTableViewBackgroundColor()
                        messageLbl.lineBreakMode = NSLineBreakMode.ByWordWrapping
                        messageLbl.textAlignment = NSTextAlignment.Left
                        messageLbl.numberOfLines = 0   // can have maximum lines possible
                        messageLbl.font = UIFont(name: "Helvetica Neuse", size: 17)
                        messageLbl.textColor = UIColor.blackColor()
                        messageLbl.text = messageArray[i]
                        messageLbl.sizeToFit() // resize label to current view
                        messageLbl.layer.zPosition = 20
                        
                        var messageTF:UITextField = UITextField()
                        messageTF.frame = messageLbl.frame
                        messageTF.text = messageArray[i]
                        messageTF.backgroundColor = UIColor.brownColor()
                        messageTF.layer.zPosition = 5

                        
                        
                        
                        //make label like a bubble
                        var frameLbl:UILabel = UILabel()
                        frameLbl.frame.size = CGSizeMake(messageLbl.frame.size.width+20, messageLbl.frame.size.height + 10)
                        frameLbl.backgroundColor = UIColor.groupTableViewBackgroundColor()
                        frameLbl.layer.masksToBounds = true
                        frameLbl.layer.cornerRadius = 10
                        frameLbl.layer.zPosition = 10


                        
                        var img:UIImageView = UIImageView()
                        
                        
                        var query = PFQuery(className: "_User")
                        
                        query.whereKey("username", equalTo: senderArray[i])
                        var objects = query.findObjects()
                        
                        self.resultsImageFiles2.removeAll(keepCapacity: false)
                        
                        for object in objects! {
                            
                            self.resultsImageFiles2.append(object["photo"] as! PFFile)
                            
                            self.resultsImageFiles2[0].getDataInBackgroundWithBlock({
                                (imageData:NSData?, error:NSError?) -> Void in
                                
                                if error == nil {
                                    
                                    img.image = UIImage(data: imageData!)
                                    
                                }
                            })
                            
                        }
                        
                        img.frame.size = CGSizeMake(34, 34)
                        img.layer.zPosition = 30
                        img.layer.cornerRadius = img.frame.size.width/2
                        img.clipsToBounds = true
                        
                        
                        if i != 0 {
                            if senderArray[i-1] == senderArray[i] {
                                self.messageY += 35
                                self.frameY += 35
                                self.imgY += 35
                                
                            } else {
                                self.messageY += 55
                                self.frameY += 55
                                self.imgY += 55
                                
                                img.frame.origin.x = self.imgX + 7
                                img.frame.origin.y = self.imgY
                                self.resultsScrollView.addSubview(img)
                            }
                        } else {
                            self.messageY += 10
                            self.frameY += 10
                            self.imgY += 10
                            img.frame.origin.x = self.imgX + 7
                            img.frame.origin.y = self.imgY
                            self.resultsScrollView.addSubview(img)

                        }

                        
                        messageLbl.frame.origin.x = self.messageX + 12
                        messageLbl.frame.origin.y = self.messageY
                        self.resultsScrollView.addSubview(messageLbl)
 
                        frameLbl.frame.origin.x = self.frameX + 7
                        frameLbl.frame.origin.y = self.frameY
                        self.resultsScrollView.addSubview(frameLbl)
                        
                        messageTF.frame.origin.x = messageLbl.frame.origin.x
                        messageTF.frame.origin.y = messageLbl.frame.origin.y
                        self.resultsScrollView.addSubview(messageTF)

                        
                        if messageLbl.frame.size.height > 20.5 {
                            self.messageY += messageLbl.frame.size.height - 20.5
                            self.frameY += frameLbl.frame.size.height - 30.5
                            self.imgY += frameLbl.frame.size.height - 30.5
                        }
                        
                        if i == messageArray.count - 1 {
                            
                            lastFrameSize = frameLbl.frame.size.height
                        }
                        
                    }
                    
                    if self.messageY < self.resultsScrollView.frame.height {
                        self.resultsScrollView.contentSize = CGSizeMake(theWidth, self.resultsScrollView.frame.height + 1)
                    } else {
                        self.resultsScrollView.contentSize = CGSizeMake(theWidth, self.messageY + lastFrameSize + 15)

                        
                        var bottomOffset:CGPoint = CGPointMake(0, self.resultsScrollView.contentSize.height - self.resultsScrollView.frame.height)
                        self.resultsScrollView.setContentOffset(bottomOffset, animated: false)

                    }


                    
                    
                }
            }
        }
    }
    
    
    
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        
        let theWidth = view.frame.size.width
        let theHeight = view.frame.size.height
        
        resultsScrollView.layer.zPosition = 20

        scrollViewOriginalY = self.resultsScrollView.frame.origin.y
        frameMessageOriginalY = self.frameMessageView.frame.origin.y
        
        refreshResults()
        
    }
    
    
    func addBtn_click() {
        
//        let dict:NSDictionary = notification.userInfo!
//        let s:NSValue = dict.valueForKey(UIKeyboardFrameEndUserInfoKey) as! NSValue
//        let rect:CGRect = s.CGRectValue()

        println("add")
        
        self.view.endEditing(true)

        
        popoverContent = self.storyboard!.instantiateViewControllerWithIdentifier("PopUp") as! UIViewController
        
//        if presentedViewController == popoverContent {
//            self.dismissViewControllerAnimated(true, completion: nil)
//        }
        
        popoverContent.modalPresentationStyle = UIModalPresentationStyle.Popover
        
        var interfaceOrientation = UIApplication.sharedApplication().statusBarOrientation
        
        if UIInterfaceOrientationIsPortrait(interfaceOrientation) {
            
            popoverContent.preferredContentSize = CGSizeMake(view.frame.size.width,80*3 + 80)
            popover = popoverContent.popoverPresentationController
            popover!.delegate = self
            popover!.sourceView = self.view
            popover!.sourceRect = CGRectMake(0,view.frame.size.height - 60,100,100)
            popover!.permittedArrowDirections = UIPopoverArrowDirection.Down

        } else {
            
            popoverContent = self.storyboard!.instantiateViewControllerWithIdentifier("PopUp") as! UIViewController
            popoverContent.modalPresentationStyle = UIModalPresentationStyle.Popover
            popoverContent.preferredContentSize = CGSizeMake(80*3 + 80,view.frame.size.height/3)
            popover = popoverContent.popoverPresentationController
            popover!.delegate = self
            popover!.sourceView = self.view
            popover!.sourceRect = CGRectMake(0,view.frame.size.height - 60,0,0)
            popover!.permittedArrowDirections = UIPopoverArrowDirection.Down

        }
        

        self.presentViewController(popoverContent, animated: true, completion: nil)

        
        
    }
    
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }
    
    @IBAction func sendBtn_click(sender: AnyObject) {
        
        if messageTextView.text == "" {
            
            sendBtn.opaque = true
            
            sendBtn.enabled = false
            
        } else {
            
            for var i=0; i<selectedPlayersUsername.count; i++ {
                otherNames.append(selectedPlayersUsername[i] as! String)
            }
            
            var messageDBTable = PFObject(className: "Messages")
            messageDBTable["sender"] = userName
            messageDBTable["users"] = otherNames
            messageDBTable["message"] = self.messageTextView.text
            
            var now = NSDate()
            var calendar = NSCalendar.currentCalendar()
            var formatter = NSDateFormatter()
            formatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ss.SSS'Z'"
            var components = calendar.components(.CalendarUnitYear | .CalendarUnitMonth | .CalendarUnitDay | .CalendarUnitHour | .CalendarUnitMinute | .CalendarUnitSecond, fromDate: now)
            
            
            var date = [AnyObject]()
            date.append(components.year)
            date.append(components.month)
            date.append(components.day)
            date.append(components.hour)
            date.append(components.minute)
            date.append(components.second)
            date.append(components.nanosecond)


            //HOW ABOUT THE TIME DIFFERENCE???
            messageDBTable["timeArray"] = date
            
            println(date)
            
            
            messageDBTable.saveInBackgroundWithBlock {
                (success:Bool, error:NSError?) -> Void in
                
                if error == nil {
                    
                    
                    //Push Notification Step 3
                    for var i=0; i<otherNames.count; i++ {
                        
                        
                        
                        var uQuery:PFQuery = PFUser.query()!
                        
                        uQuery.whereKey("username", equalTo: otherNames[i])
                        
                        var pushQuery:PFQuery = PFInstallation.query()!
                        pushQuery.whereKey("user", matchesQuery: uQuery)
                        
                        var push:PFPush = PFPush()
                        push.setQuery(pushQuery)
                        push.setMessage("New Message")
                        push.sendPushInBackgroundWithBlock({
                            (success: Bool, error: NSError?) -> Void in
                            
                            if (error == nil) {
                                println("push sent")
                                
                            } else {
                                
                                println("Error sending push: \(error!.description).");
                                
                            }
                            
                        })

                    }
                    
                    //--end
                    
                    
                    
                    println("message sent")
                    self.messageTextView.text = ""
                    self.messageLabel.hidden = false
                    otherNames.removeAll(keepCapacity: false)
                    self.refreshResults()
                    self.view.endEditing(true)
                }
            }
        }
    }

    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        if self.view.layer.zPosition < 10 {
            self.view.endEditing(true)
        }
        
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
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
