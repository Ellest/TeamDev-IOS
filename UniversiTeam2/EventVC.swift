//
//  EventVC.swift
//  UniversiTeam2
//
//  Created by Jin Seok Park on 2015. 7. 6..
//  Copyright (c) 2015년 Jin Seok Park. All rights reserved.
//

import UIKit

class EventVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var resultsTable: UITableView!
    var eventDescription = ""
    var cellArray = [newEventCell]()
    var firstIndexPath = NSIndexPath()
    var eventTitle = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 45
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:newEventCell = resultsTable.dequeueReusableCellWithIdentifier("Cell") as! newEventCell
        
        
        resultsTable.cellForRowAtIndexPath(indexPath)
        
        println(indexPath)
        
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                cell.placeholder.placeholder = "Title"
                eventDescription = cell.placeholder.text
                firstIndexPath = indexPath
            }
            if (indexPath.row == 1) {
                cell.placeholder.placeholder = "Location"
            }
        }
        
        if (indexPath.section == 1) {
            if (indexPath.row == 0) {
                
                cell.placeholder.hidden = true
                cell.textLabel?.text = "Alert"
                cell.textLabel?.textColor = UIColor.grayColor()
                cell.textLabel?.center.x = 22

                cell.selectionStyle = UITableViewCellSelectionStyle.None;
                
                var switchView = UISwitch(frame: CGRectZero)
                switchView.tag = 111
                cell.accessoryView = switchView
                
                switchView.addTarget(self, action: "updateSwitch:", forControlEvents: UIControlEvents.TouchUpInside)
            }
        }
        
        if (indexPath.section == 2) {
            if (indexPath.row == 0) {
                cell.placeholder.hidden = true
                
                var detailButton = UITableViewCellAccessoryType.DisclosureIndicator
                cell.accessoryType = detailButton
            }
        }
        

        return cell
    }
    
    func updateSwitch(mySwitch: UISwitch) {
        
        if mySwitch.on {
            mySwitch.setOn(true, animated:true)
        } else {
            mySwitch.setOn(false, animated:true)
        }
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath newIndexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(tableView.indexPathForSelectedRow()!, animated: false)
        
    }


//    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        if (section == 0){
//            return "Others"
//        } else {
//            return "Settings"
//        }
//    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 30
    }

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section==0 {return 2}
        if section==1 {return 1}
        if section==2 {return 2}
        else {return 2}
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 4
    }

    @IBAction func cancelBtn_click(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    @IBAction func addBtn_click(sender: AnyObject) {
        
        var cell = resultsTable.cellForRowAtIndexPath(firstIndexPath) as! newEventCell

        if (cell.placeholder.text == "") {
            eventTitle = "New Event"
        } else {
            println(cell.placeholder.text)

            eventTitle = cell.placeholder.text
        }
        
        var calendarDBTable = PFObject(className: "Schedule")
        calendarDBTable["Year"] = year
        calendarDBTable["Month"] = month
        calendarDBTable["Day"] = day
        calendarDBTable["Title"] = eventTitle
        calendarDBTable["Description"] = eventDescription
        
        println(eventDescription)
        
        calendarDBTable.saveInBackgroundWithBlock {
            (success:Bool, error:NSError?) -> Void in
            
            if success == true {
                
                println("event saved")
            }
        }
        self.dismissViewControllerAnimated(true, completion: nil)
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
