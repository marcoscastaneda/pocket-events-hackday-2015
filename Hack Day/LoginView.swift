//
//  LoginView.swift
//  Hack Day
//
//  Created by Marcos Castaneda on 7/15/15.
//  Copyright (c) 2015 State Farm. All rights reserved.
//

import UIKit
import Parse

class LoginView: UITableViewController {
    
    @IBOutlet weak var textFieldAlias: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    
    override func viewWillAppear(animated: Bool) {
        self.title = "State Farm"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Remove seperators for empty cells
        tableView.tableFooterView = UIView(frame: CGRectZero)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewDidAppear(animated: Bool) {
        self.textFieldAlias.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginUser(sender: AnyObject) {
        let loadingNotification = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.Indeterminate
        loadingNotification.labelFont = GlobalStyles.Fonts.headerMainFont
        loadingNotification.labelText = "Loading"
        
        PFUser.logInWithUsernameInBackground(self.textFieldAlias.text.lowercaseString, password: self.textFieldPassword.text) {
            (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                // Do stuff after successful login.
                
                loadingNotification.hide(true)
                
                self.performSegueWithIdentifier("loginSuccess", sender: self)
                
                
            } else {
                // The login failed. Check error to see why.
                let alert = UIAlertView.new()
                alert.title = "Failed login"
                alert.addButtonWithTitle("Okay")
                alert.show()
            }
        }
    }
    

}