//
//  PhotoLineVC.swift
//  UniversiTeam2
//
//  Created by Jin Seok Park on 2015. 7. 22..
//  Copyright (c) 2015년 Jin Seok Park. All rights reserved.
//

import UIKit

var resultsImages:[UIImage?] = [UIImage]()


class PhotoLineVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UINavigationControllerDelegate
, UIImagePickerControllerDelegate {

    
    @IBOutlet weak var collectionView: UICollectionView!

    
    var resultsImageFile:PFFile? = PFFile()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if resultsImages.count == 0 {
        
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
    }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func exitBtn_click(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if resultsImages.count >= 8 {
            return resultsImages.count
        } else {
            return resultsImages.count + 1
        }    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {

        
        var cell:photoCell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! photoCell

        
        if resultsImages.count == indexPath.row  {
            cell.plusSign.hidden = false
        } else {
            cell.plusSign.hidden = true
            
            cell.imageView.image = resultsImages[indexPath.row]
        }
        
        
        
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSize(width: self.view.frame.size.width/2-8, height: self.view.frame.size.width/2-8)
    }
    
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        
        if section==0 {
            return UIEdgeInsetsMake(50,3,3,3);

        } else {
            return UIEdgeInsetsMake(3,3,3,3);
        }
        
        
//        return UIEdgeInsetsMake(5, 5, 5, 5);

        //        return sectionInsets
    }
    
    
    
    func collectionView(collectionView: UICollectionView, didHighlightItemAtIndexPath indexPath: NSIndexPath) {
        
        var cell = collectionView.cellForItemAtIndexPath(indexPath)
        
//        if indexPath.section==0 {
//            if indexPath.row==0 {number=1}
//            if indexPath.row==1 {number=2}
//        }
//        if indexPath.section==1 {
//            if indexPath.row==0 {number=3}
//            if indexPath.row==1 {number=4}
//        }
        println(indexPath.row)
        
        changePhoto()
        
//        if cell?.backgroundColor == UIColor.yellowColor(){
//            cell?.backgroundColor = UIColor.blueColor()
//        } else {
//            cell?.backgroundColor = UIColor.yellowColor()
//        }
    }
    
    func changePhoto() {
        
        var image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        image.allowsEditing = true
        self.presentViewController(image, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
        
        
        let imageData = UIImagePNGRepresentation(image)
        let imageFile = PFFile(name: "photoLine_\(resultsImages.count+1).png", data: imageData)

        var currentUser = PFUser.currentUser()
        
        if let user = currentUser {

            user["photoLine_\(resultsImages.count+1)"] = imageFile as PFFile
            
            user.saveInBackgroundWithBlock({ (success:Bool, error:NSError?) -> Void in
                
                if error == nil {
                    
                }
            })
            
        }
        
        resultsImages.append(image)
        
        self.collectionView.reloadData()
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
