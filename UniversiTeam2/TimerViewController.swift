//
//  TimerViewController.swift
//  UniversiTeam
//
//  Created by Jin Seok Park on 5/21/15.
//  Copyright (c) 2015 Jin Seok Park. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var startBtn: UIButton!
    @IBOutlet var lapBtn: UIButton!
    @IBOutlet var stopBtn: UIButton!
    @IBOutlet var resetBtn: UIButton!
    
    @IBOutlet var resultsTable: UITableView!
    var lapUserArray = [String]()
    var lapCounter = 1

    
    var timer = NSTimer()

    var count = 0
    var minutes = 0
    var seconds = 0
    var milsecs = 0
    var niceMilsecs = "00"
    var niceSeconds = "0"
    var niceMinutes = "0"
    
    
    @IBAction func start_Pressed(sender: AnyObject) {
        
        timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: Selector("result"), userInfo: nil, repeats: true)

        startBtn.hidden = true
        lapBtn.hidden = false
        stopBtn.hidden = false
        resetBtn.hidden = true
        
    }
    
    @IBAction func stop_Pressed(sender: AnyObject) {
        
        timer.invalidate()
        resetBtn.hidden = false
        lapBtn.hidden = true
        startBtn.hidden = false
        stopBtn.hidden = true

    }
    
    @IBAction func reset_Pressed(sender: AnyObject) {
    
        timer.invalidate()
        count = 0
        timeLabel.text = "00:00:00"
        resetBtn.hidden = true
        lapBtn.hidden = false
        
        self.lapUserArray.removeAll(keepCapacity: false)
        lapCounter = 1

        self.resultsTable.reloadData()
    
    }
    
    @IBAction func lap_Pressed(sender: AnyObject) {

        lapUserArray.append("Player \(lapCounter) : \(niceMinutes):\(niceSeconds):\(niceMilsecs)")
        
        
        lapCounter++
        
        self.resultsTable.reloadData()
        
    }
    
    
    
    func result() {
        
        count++
        
        milsecs = count % 100
        seconds = ((count - (count % 100)) / 100) % 60
        minutes = ((count - (count % 100)) / 100) / 60
        
        niceMinutes = String(format:"%02d", minutes)
        niceSeconds = String(format:"%02d", seconds)
        niceMilsecs = String(format:"%02d", milsecs)
        
        timeLabel.text = "\(niceMinutes):\(niceSeconds):\(niceMilsecs)"
        
    }
    
    

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.lapUserArray.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:timerCell = tableView.dequeueReusableCellWithIdentifier("Cell") as! timerCell
        
        cell.lapLabel.text = self.lapUserArray[indexPath.row]
        

        
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        

        

        
        stopBtn.hidden = true
        resetBtn.hidden = true
        lapBtn.opaque = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
