
//
//  MainPagePlayerVC.swift
//  UniversiTeam
//
//  Created by Jin Seok Park on 2015. 6. 26..
//  Copyright (c) 2015년 Jin Seok Park. All rights reserved.
//

import UIKit



class MainPagePlayerVC: UIViewController {

    @IBOutlet var logout_Btn: UIBarButtonItem!
    
    @IBOutlet var welcomeLabel: UILabel!

    @IBAction func logout_Btn(sender: AnyObject) {
        
        PFUser.logOut()
        self.navigationController?.popToRootViewControllerAnimated(true)
        
        self.dismissViewControllerAnimated(true, completion: nil)

        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.hidesBackButton = true
        
        var queryF = PFUser.query()
        queryF!.whereKey("username", equalTo: PFUser.currentUser()!.username!)
        
        var objects = queryF!.findObjects()
        
        
        for object in objects! {
            
            var string1 = object.objectForKey("firstName") as! String
            var string2 = object.objectForKey("lastName") as! String
            
            welcomeLabel.text = "Welcome, \(string1) \(string2)"
            
        }

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
