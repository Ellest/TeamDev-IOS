//
//  MakeTeamVC.swift
//  UniversiTeam
//
//  Created by Jin Seok Park on 2015. 6. 26..
//  Copyright (c) 2015년 Jin Seok Park. All rights reserved.
//

import UIKit

class MakeTeamVC: UIViewController {

    
    @IBOutlet weak var teamNameLabel: UITextField!
    @IBOutlet weak var schoolNameLabel: UITextField!
    
    
    
    var currentUser = PFUser.currentUser()
    
    
    @IBAction func saveBtn_click(sender: AnyObject) {
        
        if let user = currentUser {

            user["teamName"] = teamNameLabel.text
            
            user.save()
            
            self.dismissViewControllerAnimated(true, completion: nil)

            self.performSegueWithIdentifier("returnMainPageVC", sender: self)
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        teamNameLabel.resignFirstResponder()
        schoolNameLabel.resignFirstResponder()
        return true
    }
    
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true)
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
