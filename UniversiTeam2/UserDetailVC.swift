//
//  UserDetailVC.swift
//  UniversiTeam
//
//  Created by Jin Seok Park on 2015. 7. 22..
//  Copyright (c) 2015년 Jin Seok Park. All rights reserved.
//

import UIKit



class UserDetailVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
//    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var resultsTable: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var resultsImageFile:PFFile? = PFFile()
    var selectedPlayersImages:[UIImage?] = [UIImage]()
    
    var sportsLabel:String?
    var schoolLabel:String?
    var regionLabel:String?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = otherProfileName
        
        
        
        
        var query = PFQuery(className: "_User")
        query.whereKey("username", equalTo: selectedPlayersUsername[1])
        
        var objects = query.findObjects()
        
        
        for object in objects! {
            
            var i = 1
            
            println("0")
            while let photo = object["photoLine_\(i)"] as? PFFile {

                self.resultsImageFile = photo
                var imageData:NSData? = self.resultsImageFile!.getData()

                selectedPlayersImages.append(UIImage(data: imageData!))
                
                i += 1
            }
            
            if let sports = object["Sports"] as? String {
                sportsLabel = sports
            }
            if let school = object["School"] as? String {
                schoolLabel = school
            }
            if let region = object["Region"] as? String {
                regionLabel = region
            }
        }        // Do any additional setup after loading the view.
    }
    
        //        self.resultsTable.bounds.width = self.view.bounds.width
        //        self.resultsTable.bounds.height = self.view.bounds.height
        
        // Do any additional setup after loading the view.

    
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return selectedPlayersImages.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        
        var cell:detailCell2 = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! detailCell2
        
        
        
        if selectedPlayersImages.count != indexPath.row {

            println(selectedPlayersImages)
            cell.imageView.image = selectedPlayersImages[indexPath.row]
        }
        
//        cell.backgroundColor = UIColor.blueColor()
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSize(width: self.collectionView.frame.size.height, height: self.collectionView.frame.size.height)
    }

    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        
        
                return UIEdgeInsetsMake(0,0,0,0)
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    

    

    
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(tableView.indexPathForSelectedRow()!, animated: false)
        
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                self.performSegueWithIdentifier("goToToDoVC", sender: self)
            }
            if (indexPath.row == 1) {
                self.performSegueWithIdentifier("goToStopwatchVC", sender: self)
            }
            if (indexPath.row == 2) {
                self.performSegueWithIdentifier("goToWeatherVC", sender: self)
            }
            
        }
        
        if (indexPath.section == 1) {
            if (indexPath.row == 0) {
            }
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell: detailCell = tableView.dequeueReusableCellWithIdentifier("Cell") as! detailCell
        
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                cell.label1.text = "Sports"
                cell.label2.text = sportsLabel
            }
            if (indexPath.row == 1) {
                cell.label1.text = "School"
                cell.label2.text = schoolLabel
            }
            if (indexPath.row == 2) {
                cell.label1.text = "Region"
                cell.label2.text = regionLabel
            }
        }
        
        if (indexPath.section == 1) {
            if (indexPath.row == 0) {
                
                cell.selectionStyle = UITableViewCellSelectionStyle.None;
                
                cell.textLabel!.text = "Add to Interest"
                
                var switchView = UISwitch(frame: CGRectZero)
                switchView.tag = 111
                cell.accessoryView = switchView
                
                switchView.addTarget(self, action: "updateSwitch:", forControlEvents: UIControlEvents.TouchUpInside)
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
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section==0 {
            return 3
        } else {
            return 1
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 2
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (section == 0){
            return "Info"
        } else {
            return "Settings"
        }
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
