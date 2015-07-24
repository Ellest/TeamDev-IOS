//
//  MessagesVC.swift
//  UniversiTeam
//
//  Created by Jin Seok Park on 5/20/15.
//  Copyright (c) 2015 Jin Seok Park. All rights reserved.
//

import UIKit

var lastTimeStamp = NSMutableArray()

class MessagesVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var resultsTable: UITableView!
    
    var resultsNameArray = [String]()
    var resultsNameArray2 = [NSArray]()
    var resultsImageFiles = [PFFile]()
    var resultsImageFiles2 = [[PFFile]]()
    var resultsTimeStamp = NSMutableArray()
    var resultsTimeStamp2 = [NSMutableArray]()
    
    
    var senderArray = [String]()
    var otherArray = [NSMutableArray]()
    var messageArray = [String]()
    var timesArray = [NSMutableArray]()
    
    var sender2Array = [String]()
    var other2Array = [NSMutableArray]()
    var message2Array = [String]()
    var times2Array = [NSMutableArray]()

    
    var results = 0
    var currResult = Int()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        var theWidth = view.frame.size.width
        var theHeight = view.frame.size.height
        
//        resultsTable.frame = CGRectMake(0, 0, theWidth, theHeight - 64)
        
//        self.fetchResults()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        if resultsNameArray.count != 0 {
            
            
            var index = 0
            
            
            senderArray.removeAll(keepCapacity: false)
            otherArray.removeAll(keepCapacity: false)
            messageArray.removeAll(keepCapacity: false)
            timesArray.removeAll(keepCapacity: false)

            
            var query1 = PFQuery(className: "Messages")
            
            query1.whereKey("users", containsAllObjectsInArray: userName2)
            

            query1.addDescendingOrder("createdAt")
            
            query1.findObjectsInBackgroundWithBlock({ (objects:[AnyObject]?, error:NSError?) -> Void in
                
                if error == nil {
                    
                    for object in objects! {
                        
                        //if no updates, break
                        if lastTimeStamp.isEqualToArray(object.objectForKey("timeArray") as! [AnyObject]){
                            break
                            
                        } else {
                            
                            //remove current user from array
                            var new = object.objectForKey("users") as! NSMutableArray
                            
                            for var i=0; i<new.count; i++ {
                                if new[i] as! String==userName {
                                    new.removeObjectAtIndex(i)
                                }
                            }

                            //compare with new array
                            var sortedOther1 = (object.objectForKey("users") as! NSMutableArray).sortedArrayUsingSelector("caseInsensitiveCompare:") as NSArray
                                

                            var isfound1 = false

                            
                            if (self.otherArray.count > 0) {
                                
                                for var i=0; i<self.otherArray.count; i++ {
                                    
                                    var sortedOther2 = self.otherArray[i].sortedArrayUsingSelector("caseInsensitiveCompare:") as NSArray
                                    
                                    //if exists in new array, break
                                    if sortedOther1.isEqualToArray(sortedOther2 as [AnyObject]){
                                        
                                        isfound1 = true
                                        break
                                    }
                                    
                                }
                            }
                            
                            //if does not exist in new array, check old array
                            if isfound1 == false {
                                
                                var isfound2 = false

                                for var j = 0; j < self.other2Array.count; j++ {
                                    
                                    var sortedOther3 = self.other2Array[j].sortedArrayUsingSelector("caseInsensitiveCompare:")
                                    
                                    //if exists in old array, remove from old array, and insert to update at index
                                    if sortedOther1.isEqualToArray(sortedOther3){
                                        
                                        isfound2 = true
                                        
                                        self.message2Array.removeAtIndex(j)
                                        self.other2Array.removeAtIndex(j)
                                        self.sender2Array.removeAtIndex(j)
                                        self.times2Array.removeAtIndex(j)
                                        
                                        
                                        self.resultsNameArray2.insert(self.resultsNameArray2[j], atIndex: index)
                                        self.resultsImageFiles2.insert(self.resultsImageFiles2[j], atIndex: index)
                                        
                                        self.resultsNameArray2.removeAtIndex(j+1)
                                        self.resultsImageFiles2.removeAtIndex(j+1)
                                        self.resultsTimeStamp2.removeAtIndex(j+1)
                                        
                                        self.message2Array.insert(object.objectForKey("message") as! String, atIndex: index)
                                        self.sender2Array.insert(object.objectForKey("sender") as! String, atIndex: index)
                                        self.times2Array.insert(object.objectForKey("timeArray") as! NSMutableArray, atIndex: index)
                                        self.other2Array.insert(object.objectForKey("users") as! NSMutableArray, atIndex: index)
                                        
                                        self.resultsTimeStamp2 = self.times2Array

                                        
                                        index += 1

                                        break
                                    }
                                }
                                
                                //if does not exist in old array, insert to update at index
                                if isfound2 == false {
                                    
                                    self.message2Array.insert(object.objectForKey("message") as! String, atIndex: index)
                                    self.sender2Array.insert(object.objectForKey("sender") as! String, atIndex: index)
                                    self.times2Array.insert(object.objectForKey("timeArray") as! NSMutableArray, atIndex: index)
                                    self.other2Array.insert(object.objectForKey("users") as! NSMutableArray, atIndex: index)
                                    
                                    
                                    self.resultsNameArray.removeAll(keepCapacity: false)
                                    self.resultsImageFiles.removeAll(keepCapacity: false)

                                    
                                    for var i=0; i<self.other2Array[index].count; i++ {
                                        
                                        
                                        if let result = self.other2Array[index][i] as? String {
                                            
                                            var queryF = PFUser.query()
                                            queryF!.whereKey("username", equalTo: self.other2Array[index][i])
                                            
                                            var objects = queryF!.findObjects()
                                            
                                            
                                            for object in objects! {
                                                
                                                var first = object["firstName"] as! String
                                                var last = object["lastName"] as! String
                                                var fullName = "\(first) \(last)"
                                                self.resultsNameArray.append(fullName)
                                                self.resultsImageFiles.append(object.objectForKey("photo") as! PFFile)
                                            }
                                        }
                                    }
                                    
                                    self.resultsNameArray2.insert(self.resultsNameArray, atIndex: index)
                                    self.resultsImageFiles2.insert(self.resultsImageFiles, atIndex: index)
                                    self.resultsTimeStamp2 = self.times2Array

                                    
                                    index += 1
                                    
                                }
                            }
                            //--------end
                            
                            
                        }
                        
                        self.results = self.other2Array.count
                    }
                    
                    
                    
                    if self.currResult < self.results {
                        
                        
                    }

                    
                    self.resultsTable.reloadData()

                    
                }
            })


            

            
            
            
            
        } else {
            
            
            senderArray.removeAll(keepCapacity: false)
            otherArray.removeAll(keepCapacity: false)
            messageArray.removeAll(keepCapacity: false)
            timesArray.removeAll(keepCapacity: false)

        
        resultsNameArray.removeAll(keepCapacity: false)
        resultsNameArray2.removeAll(keepCapacity: false)
        resultsImageFiles.removeAll(keepCapacity: false)
        resultsImageFiles2.removeAll(keepCapacity: false)
        resultsTimeStamp2.removeAll(keepCapacity: false)
        
        
        sender2Array.removeAll(keepCapacity: false)
        other2Array.removeAll(keepCapacity: false)
        message2Array.removeAll(keepCapacity: false)
        times2Array.removeAll(keepCapacity: false)


//        let setPredicate = NSPredicate(format: "sender = %@ OR other = %@", userName, userName)
//        var query = PFQuery(className: "Messages", predicate: setPredicate)
        
        //        if (resultsNameArray.count == 0) {
//            query.whereKey("createdAt", greaterThan: )
//        }
        
        
        
        var query = PFQuery(className: "Messages")

        
        query.whereKey("users", containsAllObjectsInArray: userName2)

        query.addDescendingOrder("createdAt")
        
        
        query.findObjectsInBackgroundWithBlock{
            (objects:[AnyObject]?, error:NSError?) -> Void in
            
            if error == nil {
            

                var loop = 0
                
                for object in objects! {
                    
                    if loop == 0 {
                        lastTimeStamp = object.objectForKey("timeArray") as! NSMutableArray
                    }
                    loop += 1
                    
//                    self.resultsTimeStampString.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ss.SSS'Z'"
                    self.senderArray.append(object.objectForKey("sender") as! String)
                    self.otherArray.append(object.objectForKey("users") as! NSMutableArray)
                    self.messageArray.append(object.objectForKey("message") as! String)
                    self.timesArray.append(object.objectForKey("timeArray") as! NSMutableArray)
                }
                //Do not add if already exists
                for var i = 0; i <= self.senderArray.count - 1; i++ {
                    
                    var isfound = false
                    
                    
                    var sortedOther1 = self.otherArray[i].sortedArrayUsingSelector("caseInsensitiveCompare:") as NSArray
                    
                    
                    for var j = 0; j < i; j++ {
                        
                        var sortedOther2 = self.otherArray[j].sortedArrayUsingSelector("caseInsensitiveCompare:")

                        if sortedOther1.isEqualToArray(sortedOther2){
                            
                            isfound = true
                            break
                        }
                    }
                    if isfound == false {
                        self.other2Array.append(self.otherArray[i])
                        self.message2Array.append(self.messageArray[i])
                        self.sender2Array.append(self.senderArray[i])
                        self.times2Array.append(self.timesArray[i])
                    }
                }
                //--------end
                self.results = self.other2Array.count
                self.currResult = 0
                self.fetchResults()
//                self.resultsTable.reloadData()
            }
        }
        }
    }
    

    
    func fetchResults() {
        
        
        if currResult < results {
            
            self.resultsNameArray.removeAll(keepCapacity: false)
            self.resultsImageFiles.removeAll(keepCapacity: false)
//            self.resultsTimeStamp2.removeAll(keepCapacity: false)
        
            var isfound = false
            
            for var i=0; i<self.other2Array[currResult].count; i++ {

                if(self.other2Array[currResult][i] as! String==userName){
                
                    if(self.other2Array[currResult].count - 1 == i) {
                        self.other2Array[currResult].removeObjectAtIndex(i)

                        break
                    }

                    self.other2Array[currResult].removeObjectAtIndex(i)
                    
                    isfound = true
                }
                

//                if self.other2Array[currResult][i].data == nil {
//                }
                
                if let result = self.other2Array[currResult][i] as? String {
                    
                    var queryF = PFUser.query()
                    queryF!.whereKey("username", equalTo: self.other2Array[currResult][i])
            
                    var objects = queryF!.findObjects()

                
                    for object in objects! {
                
                        var first = object["firstName"] as! String
                        var last = object["lastName"] as! String
                        var fullName = "\(first) \(last)"
                        self.resultsNameArray.append(fullName)
                        self.resultsImageFiles.append(object.objectForKey("photo") as! PFFile)
                    }
                    
                } else {
                    break
                }

                
            }
            
            
            self.resultsNameArray2.append(self.resultsNameArray)
            self.resultsImageFiles2.append(self.resultsImageFiles)

            currResult += 1
            
            self.fetchResults()
            
            self.resultsTimeStamp2 = self.times2Array

            self.resultsTable.reloadData()

        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Table
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.resultsNameArray2.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:messageCell = tableView.dequeueReusableCellWithIdentifier("Cell") as! messageCell
        
        if self.resultsNameArray2[indexPath.row].count == 1 {
            cell.nameLbl.text = self.resultsNameArray2[indexPath.row][0] as? String
        }
        
        else {
            
        var nameString = ""

        
        for var i=0; i<self.resultsNameArray2[indexPath.row].count; i++ {
            
            var name = self.resultsNameArray2[indexPath.row][i] as? String

            if i == 0 {
                nameString.splice("\(name!)", atIndex: nameString.endIndex)
            } else {
                nameString.splice(", \(name!)", atIndex: nameString.endIndex)
            }
            
            }
            cell.nameLbl.text = nameString


        }

        cell.messageLbl.text = self.message2Array[indexPath.row]
        cell.messageLbl.textColor = UIColor.grayColor()
//        cell.usernameLbl.text = self.other3Array[indexPath.row]
        
        
        var now = NSDate()
        var calendar = NSCalendar.currentCalendar()

        var components = calendar.components(.CalendarUnitYear | .CalendarUnitMonth | .CalendarUnitDay | .CalendarUnitHour | .CalendarUnitMinute | .CalendarUnitSecond, fromDate: now)

        if (components.year.description == self.times2Array[indexPath.row][0].description) {
            
            if (components.day.description.toInt()! - 1 == self.times2Array[indexPath.row][2].description.toInt()){
                cell.timeStamp.text = "Yesterday"
            }
            else if (components.day.description != self.times2Array[indexPath.row][2].description) {
                
                var month = self.times2Array[indexPath.row][1].description
                var monthName = String()
                
                if (month=="1") {monthName="Jan"}
                else if (month=="2") {monthName="Feb"}
                else if (month=="3") {monthName="Mar"}
                else if (month=="4") {monthName="Apr"}
                else if (month=="5") {monthName="May"}
                else if (month=="6") {monthName="Jun"}
                else if (month=="7") {monthName="Jul"}
                else if (month=="8") {monthName="Aug"}
                else if (month=="9") {monthName="Sep"}
                else if (month=="10") {monthName="Oct"}
                else if (month=="11") {monthName="Nov"}
                else if (month=="12") {monthName="Dec"}


                cell.timeStamp.text = "\(monthName) \(self.resultsTimeStamp2[indexPath.row][2].description)"

            } else {
                
                var min = self.times2Array[indexPath.row][4].description
                var minLbl = String()
                
                if (min=="0") {minLbl="00"}
                else if (min=="1") {minLbl="01"}
                else if (min=="2") {minLbl="02"}
                else if (min=="3") {minLbl="03"}
                else if (min=="4") {minLbl="04"}
                else if (min=="5") {minLbl="05"}
                else if (min=="6") {minLbl="06"}
                else if (min=="7") {minLbl="07"}
                else if (min=="8") {minLbl="08"}
                else if (min=="9") {minLbl="09"}
                else {minLbl = min}
                
                var hour = self.times2Array[indexPath.row][3].description
                
                if hour.toInt() < 12 {
                    cell.timeStamp.text = "\(self.times2Array[indexPath.row][3].description):\(minLbl)AM"
                } else if hour.toInt() == 12 {
                    cell.timeStamp.text = "\(self.times2Array[indexPath.row][3].description):\(minLbl)PM"
                } else {
                    cell.timeStamp.text = "\(hour.toInt()!-12):\(minLbl)PM"
                }
                
            }
            

        } else {
            cell.timeStamp.text = "\(self.times2Array[indexPath.row][0].description)/\(self.resultsTimeStamp2[indexPath.row][1].description)/\(self.resultsTimeStamp2[indexPath.row][2].description)"

        }
        


        
        resultsImageFiles2[indexPath.row][0].getDataInBackgroundWithBlock {
            (imageData : NSData?, error : NSError?) -> Void in

            if error == nil {

                let image = UIImage(data: imageData!)
                cell.profileImageView.image = image
                
            } else {
                
            }
            
        }
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        

        
        self.performSegueWithIdentifier("goToConversationVC2", sender: self)

        
        
        var cell = tableView.cellForRowAtIndexPath(indexPath) as! messageCell
        
        otherProfileName = cell.nameLbl.text!
        
        
        selectedPlayersUsername.removeAllObjects()
        for var i=0; i<self.resultsNameArray2[indexPath.row].count; i++ {
            selectedPlayersUsername.addObject(self.other2Array[indexPath.row][i])

        }
        selectedPlayersUsername.addObject(userName)
        
        tableView.deselectRowAtIndexPath(tableView.indexPathForSelectedRow()!, animated: false)


    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    override func shouldAutorotate() -> Bool {
        return false
    }

}


