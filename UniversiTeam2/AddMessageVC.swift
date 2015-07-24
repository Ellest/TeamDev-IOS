//
//  AddMessageVC.swift
//  UniversiTeam
//
//  Created by Jin Seok Park on 2015. 6. 13..
//  Copyright (c) 2015년 Jin Seok Park. All rights reserved.
//

import UIKit

var selectedPlayersProfileName = NSMutableArray()
var selectedPlayersUsername = NSMutableArray()

var totalCells = [UserCell]()


class AddMessageVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchDisplayDelegate, UISearchControllerDelegate {

    @IBOutlet weak var chosenUsersView: UIScrollView!
//    @IBOutlet weak var chosenUserEmail: UILabel!
    @IBOutlet weak var resultsTable: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var selectedView: UIView!
    @IBOutlet weak var createBtn: UIBarButtonItem!
    
    @IBAction func cancelBtn_click(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    @IBAction func createBtn_click(sender: AnyObject) {
        
//        otherProfileName = cell.nameLbl.text!
        selectedPlayersUsername.removeAllObjects()

        for var i=0; i<self.chosenUserNames.count; i++ {
            selectedPlayersUsername[i] = self.chosenUserNames[i] as! String
        }
        
        selectedPlayersUsername.addObject(userName)

        let vc : AnyObject! = self.storyboard?.instantiateViewControllerWithIdentifier("ConversationVC")
        
                self.showViewController(vc as! UIViewController, sender: vc)
        
        


//        self.performSegueWithIdentifier("goToConversationVC_AddMessageVC", sender: self)
        
        
        
    }
    
    var chosen:Bool = false
    var searchActive:Bool = false
    var searchResults = [ResultCell]?()
    var resultSearchController = UISearchController()
    
    var chosenUserNames = NSMutableArray()
    var userNames = [String]()

    
    var times = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectedPlayersUsername.removeAllObjects()
        totalCells.removeAll(keepCapacity: false)
        
        chosenUsersView.hidden = true
        createBtn.enabled = false
        
        
        self.chosenUserNames.removeAllObjects()
        
        
        self.resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)

            controller.dimsBackgroundDuringPresentation = false
            controller.active = true
            controller.hidesNavigationBarDuringPresentation = false
            
            return controller
        })()
        
        self.resultSearchController.active = true


        self.resultsTable.reloadData()
        

        
        // Do any additional setup after loading the view.
    }
    
    
    
    func presentSearchController(searchController: UISearchController) {
        self.presentSearchController(searchController)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //search bar
    func filterContentForSearchText(searchText: String) {
        
        if userNameData.count == 0 {
            self.searchResults = nil
            return
        }

        self.searchResults = userCells.filter({ (cell: ResultCell) -> Bool in
            
            return cell.profileNameLabel!.text?.lowercaseString.rangeOfString(searchText.lowercaseString) != nil
        })
    }
    
    
    func searchDisplayController(controller: UISearchDisplayController, shouldReloadTableForSearchString searchString: String!) -> Bool {
        
        self.filterContentForSearchText(searchString)
        
        return true
    }
    

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == self.searchDisplayController!.searchResultsTableView {
            return self.searchResults?.count ?? 0
        } else {
            return userNameData.count ?? 0
        }
    }

    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        var cell = self.resultsTable!.dequeueReusableCellWithIdentifier("Cell") as! UserCell
        
        var arrayOfUsers = [ResultCell]()
        
        
        if tableView != self.searchDisplayController!.searchResultsTableView {
            
            self.resultsTable.reloadInputViews()
        }

        
        if tableView == self.searchDisplayController!.searchResultsTableView {
            arrayOfUsers = self.searchResults!
        } else {
            arrayOfUsers = userCells
        }
        
        
//        if tableView == (self.resultSearchController.active) {
//            arrayOfUsers = userNameData
//        } else if let user = self.searchResults?.count {
//            arrayOfUsers =  self.searchResults!
//        }
        
        var isfound = false

        
        if arrayOfUsers.count > indexPath.row {
            
            let users = arrayOfUsers[indexPath.row]
            
            
            if totalCells.isEmpty {
            
            } else {
                for var i=0; i<totalCells.count; i++ {
                
                    if users.userNameLabel.text == totalCells[i].userNameLabel2.text {
                    
                        cell = totalCells[i]
                        isfound = true
                    }
                }
            }
            
            if isfound == false {
                
                println("TEXT  IS ::: \(users.userNameLabel.text)")
                cell.userNameLabel2.text = users.userNameLabel.text
                cell.profileImg2.image = users.profileImg.image
                println("NAME  IS ::: \(users.profileNameLabel.text)")
                
                cell.profileNameLabel2.text = users.profileNameLabel.text
                cell.textLabel!.text = cell.profileNameLabel2.text
                
                println("CELLNAME  IS ::: \(cell.textLabel!.text)")
            
                
                
            }

        } else {
        

        cell.userNameLabel2.text = userNameData2[indexPath.row]
        cell.profileNameLabel2.text = userNameData[indexPath.row]
        cell.profileImg2.image = userImgData[indexPath.row]
        cell.textLabel!.text = cell.profileNameLabel2.text



        }
        
//        for var i=0; i<self.chosenUserNames.count; i++ {
//            if cell.textLabel!.text! == self.chosenUserNames[i] as! String {
//                cell.accessoryType = UITableViewCellAccessoryType.Checkmark
//            } else {
//                cell.accessoryType = UITableViewCellAccessoryType.None
//            }
//        }
        
        if isfound == false {
        
        cell.textLabel!.hidden = true
        userNames.append(cell.textLabel!.text!)
        
        totalCells.append(cell)
        }
        
        println("CELL : \(cell)")
        
        times += 1
        println("\(times) : YOYO")
        
        return cell
    }





    
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 48
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath newIndexPath: NSIndexPath) {
        

        tableView.deselectRowAtIndexPath(tableView.indexPathForSelectedRow()!, animated: false)
        
        var cell = tableView.cellForRowAtIndexPath(newIndexPath) as! UserCell
        
        
        if (cell.accessoryType == UITableViewCellAccessoryType.None) {
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            cell.chosenCell = true
            // Reflect selection in data model
            
            
            if let chosenUser = cell.userNameLabel2.text {
                
                self.chosenUserNames.addObject(chosenUser)

                
            }
            
        } else if (cell.accessoryType == UITableViewCellAccessoryType.Checkmark) {
            cell.accessoryType = UITableViewCellAccessoryType.None
            cell.chosenCell = false
            // Reflect deselection in data model
                
                for var i=0; i<self.chosenUserNames.count; i++ {
                    
                    if cell.userNameLabel2.text == self.chosenUserNames[i] as? String {
                        
                        self.chosenUserNames.removeObjectAtIndex(i)

                    }
                }
                
        }
        
        if self.chosenUserNames.count == 0 {
            createBtn.enabled = false
        } else {
            createBtn.enabled = true
        }

        println(self.chosenUserNames)

        
//        var exist = false
//        reorder()

//        if let chosenUser = cell.textLabel!.text {
//            
//            //if no-one is chosen yet
//            if self.chosenUserNames.count == 0 {
//                self.chosenUserNames.addObject(chosenUser)
//                
//                //add username/profilename
//                for var i=0; i<resultsProfileNameArray.count; i++ {
//                    if chosenUser == resultsProfileNameArray[i] {
//                        selectedPlayersUsername.addObject(resultsUsernameArray[i])
//                        selectedPlayersProfileName.addObject(resultsProfileNameArray[i])
//                        println(selectedPlayersProfileName)
//                    }
//                }
//                
//            }
//            
//            //if someone is chosen
//            else {
//                for var i=0; i<self.chosenUserNames.count; i++ {
//                    if self.chosenUserNames[i] as! String == cell.textLabel!.text! {
//                        exist = true
//                        self.chosenUserNames.removeObjectAtIndex(i)
//                        selectedPlayersUsername.removeObjectAtIndex(i)
//                    }
//                }
//                if exist == false {
//                    self.chosenUserNames.addObject(chosenUser)
//                    
//                    //add username
//                    for var i=0; i<resultsProfileNameArray.count; i++ {
//                        if chosenUser == resultsProfileNameArray[i] {
//                            selectedPlayersUsername.addObject(resultsUsernameArray[i])
//                        }
//                    }
//                }
//            }
//        }
//        
//        
//        if self.chosenUserNames.count > 0 {
//                for var i=0; i<self.chosenUserNames.count; i++ {
////                    print(self.chosenUserNames[i])
////                    print(selectedPlayersUsername[i])
//            }
////            println()
//        }
//        
//        }
    }
    
//    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
//        
//        tableView.deselectRowAtIndexPath(tableView.indexPathForSelectedRow()!, animated: false)
//
//        
//        var cell:UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
//
//        println("hi")
//        
//        
//        
//        if (cell.accessoryType == UITableViewCellAccessoryType.None) {
//            cell.accessoryType = UITableViewCellAccessoryType.Checkmark;
//            // Reflect selection in data model
//        } else if (cell.accessoryType == UITableViewCellAccessoryType.Checkmark) {
//            cell.accessoryType = UITableViewCellAccessoryType.None;
//            // Reflect deselection in data model
//        }
//
//
//        }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
