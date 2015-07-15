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
    
    let user = PFUser.currentUser()!

    @IBOutlet weak var imageViewUser: UIImageView!
    
    @IBOutlet weak var labelName: UILabel!
    
    @IBOutlet weak var labelAlias: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Remove seperators for empty cells
        tableView.tableFooterView = UIView(frame: CGRectZero)
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationItem.title = "Settings"
        self.labelName.text = user.objectForKey("name") as? String
        self.labelAlias.text = (user["username"] as? String)?.uppercaseString
        
        let userImageFile = self.user["picture"] as? PFFile
        
        self.imageViewUser.layer.cornerRadius = self.imageViewUser.frame.size.height/2
        self.imageViewUser.layer.masksToBounds = true
        
        if userImageFile != nil {
            userImageFile!.getDataInBackgroundWithBlock {
                (imageData: NSData?, error: NSError?) -> Void in
                if error == nil {
                    if let imageData = imageData {
                        let image = UIImage(data:imageData)
                        self.imageViewUser.image = image
                        }
                }
                
            }
  
        }
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
