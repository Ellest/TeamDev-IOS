//
//  SignUpViewController.swift
//  UniversiTeam
//
//  Created by Jin Seok Park on 4/16/15.
//  Copyright (c) 2015 Jin Seok Park. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UINavigationControllerDelegate
, UIImagePickerControllerDelegate, UITextFieldDelegate {

    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var passwordReTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let theWidth = view.frame.size.width
        
        profileImageView.center = CGPointMake(theWidth/2, 140)
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width/2
        profileImageView.clipsToBounds = true
        


        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addPhotoBtn_click(sender: AnyObject){
        var image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        image.allowsEditing = true
        self.presentViewController(image, animated: true, completion: nil)
        
    }

    @IBAction func signupBtn_click(sender: AnyObject) {
        

        
        
        
        var user = PFUser()
        user.username = usernameTextField.text
        user.password = passwordTextField.text
        user.email = usernameTextField.text
        user["firstName"] = firstNameTextField.text
        user["lastName"] = lastNameTextField.text

        
        let imageData = UIImagePNGRepresentation(self.profileImageView.image)
        let imageFile = PFFile(name: "profile1.png", data: imageData)
        user["photo"] = imageFile
        

        user.signUpInBackgroundWithBlock
            { (succeeded:Bool, signUpError:NSError?) -> Void in
                
                if (self.passwordTextField.text != self.passwordReTextField.text) {
                    var alert = UIAlertView(title: "Error", message: "Password does not match", delegate: self, cancelButtonTitle: "OK")
                    alert.show()
                }
                    
                    
                
                else {
                    if signUpError == nil {
                        var alert = UIAlertView(title: "Congratulations!", message: "Sign Up Successful", delegate: self, cancelButtonTitle: "OK")
                        alert.show()

                        //installation
                        var installation:PFInstallation = PFInstallation.currentInstallation()
                        installation["user"] = PFUser.currentUser()
                        installation.saveInBackgroundWithBlock{ (succeeded:Bool, error:NSError?) -> Void in
                            
                            if succeeded == true {
                                println("success")
                            } else {
                                println("There is a certain \(error!.description)")
                            }
                            
                        }

                        
                        self.performSegueWithIdentifier("showTypeVC", sender: self)

                    }
                }
                
        }
        

    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        
        profileImageView.image = image
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    
    
    
    func textFieldDidBeginEditing(textField: UITextField) {
        
        let theWidth = view.frame.size.width
        let theHeight = view.frame.size.height
        
        if (UIScreen.mainScreen().bounds.height == 568) {
            
            if (textField == self.usernameTextField) {
                
                UIView.animateWithDuration(0.3, delay: 0, options: .CurveLinear, animations: {
                    
                    self.view.center = CGPointMake(theWidth/2, theHeight/2 - 40)
                    
                    }, completion: {
                        (finished:Bool) in
                })
            }
        }
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        
        let theWidth = view.frame.size.width
        let theHeight = view.frame.size.height
        
        if (UIScreen.mainScreen().bounds.height == 568) {
            
            if (textField == self.usernameTextField) {
                
                UIView.animateWithDuration(0.3, delay: 0, options: .CurveLinear, animations: {
                    
                    self.view.center = CGPointMake(theWidth/2, theHeight/2)
                    
                    }, completion: {
                        (finished:Bool) in
                })
            }
        }

    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        usernameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        firstNameTextField.resignFirstResponder()
        lastNameTextField.resignFirstResponder()
        passwordReTextField.resignFirstResponder()
        return true
    }

    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    

}

