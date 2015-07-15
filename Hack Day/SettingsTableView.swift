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
    @IBOutlet weak var labelTitle: UILabel!

    @IBOutlet weak var cellUser: UITableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Remove seperators for empty cells
        tableView.tableFooterView = UIView(frame: CGRectZero)
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationItem.title = "Settings"
        self.labelName.text = user.objectForKey("name") as? String
        self.labelTitle.text = user["jobTitle"] as? String
        
        let userImageFile = self.user["picture"] as? PFFile
        
        self.imageViewUser.layer.cornerRadius = self.imageViewUser.frame.size.height/2
        self.imageViewUser.layer.masksToBounds = true
        
        if userImageFile != nil {
            userImageFile!.getDataInBackgroundWithBlock {
                (imageData: NSData?, error: NSError?) -> Void in
                if error == nil {
                    if let imageData = imageData {
                        let image = UIImage(data:imageData)
                        
                        // Set circle image as image
                        self.imageViewUser.image = image
                        
                        self.imageViewUser.layer.borderWidth = 1.2
                        self.imageViewUser.layer.borderColor = UIColor.whiteColor().CGColor
                        
                        var cellBackground = UIImageView(image: image!.applyDarkEffect())
                        cellBackground.contentMode = UIViewContentMode.ScaleAspectFill
                        cellBackground.clipsToBounds = true
                        self.cellUser.backgroundView = cellBackground
                        
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
