//
//  FindDetailedVC.swift
//  UniversiTeam2
//
//  Created by Jin Seok Park on 2015. 7. 16..
//  Copyright (c) 2015년 Jin Seok Park. All rights reserved.
//

import UIKit

var chosenFinder = 0

class FindDetailedVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var chosenPlayers = [String]()
    @IBOutlet weak var resultsTable: UITableView!
    @IBOutlet weak var textField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        
        if chosenFinder == 0 {self.textField.placeholder = "Type Name"}
        if chosenFinder == 1 {self.textField.placeholder = "Type Email"}
        if chosenFinder == 2 {self.textField.placeholder = "Type School"}
        if chosenFinder == 3 {self.textField.placeholder = "Type Position"}
        if chosenFinder == 4 {self.textField.placeholder = "Type Region"}

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:findDetailedCell = resultsTable!.dequeueReusableCellWithIdentifier("Cell") as! findDetailedCell
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.chosenPlayers.count != 0 {
            return self.chosenPlayers.count
        } else {
            return 5
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 48
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
