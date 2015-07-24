//
//  FindPlayerVC.swift
//  UniversiTeam2
//
//  Created by Jin Seok Park on 2015. 7. 15..
//  Copyright (c) 2015년 Jin Seok Park. All rights reserved.
//

import UIKit

class FindPlayerVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.navigationItem.backBarButtonItem?.title = ""
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 60
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:findCell = tableView.dequeueReusableCellWithIdentifier("Cell") as! findCell
        
        if indexPath.row == 0 {
            cell.textLabel!.text = "Search by Name"
        }
        if indexPath.row == 1 {
            cell.textLabel!.text = "Search by Email"
        }
        if indexPath.row == 2 {
            cell.textLabel!.text = "Search by School"
        }
        if indexPath.row == 3 {
            cell.textLabel!.text = "Search by Position"
        }
        if indexPath.row == 4 {
            cell.textLabel!.text = "Search by Region"
        }

        
        var detailButton = UITableViewCellAccessoryType.DisclosureIndicator
        cell.accessoryType = detailButton

        
        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.row == 0 {chosenFinder = 1}
        if indexPath.row == 1 {chosenFinder = 1}
        if indexPath.row == 2 {chosenFinder = 2}
        if indexPath.row == 3 {chosenFinder = 3}
        if indexPath.row == 4 {chosenFinder = 4}

        self.performSegueWithIdentifier("goToFind", sender: self)
        
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

}
