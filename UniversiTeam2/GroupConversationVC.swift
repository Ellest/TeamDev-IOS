//
//  GroupConversationVC.swift
//  UniversiTeam
//
//  Created by Jin Seok Park on 2015. 6. 8..
//  Copyright (c) 2015년 Jin Seok Park. All rights reserved.
//

import UIKit

var groupConversationVC_title = ""


class GroupConversationVC: UIViewController, UIScrollViewDelegate {

    @IBOutlet var resultsScrollView: UIScrollView!
    @IBOutlet var frameMessageView: UIView!
    @IBOutlet var messageTextView: UITextView!
    @IBOutlet var lineLabel: UILabel!
    @IBOutlet var sendBtn: UIButton!

    var scrollViewOriginalY:CGFloat = 0
    var frameMessageOriginalY:CGFloat = 0
    
    let messageLabel = UILabel(frame: CGRectMake(5, 10, 200, 20))

    
    var messageX:CGFloat = 37.0
    var messageY:CGFloat = 26.0
    var frameX:CGFloat = 32.0
    var frameY:CGFloat = 21.0
    var imgX:CGFloat = 3
    var imgY:CGFloat = 3
    
    
    
    var messageArray = [String]()
    
    var senderArray = [String]()

    
    var myImg:UIImage? = UIImage()
    
    var resultsImageFiles2 = [PFFile]()
    var resultsImageFiles = [PFFile]()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        let theWidth = view.frame.size.width
        let theHeight = view.frame.size.height
        
        let topHeight = self.navigationController?.navigationBar.frame.height
        
        
                sendBtn.center = CGPointMake(theWidth-30, 12)
        
                scrollViewOriginalY = self.resultsScrollView.frame.origin.y
                frameMessageOriginalY = self.frameMessageView.frame.origin.y
        
        
        messageLabel.text = "Type a message..."
        messageLabel.font = UIFont(name: "Helvetica", size: 14)
        messageLabel.backgroundColor = UIColor.clearColor()
        messageLabel.textColor = UIColor.lightGrayColor()
        messageTextView.addSubview(messageLabel)
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWasShown:", name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        
        
        let tapScrollViewGesture = UITapGestureRecognizer(target: self, action: "didTapScrollView")
        tapScrollViewGesture.numberOfTapsRequired = 1
        resultsScrollView.addGestureRecognizer(tapScrollViewGesture)
        
        
        //notification
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "getGroupMessageFunc", name: "getGroupMessage", object: nil)

    }
    
    func getGroupMessageFunc() {
        
        refreshResults()
    }

    override func viewDidAppear(animated: Bool) {
        
        
        self.title = groupConversationVC_title

        var query = PFQuery(className: "_User")
        query.whereKey("username", equalTo: userName)
        
        var objects = query.findObjects()
        
        self.resultsImageFiles.removeAll(keepCapacity: false)
        
        for object in objects! {
            
            self.resultsImageFiles.append(object["photo"] as! PFFile)
            self.resultsImageFiles[0].getDataInBackgroundWithBlock({
                (imageData:NSData?, error:NSError?) -> Void in
                
                if error == nil {
                    
                    self.myImg = UIImage(data: imageData!)
                    
                    self.refreshResults()
                    
                }
                
            })
            
            
            
        }
    }
    
    
    
    func refreshResults() {
        
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
        
        
        var query = PFQuery(className: "GroupMessages")
        
        
        
        query.whereKey("group", equalTo: groupConversationVC_title)
        
        query.addAscendingOrder("createdAt")
        
        query.findObjectsInBackgroundWithBlock {
            (objects:[AnyObject]?, error:NSError?) -> Void in
            
            if error == nil {
                
                for object in objects! {
                    
                    self.senderArray.append(object.objectForKey("sender") as! String)
                    self.messageArray.append(object.objectForKey("message") as! String)
                }
                
                // empty everything we have added in our scrollview
                for subView in self.resultsScrollView.subviews {
                    subView.removeFromSuperview()
                }
                
                for var i=0; i<=self.messageArray.count-1; i++ {
                    
                    if self.senderArray[i] == userName {
                        
                        var messageLbl:UILabel = UILabel()
                        messageLbl.frame = CGRectMake(0, 0, self.resultsScrollView.frame.size.width*3/5, CGFloat.max)
                        messageLbl.backgroundColor = UIColor.blueColor()
                        messageLbl.lineBreakMode = NSLineBreakMode.ByWordWrapping
                        messageLbl.textAlignment = NSTextAlignment.Left
                        messageLbl.numberOfLines = 0   // can have maximum lines possible
                        messageLbl.font = UIFont(name: "Helvetica Neuse", size: 17)
                        messageLbl.textColor = UIColor.whiteColor()
                        messageLbl.text = self.messageArray[i]
                        messageLbl.sizeToFit() // resize label to current view
                        messageLbl.layer.zPosition = 20
                        messageLbl.frame.origin.x = (self.resultsScrollView.frame.size.width - self.messageX) - messageLbl.frame.size.width
                        messageLbl.frame.origin.y = self.messageY
                        self.resultsScrollView.addSubview(messageLbl)
                        self.messageY += messageLbl.frame.size.height + 30
                        
                        //make label like a bubble
                        var frameLbl:UILabel = UILabel()
                        frameLbl.frame.size = CGSizeMake(messageLbl.frame.size.width+10, messageLbl.frame.size.height+10)
                        frameLbl.frame.origin.x = (self.resultsScrollView.frame.size.width - self.frameX) - frameLbl.frame.size.width
                        frameLbl.frame.origin.y = self.frameY
                        frameLbl.backgroundColor = UIColor.blueColor()
                        frameLbl.layer.masksToBounds = true
                        frameLbl.layer.cornerRadius = 10
                        self.resultsScrollView.addSubview(frameLbl)
                        self.frameY += frameLbl.frame.size.height + 20
                        
                        var img:UIImageView = UIImageView()
                        img.image = self.myImg
                        img.frame.size = CGSizeMake(34, 34)
                        img.frame.origin.x = (self.resultsScrollView.frame.size.width - self.imgX) - img.frame.size.width
                        img.frame.origin.y = self.imgY
                        img.layer.zPosition = 30
                        img.layer.cornerRadius = img.frame.size.width/2
                        img.clipsToBounds = true
                        self.resultsScrollView.addSubview(img)
                        self.imgY += frameLbl.frame.size.height + 20
                        
                        self.resultsScrollView.contentSize = CGSizeMake(theWidth, self.messageY)
                        
                        
                        
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
                        messageLbl.text = self.messageArray[i]
                        messageLbl.sizeToFit() // resize label to current view
                        messageLbl.layer.zPosition = 20
                        messageLbl.frame.origin.x = self.messageX
                        messageLbl.frame.origin.y = self.messageY
                        self.resultsScrollView.addSubview(messageLbl)
                        self.messageY += messageLbl.frame.size.height + 30
                        
                        
                        
                        //make label like a bubble
                        var frameLbl:UILabel = UILabel()
                        frameLbl.frame = CGRectMake(self.frameX, self.frameY, messageLbl.frame.size.width+10, messageLbl.frame.size.height + 10)
                        frameLbl.backgroundColor = UIColor.groupTableViewBackgroundColor()
                        frameLbl.layer.masksToBounds = true
                        frameLbl.layer.cornerRadius = 10
                        self.resultsScrollView.addSubview(frameLbl)
                        self.frameY += frameLbl.frame.size.height + 20
                        
                        var img:UIImageView = UIImageView()
                        
                        
                        var query = PFQuery(className: "_User")
                        
                        query.whereKey("username", equalTo: self.senderArray[i])
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
                        
                        
                        img.frame = CGRectMake(self.imgX, self.imgY, 34, 34)
                        img.layer.zPosition = 30
                        img.layer.cornerRadius = img.frame.size.width/2
                        img.clipsToBounds = true
                        self.resultsScrollView.addSubview(img)
                        self.imgY += frameLbl.frame.size.height + 20
                        
                        self.resultsScrollView.contentSize = CGSizeMake(theWidth, self.messageY)
                        
                    }
                    
                    
                    var bottomOffset:CGPoint = CGPointMake(0, self.resultsScrollView.contentSize.height - self.resultsScrollView.bounds.size.height)
                    self.resultsScrollView.setContentOffset(bottomOffset, animated: false)
                    
                    
                }
            }
        }

        
    }
    
    
    
    
    
    
    func keyboardWasShown(notification:NSNotification) {
        
        let dict:NSDictionary = notification.userInfo!
        let s:NSValue = dict.valueForKey(UIKeyboardFrameEndUserInfoKey) as! NSValue
        let rect:CGRect = s.CGRectValue()
        
        UIView.animateWithDuration(0.1, delay: 0, options: .CurveLinear, animations: {
            
            self.resultsScrollView.frame.origin.y = self.scrollViewOriginalY - rect.height
            self.frameMessageView.frame.origin.y = self.frameMessageOriginalY - rect.height
            
            var bottomOffset:CGPoint = CGPointMake(0, self.resultsScrollView.contentSize.height - self.resultsScrollView.bounds.size.height)
            self.resultsScrollView.setContentOffset(bottomOffset, animated: false)
            
            
            }, completion: {
                (finished:Bool) in
                
                
        })
        
    }
    
    func keyboardWillHide(notification:NSNotification) {
        
        
        let dict:NSDictionary = notification.userInfo!
        let s:NSValue = dict.valueForKey(UIKeyboardFrameEndUserInfoKey) as! NSValue
        let rect:CGRect = s.CGRectValue()
        
        UIView.animateWithDuration(0.1, delay: 0, options: .CurveLinear, animations: {
            
            self.resultsScrollView.frame.origin.y = self.scrollViewOriginalY
            self.frameMessageView.frame.origin.y = self.frameMessageOriginalY
            
            var bottomOffset:CGPoint = CGPointMake(0, self.resultsScrollView.contentSize.height - self.resultsScrollView.bounds.size.height)
            self.resultsScrollView.setContentOffset(bottomOffset, animated: false)
            
            
            }, completion: {
                (finished:Bool) in
                
                
        })
        
    }
    
    func didTapScrollView() {
        
        self.view.endEditing(true)
    }

    func textViewDidChange(textView: UITextView) {
        
        if !messageTextView.hasText() {
            
            self.messageLabel.hidden = false
        }
        else {
            
            self.messageLabel.hidden = true
        }
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        
        if !messageTextView.hasText(){
            self.messageLabel.hidden = false
        }
    }


    @IBAction func sendBtn_click(sender: AnyObject) {
        
        if messageTextView.text == "" {
            
            
            
        } else {
            
            var groupMessageTable = PFObject(className: "GroupMessages")
            
            groupMessageTable["group"] = groupConversationVC_title
            groupMessageTable["sender"] = userName
            groupMessageTable["message"] = self.messageTextView.text
            
            groupMessageTable.saveInBackgroundWithBlock({
                (success:Bool, error:NSError?) -> Void in
                
                if success == true {
                    
                    var senderSet = Set([""])
                    senderSet.removeAll(keepCapacity: false)
                    
                    for var i = 0; i <= self.senderArray.count - 1; i++ {
                        
                        if self.senderArray[i] != userName {
                            
                            senderSet.insert(self.senderArray[i])
                            
                        }
                        
                    }
                    
                    //make set into an array
                    var senderSetArray: NSArray = Array(senderSet)
                    
                    for var i2 = 0; i2 <= senderSetArray.count - 1; i2++ {
                        
                        println(senderSetArray[i2])
                        
                        
                        var uQuery:PFQuery = PFUser.query()!
                        uQuery.whereKey("username", equalTo: senderSetArray[i2])
                        
                        var pushQuery:PFQuery = PFInstallation.query()!
                        pushQuery.whereKey("user", matchesQuery: uQuery)
                        
                        var push:PFPush = PFPush()
                        push.setQuery(pushQuery)
                        push.setMessage("New Group Message")
                        push.sendPushInBackgroundWithBlock({
                            (success: Bool, error: NSError?) -> Void in
                            
                            if (error == nil) {
                                println("push sent")
                                
                            } else {
                                
                                println("Error sending push: \(error!.description).");
                                
                            }
                            
                        })

                        
                    }
                    

                    
                    
                    
                    println("message sent")
                    
                    self.messageTextView.text = ""
                    self.messageLabel.hidden = false
                    self.refreshResults()
                    
                    
                }
                
            })
            
            
            
        }
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true)
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
