//
//  DiscoverTableView.swift
//  Hack Day
//
//  Created by Marcos Castaneda on 7/15/15.
//  Copyright (c) 2015 State Farm. All rights reserved.
//

import UIKit
import Parse

class DiscoverTableView: UITableViewController, UISearchBarDelegate {
    
    var isOnFeatured = true
    
<<<<<<< HEAD
    @IBOutlet weak var searchBarTable: UISearchBar!
=======
>>>>>>> origin/master
    @IBOutlet var barButtonFilter: UIBarButtonItem!
    
    // Hold all the events
    var events: [PFObject]?
<<<<<<< HEAD
    
    var trendingEvents = [PFObject]()
    var recommendedEvents = [PFObject]()
    var upcomingEvents: [PFObject]?
    
=======

    var trendingEvents = [PFObject]()
    var recommendedEvents: [PFObject]?
    var upcomingEvents: [PFObject]?

>>>>>>> origin/master
    @IBAction func eventsChanged(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0
        {
            self.navigationItem.setLeftBarButtonItem(nil, animated: true)
            
            isOnFeatured = true
<<<<<<< HEAD
            //            print(isOnFeatured)
=======
//            print(isOnFeatured)
>>>>>>> origin/master
            self.tableView.reloadData()
        }
        else
        {
            isOnFeatured = false
            
            self.barButtonFilter.tintColor = UIColor.whiteColor()
            self.navigationItem.setLeftBarButtonItem(self.barButtonFilter, animated: true)
            self.tableView.reloadData()
<<<<<<< HEAD
            //            print(isOnFeatured)
=======
//            print(isOnFeatured)
>>>>>>> origin/master
        }
    }
    
    override func viewWillAppear(animated: Bool) {
<<<<<<< HEAD
        self.tableView.contentOffset = CGPointMake(0, self.searchBarTable.frame.size.height);
=======

>>>>>>> origin/master
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
<<<<<<< HEAD
        query.orderByAscending("dateStart")
=======
        query.orderByDescending("dateAt")
>>>>>>> origin/master
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
                    
                    //                    Failed algorithm
                    var objectArray: NSArray = NSArray(array: objects)
                    var descriptor: NSSortDescriptor = NSSortDescriptor(key: "attendanceCount", ascending: false)
                    var sortedResults: NSArray = objectArray.sortedArrayUsingDescriptors([descriptor])
                    
                    self.trendingEvents.removeAll(keepCapacity: false)
                    self.recommendedEvents.removeAll(keepCapacity: false)
                    
                    for object in sortedResults {
                        var theCount = (object["attendanceCount"] as! NSNumber).integerValue
                        
                        if ((object["category"] as! String) == "sports")
                        {
                            self.recommendedEvents.append(object as! PFObject)
                        }
                        
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
<<<<<<< HEAD
        case "sports":
            return "⚽️ Sports"
        case "entertainment":
            return "🎤 Entertainment"
        case "food":
            return "🍴 Food/Drink"
        case "charity":
            return "🌎 Charity"
        case "networking":
            return "💬 Networking"
        case "social":
            return "😃 Social"
=======
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
>>>>>>> origin/master
        default:
            return ""
        }
    }
<<<<<<< HEAD
    
=======

>>>>>>> origin/master
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
    
    override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView //recast your view as a UITableViewHeaderFooterView
        let color = UIColor(red: 90/255, green: 90/255, blue: 90/255, alpha: 1.0)
        header.contentView.backgroundColor = color
        header.textLabel.textColor = UIColor.whiteColor() //make the text white
        header.alpha = 1.0
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        if (events == nil)
        {
            return 0
        }
        
<<<<<<< HEAD
        if (trendingEvents.isEmpty && section == 0)
=======
        if (trendingEvents.isEmpty)
>>>>>>> origin/master
        {
            return 0
        }
        
        if (isOnFeatured == true)
        {
            if (section == 0)
            {
                return self.trendingEvents.count
            }
<<<<<<< HEAD
            
            if (section == 1)
            {
                return self.recommendedEvents.count
            }
=======
>>>>>>> origin/master
        }
        else {
            return events!.count
        }
        
        return 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
<<<<<<< HEAD
        let cell = tableView.dequeueReusableCellWithIdentifier("eventCell") as! EventCell
        
        var eventObject: PFObject?
        
        if (isOnFeatured)
        {
            if (indexPath.section == 0)
            {
                eventObject = self.trendingEvents[indexPath.row]
            }
            else if (indexPath.section == 1)
            {
                eventObject = self.recommendedEvents[indexPath.row]
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
        
=======
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
        
>>>>>>> origin/master
        let attendanceCount = (eventObject!["attendanceCount"] as? NSNumber)!.intValue
        
        if (attendanceCount > 30)
        {
            cell.labelEventCount.text = "🔥 \(attendanceCount)"
        }
        else
        {
            cell.labelEventCount.text = "\(attendanceCount)"
        }
<<<<<<< HEAD
        
        let userImageFile = eventObject!["picture"] as? PFFile
        
        cell.imageViewEvent.layer.cornerRadius = cell.imageViewEvent.frame.size.height/2
        cell.imageViewEvent.layer.masksToBounds = true
        
        if userImageFile != nil {
            userImageFile!.getDataInBackgroundWithBlock {
                (imageData: NSData?, error: NSError?) -> Void in
                if error == nil {
                    if let imageData = imageData {
                        let image = UIImage(data:imageData)
                        
                        // Set circle image as image
                        cell.imageViewEvent.image = image
                    }
                }
            }
        }

=======
>>>>>>> origin/master
        
        // "2014-07-23 11:01:35 -0700" <-- same date, local, but with seconds
        //
        // Configure the cell...
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
<<<<<<< HEAD
        print("ZZ")
        var eventObject: PFObject?
        
        if (isOnFeatured)
        {
            if (indexPath.section == 0)
            {
                eventObject = self.trendingEvents[indexPath.row]
            }
            else if (indexPath.section == 1)
            {
                eventObject = self.recommendedEvents[indexPath.row]
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
=======
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

>>>>>>> origin/master

            
        self.performSegueWithIdentifier("eventDetail", sender: eventObject)
        print("pressed")
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (isOnFeatured && section == 0)
        {
            return "Trending"
        }
        else if (isOnFeatured && section == 1)
        {
            return "Recommended"
        }
        
        return nil
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "eventDetail")
        {
            var nextController : EventDetailTableView = segue.destinationViewController as! EventDetailTableView
            nextController.eventObject = sender as! PFObject
        }
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
    
}
