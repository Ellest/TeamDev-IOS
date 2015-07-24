    //
//  UsersViewController.swift
//  UniversiTeam
//
//  Created by Jin Seok Park on 4/18/15.
//  Copyright (c) 2015 Jin Seok Park. All rights reserved.
//

import UIKit
    
    
    
    var userCells = [ResultCell]()


    var userNameData = [String]()
    var userNameData2 = [String]()
    var userImgData = [UIImage]()
    var userName = ""
    var userName2 = [String]()
    
    var resultsUsernameArray = [String]()
    var resultsProfileNameArray = [String]()
    var resultsImageFiles = [PFFile]()
    
    var connectedUsernameArray = NSArray()
    


class UsersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var resultsTable: UITableView!
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    var refresher: UIRefreshControl!

//    func refresh() {
//        
//        
//        resultsUsernameArray.removeAll(keepCapacity: false)
//        resultsProfileNameArray.removeAll(keepCapacity: false)
//        resultsImageFiles.removeAll(keepCapacity: false)
//
//        
//        let predicate = NSPredicate(format: "username == '"+userName+"'")
//        var query = PFQuery(className: "_User", predicate: predicate)
//        query.addAscendingOrder("firstName")
//
//        var objects = query.findObjects()
//        
//        if objects != nil{
//            for object in objects! {
//            
//                if let objectName = object.username as String!{
//                    resultsUsernameArray.append(objectName)
//                }
//                
//                println(resultsUsernameArray)
//                
//                var first = object["firstName"] as! String
//                var last = object["lastName"] as! String
//                var fullName = "\(first) \(last)"
//                
//                resultsProfileNameArray.append(fullName)
//                resultsImageFiles.append(object["photo"] as! PFFile)
//            
//            self.resultsTable.reloadData()
//            
//            self.refresher.endRefreshing()
//
//            }
//        }
//
//        
//        
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        //side bar
//        
//        if self.revealViewController() != nil {
//            
//            
//            self.menuButton.target = self.revealViewController()
//            self.menuButton.action = Selector("revealToggle:")
//            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
//        }
        
        
        
        let theWidth = view.frame.size.width
        let theHeight = view.frame.size.height
        
        resultsTable.frame = CGRectMake(0, 0, theWidth, theHeight-64)
        
        
//        refresher = UIRefreshControl()
//        refresher.center.x = theWidth/2
////        refresher.attributedTitle = NSAttributedString(string: "Pull to refresh")
//        refresher.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)
//        self.resultsTable.addSubview(refresher)

        
        
        userName = PFUser.currentUser()!.username!
        
        userName2.removeAll(keepCapacity: false)
        userName2.append(PFUser.currentUser()!.username!)
        
        resultsUsernameArray.removeAll(keepCapacity: false)
        resultsProfileNameArray.removeAll(keepCapacity: false)
        resultsImageFiles.removeAll(keepCapacity: false)
        
        selectedPlayersUsername.removeAllObjects()
        
        
        for var i=0; i<connectedUsernameArray.count; i++ {
            var query = PFQuery(className: "_User")
            query.whereKey("username", equalTo: connectedUsernameArray[i])
            query.addAscendingOrder("firstName")
            var objects = query.findObjects()
            
            for object in objects! {
                
                if let obejctName = object.username as String! {
                    resultsUsernameArray.append(obejctName)
                    
                    
                }
                var first = object["firstName"] as! String
                var last = object["lastName"] as! String
                var fullName = "\(first) \(last)"
                
                resultsProfileNameArray.append(fullName)
                resultsImageFiles.append(object["photo"] as! PFFile)

            }
        }
                self.resultsTable.reloadData()
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        var cell = tableView.cellForRowAtIndexPath(indexPath) as! ResultCell
        
        
        
        selectedPlayersUsername.removeAllObjects()
        
        selectedPlayersUsername.addObject(userName)
        selectedPlayersUsername.addObject(cell.userNameLabel.text!)
        println(selectedPlayersUsername)
        otherProfileName = cell.profileNameLabel.text!
        
        self.performSegueWithIdentifier("goToUserDetailVC", sender: self)
        
        
        
        self.resultsTable.reloadData()

    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultsUsernameArray.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        

        var cell:ResultCell = tableView.dequeueReusableCellWithIdentifier("Cell") as! ResultCell
        
        cell.userNameLabel.text = resultsUsernameArray[indexPath.row]
        cell.profileNameLabel.text = resultsProfileNameArray[indexPath.row]
        
        userNameData.append(resultsProfileNameArray[indexPath.row])
        userNameData2.append(resultsUsernameArray[indexPath.row])

        
        resultsImageFiles[indexPath.row].getDataInBackgroundWithBlock {
            (imageData: NSData?, error: NSError?) -> Void in
            
            if error == nil {
                
                let image = UIImage(data: imageData!)
                cell.profileImg.image = image
                
                userImgData.append(image!)
                
                userCells.append(cell)

            }
        }
        
        return cell

    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
            return 48
    }
    
    
    
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
        
        let remove = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Remove") { action, index in
            println("favorite button tapped")
        }
        remove.backgroundColor = UIColor.orangeColor()
        
        
        return [remove]
    }
    
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        // you need to implement this method too or you can't swipe to display the actions
    }

    
    @IBAction func addPlayer(sender: AnyObject) {
        
        
    
    }
    
    @IBAction func logoutBtn_click(sender: AnyObject) {
        
        PFUser.logOut()
        self.navigationController?.popToRootViewControllerAnimated(true)
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
    

