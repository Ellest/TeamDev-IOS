//
//  TypeVC.swift
//  UniversiTeam
//
//  Created by Jin Seok Park on 2015. 6. 24..
//  Copyright (c) 2015년 Jin Seok Park. All rights reserved.
//

import UIKit

class TypeVC: UIViewController {

    var user = PFUser.currentUser()

    
    @IBAction func coachBtn_click(sender: AnyObject) {
    
        
        if let user = user {
            
            user["Type"] = "Coach"
            user.save()
        }
        
        self.performSegueWithIdentifier("goToCoach2", sender: self)

    }
    
    @IBAction func playerBtn_click(sender: AnyObject) {

        if let user = user {
            
            user["Type"] = "Player"
            user.save()
        }


        self.performSegueWithIdentifier("goToPlayer2", sender: self)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
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
