//
//  DiscoverTableView.swift
//  Hack Day
//
//  Created by Marcos Castaneda on 7/15/15.
//  Copyright (c) 2015 State Farm. All rights reserved.
//

import UIKit
import Parse

class DiscoverTableView: UITableViewController {
    
    var isOnFeatured = true
    
    @IBOutlet var barButtonFilter: UIBarButtonItem!
    
    // Hold all the events
    var events: [PFObject]?
    
    var trendingEvents = [PFObject]()
    var recommendedEvents: [PFObject]?
    var upcomingEvents: [PFObject]?
    
    @IBAction func eventsChanged(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0
        {
            self.navigationItem.setLeftBarButtonItem(nil, animated: true)
            
            isOnFeatured = true
            //            print(isOnFeatured)
            self.tableView.reloadData()
        }
        else
        {
            isOnFeatured = false
            
            self.barButtonFilter.tintColor = UIColor.whiteColor()
            self.navigationItem.setLeftBarButtonItem(self.barButtonFilter, animated: true)
            self.tableView.reloadData()
            //            print(isOnFeatured)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.queryEvents()
        
        if (self.isOnFeatured)
        {
            self.navigationItem.setLeftBarButtonItem(nil, animated: true)
        }
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl!.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(self.refreshControl!)
        
        // Remove seperators for empty cells
        tableView.tableFooterView = UIView(frame: CGRectZero)
        
        // Remove back button text
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
    }
    
    func refresh(sender:AnyObject)
    {
        self.queryEvents()
        
        self.refreshControl?.endRefreshing()
    }
    
    func queryEvents()
    {
        let loadingNotification = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.Indeterminate
        loadingNotification.labelFont = GlobalStyles.Fonts.headerMainFont
        loadingNotification.labelText = "Loading"
        
        // Load ALL tasks
        var query = PFQuery(className:"Events")
        query.orderByDescending("dateAt")
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                
                if let objects = objects as? [PFObject] {
                    self.events = objects
                    
                    //                    Failed algorithm
                    var objectArray: NSArray = NSArray(array: objects)
                    var descriptor: NSSortDescriptor = NSSortDescriptor(key: "attendanceCount", ascending: false)
                    var sortedResults: NSArray = objectArray.sortedArrayUsingDescriptors([descriptor])
                    
                    self.trendingEvents.removeAll(keepCapacity: false)
                    
                    for object in sortedResults {
                        var theCount = (object["attendanceCount"] as! NSNumber).integerValue
                        
                        // Logic for trending
                        if (theCount > 30 && self.trendingEvents.count < 3)
                        {
                            self.trendingEvents.append(object as! PFObject)
                        }
                    }
                    
                    self.tableView.reloadData()
                    loadingNotification.hide(true)
                }
            } else {
                // Log details of the failure
                println("Error: \(error!) \(error!.userInfo!)")
            }
        }
    }
    
    func getCategory(category: String) -> String
    {
        switch category
        {
        case "sports":
            return "⚽️ Sports"
        case "entertainment":
            return "🎤 Entertainment"
        case "food":
            return "🍴 Food/Drink"
        case "charity":
            return "🌈 Charity"
        case "networking":
            return "💬 Networking"
        default:
            return ""
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        // Trending / Recommended Upcoming
        if (isOnFeatured == true)
        {
            return 3
        }
        else
        {
            return 1
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        if (events == nil)
        {
            return 0
        }
        
        if (trendingEvents.isEmpty)
        {
            return 0
        }
        
        if (isOnFeatured == true)
        {
            if (section == 0)
            {
                return self.trendingEvents.count
            }
        }
        else {
            return events!.count
        }
        
        return 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("eventCell", forIndexPath: indexPath) as! EventCell
        
        var eventObject: PFObject?
        
        if (isOnFeatured)
        {
            if (indexPath.section == 0)
            {
                eventObject = self.trendingEvents[indexPath.row]
            }
            else
            {
                eventObject = self.events![indexPath.row]
            }
        }
        else
        {
            eventObject = self.events![indexPath.row]
        }
        
        var todayDate = NSDate()
        
        cell.labelEventTitle.text = eventObject!["title"] as? String
        
        if (NSDate.areDatesSameDay(todayDate, dateTwo: eventObject!["dateStart"] as! NSDate))
        {
            var formatter = NSDateFormatter();
            formatter.dateFormat = "'Today', hh:mm a";
            let defaultTimeZoneStr = formatter.stringFromDate((eventObject!["dateStart"] as!NSDate));
            
            cell.labelEventTime.text = defaultTimeZoneStr
        }
        else
        {
            var formatter = NSDateFormatter();
            formatter.dateFormat = "MMMM d, hh:mm a";
            let defaultTimeZoneStr = formatter.stringFromDate((eventObject!["dateStart"] as!NSDate));
            
            cell.labelEventTime.text = defaultTimeZoneStr
        }
        
        cell.labelEventCategory.text = getCategory(eventObject!["category"] as! String)
        cell.labelEventVenue.text = eventObject!["venue"] as? String
        
        let attendanceCount = (eventObject!["attendanceCount"] as? NSNumber)!.intValue
        
        if (attendanceCount > 30)
        {
            cell.labelEventCount.text = "🔥 \(attendanceCount)"
        }
        else
        {
            cell.labelEventCount.text = "\(attendanceCount)"
        }
        
        // "2014-07-23 11:01:35 -0700" <-- same date, local, but with seconds
        //
        // Configure the cell...
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("detailEvent", sender: nil)
        print("pressed")
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (isOnFeatured && section == 0)
        {
            return "Trending"
        }
        
        return nil
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the specified item to be editable.
    return true
    }
    */
    
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
    // Delete the row from the data source
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    }
    */
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the item to be re-orderable.
    return true
    }
    */
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    }
    */
    
}
