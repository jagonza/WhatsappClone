//
//  ViewController.swift
//
//  Copyright 2011-present Parse Inc. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {
    
    
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        if PFUser.currentUser() != nil {
            performSegueWithIdentifier("showLoggedInViewController", sender: self)
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func singUpButtonPressed() {
        
        resignFirstResponder()
        
        var user = PFUser()
        user.username = userTextField.text
        user.password = passwordTextField.text
        user.email = emailTextField.text
        
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool, error: NSError?) -> Void in
            if let error = error {
                let errorString = error.userInfo?["error"] as? String
                self.resultLabel.text = errorString
            } else {
                
                PFUser.logInWithUsernameInBackground(self.userTextField.text, password:self.passwordTextField.text) {
                    (user: PFUser?, error: NSError?) -> Void in
                    if user != nil {
                        self.performSegueWithIdentifier("showLoggedInViewController", sender: self)
                    } else {
                        let errorString = error!.userInfo?["error"] as? String
                        self.resultLabel.text = errorString
                    }
                }
                
            }
        }
        
    }

}

