//
//  SettingsVC.swift
//  UniversiTeam
//
//  Created by Jin Seok Park on 2015. 6. 17..
//  Copyright (c) 2015년 Jin Seok Park. All rights reserved.
//

import UIKit



class SettingsVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UINavigationControllerDelegate
, UIImagePickerControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {


    @IBOutlet weak var resultsTable: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var resultsImageFile:PFFile? = PFFile()


    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var query = PFQuery(className: "_User")
        query.whereKey("username", equalTo: userName)
        
        var objects = query.findObjects()
        
        for object in objects! {
            
            var i = 1
            
            while let photo = object["photoLine_\(i)"] as? PFFile {
                
                self.resultsImageFile = photo
                var imageData:NSData? = self.resultsImageFile!.getData()
                
                resultsImages.append(UIImage(data: imageData!))
                
                
                i += 1
                
                
            }
        }        // Do any additional setup after loading the view.
    
        //        self.resultsTable.bounds.width = self.view.bounds.width
        //        self.resultsTable.bounds.height = self.view.bounds.height
        
    }
    
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return resultsImages.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        
        var cell:settingsCell2 = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! settingsCell2
        
        ("HI")
        
        if resultsImages.count != indexPath.row {
            
            println(resultsImages)
            cell.imageView.image = resultsImages[indexPath.row]
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

    
    
    
    
    
    
    

//    @IBAction func changePhoto(sender: AnyObject) {
//        
//        var image = UIImagePickerController()
//        image.delegate = self
//        image.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
//        image.allowsEditing = true
//        self.presentViewController(image, animated: true, completion: nil)
//
//    }
//    
//    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
//        
//        profileImageView.image = image
//        self.dismissViewControllerAnimated(true, completion: nil)
//        
//        
//        
//        let imageData = UIImagePNGRepresentation(self.profileImageView.image)
//        let imageFile = PFFile(name: "profile.png", data: imageData)
//        
//        var currentUser = PFUser.currentUser()
//
//        if let user = currentUser {
//
//            user["photo"] = imageFile as PFFile
//        
//            user.saveInBackgroundWithBlock({ (success:Bool, error:NSError?) -> Void in
//            
//                if error == nil {
//                
//                } else {
//                    println(error!.description)
//                }
//        })
//        }
//    }

    
    
    @IBAction func logOutBtn_click(sender: AnyObject) {
        
        PFUser.logOut()

        let vc : AnyObject! = self.storyboard?.instantiateViewControllerWithIdentifier("LoginVC")

//        self.showViewController(vc as! UIViewController, sender: vc)
        
        self.hidesBottomBarWhenPushed = true

        self.view.window?.rootViewController?.dismissViewControllerAnimated(true, completion: { () -> Void in
            
            self.dismissViewControllerAnimated(true, completion: nil)


        })
        
        resultsImages.removeAll(keepCapacity: false)
//        userCells.removeAll(keepCapacity: false)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(tableView.indexPathForSelectedRow()!, animated: false)
        
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                self.performSegueWithIdentifier("goToProfileVC", sender: self)
            }
            if (indexPath.row == 1) {
                self.performSegueWithIdentifier("goToPhotoLineVC", sender: self)
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
        
        var cell: settingsCell = tableView.dequeueReusableCellWithIdentifier("Cell") as! settingsCell
        
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                cell.textLabel!.text = "Update Profile"
            }
            if (indexPath.row == 1) {
                cell.textLabel!.text = "Create PhotoLine"
            }
            if (indexPath.row == 2) {
                cell.textLabel!.text = "Weather"
            }
        }
        
        if (indexPath.section == 1) {
            if (indexPath.row == 0) {
                cell.textLabel!.text = "Recently Unconnected"
                
            }

            if (indexPath.row == 1) {
                
                cell.selectionStyle = UITableViewCellSelectionStyle.None;
                
                cell.textLabel!.text = "Notifications"
            
                var switchView = UISwitch(frame: CGRectZero)
                switchView.tag = 111
                cell.accessoryView = switchView
            
                switchView.addTarget(self, action: "updateSwitch:", forControlEvents: UIControlEvents.TouchUpInside)
            }
        }
        
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator

        
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
        return 45
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section==0 {
            return 2
        } else {
            return 2
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 2
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (section == 0){
            return "Info"
        } else {
            return "Connected"
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
