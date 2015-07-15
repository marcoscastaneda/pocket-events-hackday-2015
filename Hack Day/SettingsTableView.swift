//
//  SettingsTableView.swift
//  Hack Day
//
//  Created by Marcos Castaneda on 7/15/15.
//  Copyright (c) 2015 State Farm. All rights reserved.
//

import UIKit
import Parse

class SettingsTableView: UITableViewController {
    
    let user = PFUser.currentUser()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Remove seperators for empty cells
        tableView.tableFooterView = UIView(frame: CGRectZero)
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationItem.title = "Settings"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (indexPath.row == 1)
        {
            self.logOut()
        }
    }
    
    func logOut()
    {
        PFUser.logOutInBackgroundWithBlock { (error: NSError?) -> Void in
            if (error == nil)
            {
                let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Root") as! UIViewController
                
                self.presentViewController(viewController, animated: true, completion: nil)
            }
            else
            {
                print("error")
            }
        }
    }
}
