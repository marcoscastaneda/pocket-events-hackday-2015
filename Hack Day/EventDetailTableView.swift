//
//  EventDetailTableView.swift
//  Hack Day
//
//  Created by Marcos Castaneda on 7/15/15.
//  Copyright (c) 2015 State Farm. All rights reserved.
//

import UIKit
import Parse
import MapKit
import CoreLocation

class EventDetailTableView: UITableViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var buttonAttend: UIButton!
    @IBOutlet weak var buttonInvite: UIButton!
    
    let greenColor = UIColor(red: 43/255, green: 162/255, blue: 58/255, alpha: 1.0)
    
//    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var labelAttending: UILabel!
    @IBOutlet weak var labelEventTime: UILabel!
    @IBOutlet weak var labelEventTitle: UILabel!
    @IBOutlet weak var labelEventVenue: UILabel!
    @IBOutlet weak var labelEventDescription: UILabel!
    
    let regionRadius: CLLocationDistance = 3000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
            regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    var eventObject: PFObject!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Remove seperators for empty cells
        tableView.tableFooterView = UIView(frame: CGRectZero)
        
        locationManager.delegate = self
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.startUpdatingLocation()
        
        // set initial location in Honolulu
        let initialLocation = CLLocation(latitude:40.473056, longitude:-88.958333)
        
        mapView.showsUserLocation = false
//        mapView.userInteractionEnabled = false
        centerMapOnLocation(initialLocation)
        
        // Do any additional setup after loading the view.
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude:self.mapView.userLocation.coordinate.latitude, longitude:self.mapView.userLocation.coordinate.longitude)
        self.mapView.addAnnotation(annotation)
        
        let event = Event(title: eventObject!["title"] as! String,
            locationName: eventObject!["venue"] as! String,
            discipline: "Sculpture",
            coordinate: CLLocationCoordinate2D(latitude: 40.473056, longitude: -88.958333))
        
        mapView.addAnnotation(event)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func updateAttendance()
    {
        let attendanceCount = (eventObject!["attendanceCount"] as? NSNumber)!.intValue
        self.labelAttending.text = "\(attendanceCount)"
    }
    
    override func viewWillAppear(animated: Bool) {
        self.title = eventObject!["title"] as? String
        
        self.labelEventTitle.text = eventObject!["title"] as? String
        self.labelEventVenue.text = eventObject!["venue"] as? String
        self.labelEventDescription.text = eventObject!["description"] as? String
        
        self.updateAttendance()
        
        var formatter = NSDateFormatter();
        formatter.dateFormat = "MMMM d, hh:mm a";
        let defaultTimeZoneStr = formatter.stringFromDate((eventObject!["dateStart"] as!NSDate));
        
        self.labelEventTime.text = defaultTimeZoneStr
        
        self.buttonAttend.layer.borderWidth = 1.2
        self.buttonAttend.layer.borderColor = greenColor.CGColor
        self.buttonAttend.backgroundColor = UIColor.clearColor()
        self.buttonAttend.setTitleColor(greenColor, forState: UIControlState.Normal)
    }
    
    @IBAction func attendingAction(sender: AnyObject) {
        if (self.buttonAttend.backgroundColor == UIColor.clearColor())
        {
            let attendanceCount = (eventObject!["attendanceCount"] as? NSNumber)!.intValue
            
            self.eventObject!["attendanceCount"] = NSNumber(int: (attendanceCount+1))
            self.updateAttendance()
            
            self.eventObject.saveInBackgroundWithBlock({ (success: Bool, error: NSError?) -> Void in
//
            })
            
            self.buttonAttend.backgroundColor = greenColor
            self.buttonAttend.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        }
        else
        {
            let attendanceCount = (eventObject!["attendanceCount"] as? NSNumber)!.intValue
            
            self.eventObject!["attendanceCount"] = NSNumber(int: (attendanceCount-1))
            self.updateAttendance()
            
            self.buttonAttend.backgroundColor = UIColor.clearColor()
            self.buttonAttend.setTitleColor(greenColor, forState: UIControlState.Normal)
        }
    }
    
    @IBAction func inviteFriends(sender: AnyObject) {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
