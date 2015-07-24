//
//  PopUpVC.swift
//  UniversiTeam2
//
//  Created by Jin Seok Park on 2015. 7. 21..
//  Copyright (c) 2015년 Jin Seok Park. All rights reserved.
//

import UIKit

class PopUpVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
//    let sectionInsets = UIEdgeInsets(top: 30.0, left: 60.0, bottom: 30.0, right: 60.0)

    var SMEPGiPadViewControllerCellWidth:CGFloat = 80;

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.ba
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell:popupCell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! popupCell
        cell.backgroundColor = UIColor.yellowColor()
        
        
        
        
        if indexPath.row==0 {cell.textLabel!.text = "Photo"}
        if indexPath.row==1 {cell.textLabel!.text = "Camera"}
        if indexPath.row==2 {cell.textLabel!.text = "Schedule"}

        
        cell.layer.cornerRadius = cell.frame.size.height/2
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSize(width: 80, height: 80)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        
        var numberOfCells = self.view.frame.size.width / SMEPGiPadViewControllerCellWidth;
        var edgeInsets = (self.view.frame.size.width - (numberOfCells * SMEPGiPadViewControllerCellWidth)) / (numberOfCells + 1);
        
        var top = self.view.frame.size.height / 2 - 80
        var left = (self.view.frame.size.width - (3*80)) / (3+1)
        
        return UIEdgeInsetsMake(top, left, top, left);

//        return sectionInsets
    }
    
    func collectionView(collectionView: UICollectionView, didHighlightItemAtIndexPath indexPath: NSIndexPath) {
        
        var cell = collectionView.cellForItemAtIndexPath(indexPath)
        
        
//        if indexPath.row==0 {self.performSegueWithIdentifier("goToPhotoVC", sender: self)}
//        if indexPath.row==1 {self.performSegueWithIdentifier("goToCameraVC", sender: self)}
//        if indexPath.row==2 {self.performSegueWithIdentifier("goToScheduleVC", sender: self)}

        if cell?.backgroundColor == UIColor.yellowColor(){
            cell?.backgroundColor = UIColor.blueColor()
        } else {
            cell?.backgroundColor = UIColor.yellowColor()
        }
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
