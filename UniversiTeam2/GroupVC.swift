//
//  GroupVC.swift
//  UniversiTeam
//
//  Created by Jin Seok Park on 2015. 6. 7..
//  Copyright (c) 2015년 Jin Seok Park. All rights reserved.
//

import UIKit

var resultsTeamName:NSArray = NSArray()
var resultsTeamPhoto:[UIImage?] = [UIImage]()

class GroupVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    //    let sectionInsets = UIEdgeInsets(top: 30.0, left: 60.0, bottom: 30.0, right: 60.0)
    
    var SMEPGiPadViewControllerCellWidth:CGFloat = 120;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if resultsImages.count == 0 {
            
            var query = PFQuery(className: "_User")
            query.whereKey("username", equalTo: userName)
            
            var objects = query.findObjects()
            
            for object in objects! {
                
                if let teamArray = object["team"] as? NSArray {
                    
                    resultsTeamName = teamArray
                    println(resultsTeamName)
                }
            }
        }// Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return resultsTeamName.count + 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell:groupCell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! groupCell
        
        
        if resultsTeamName.count == indexPath.row  {
            cell.plusSign.hidden = false
            cell.textLabel.text = "Create Team"
            cell.imageView.hidden = true
        } else {
            cell.plusSign.hidden = true
            
            
//            cell.imageView.image = resultsImages[indexPath.row]
            cell.textLabel.text = resultsTeamName[indexPath.row] as? String
        }

        
//        cell.layer.cornerRadius = cell.frame.size.height/2
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSize(width: 120, height: 120)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 50
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        
//        var top = self.view.frame.size.height / 2 - 120
//        var left = (self.view.frame.size.width - (3*120)) / (3+1)
//        
//        return UIEdgeInsetsMake(top, left, top, left);
        
        return UIEdgeInsetsMake(50,50,50,50);

    }
    
    func collectionView(collectionView: UICollectionView, didHighlightItemAtIndexPath indexPath: NSIndexPath) {
        
        var cell = collectionView.cellForItemAtIndexPath(indexPath)
        
        
        
//        if cell?.backgroundColor == UIColor.yellowColor(){
//            cell?.backgroundColor = UIColor.blueColor()
//        } else {
//            cell?.backgroundColor = UIColor.yellowColor()
//        }
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
