//
//  NearbyView.swift
//  Hack Day
//
//  Created by Marcos Castaneda on 7/15/15.
//  Copyright (c) 2015 State Farm. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class NearbyView: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var mapView: MKMapView!
    
<<<<<<< HEAD
    let regionRadius: CLLocationDistance = 5000
=======
    let regionRadius: CLLocationDistance = 400000
>>>>>>> origin/master
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
            regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
<<<<<<< HEAD

=======
        
        print(locationManager.requestAlwaysAuthorization())
        
>>>>>>> origin/master
        // set initial location in Honolulu
        let initialLocation = CLLocation(latitude:40.473056, longitude:-88.958333)
        
        mapView.showsUserLocation = true
        centerMapOnLocation(initialLocation)
        
        // Do any additional setup after loading the view.
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude:self.mapView.userLocation.coordinate.latitude, longitude:self.mapView.userLocation.coordinate.longitude)
        self.mapView.addAnnotation(annotation)
<<<<<<< HEAD
        
        var event = Event(title: "Race for the Cure",
            locationName: "State Farm Park",
            discipline: "Sculpture",
            coordinate: CLLocationCoordinate2D(latitude: 40.493056, longitude: -88.958333)
        )
        
        var event2 = Event(title: "Car Wash Event",
            locationName: "Exxon Gas Station",
            discipline: "Sculpture",
            coordinate: CLLocationCoordinate2D(latitude: 40.503056, longitude: -88.968333)
        )
        
        var event3 = Event(title: "Golf Tournament",
            locationName: "Bloomington Golf Club",
            discipline: "Sculpture",
            coordinate: CLLocationCoordinate2D(latitude: 40.483056, longitude: -88.968333)
        )
        
        var event31 = Event(title: "Ultimate Frisbee",
            locationName: "State Farm Park",
            discipline: "Sculpture",
            coordinate: CLLocationCoordinate2D(latitude: 40.463056, longitude: -88.968333)
        )
        
        var event4 = Event(title: "Anna's 50th Anniversary",
            locationName: "State Farm Park",
            discipline: "Sculpture",
            coordinate: CLLocationCoordinate2D(latitude: 40.453056, longitude: -88.938333)
        )
        
        var event5 = Event(title: "Biking at the Trails",
            locationName: "State Farm Park",
            discipline: "Sculpture",
            coordinate: CLLocationCoordinate2D(latitude: 40.473056, longitude: -88.948333)
        )
        
        
        mapView.addAnnotation(event)
        mapView.addAnnotation(event2)
        mapView.addAnnotation(event3)
        mapView.addAnnotation(event4)
        mapView.addAnnotation(event5)
        mapView.addAnnotation(event31)
    }
    
    func locationManager(manager:CLLocationManager!, didUpdateLocations locations:[AnyObject]!){
        
        CLGeocoder().reverseGeocodeLocation(manager.location, completionHandler: { (placemarks, error) -> Void in
            
            if error != nil {
                println("Error" + error.localizedDescription)
                return
            }
        
            if placemarks.count > 0
            {
                let pm = placemarks[0] as! CLPlacemark
                self.displayLocationInfo(pm)
            }
            
        })
    }

=======
    }
    
    func locationManager(manager:CLLocationManager!, didUpdateLocations locations:[AnyObject]!){
        
        CLGeocoder().reverseGeocodeLocation(manager.location, completionHandler: { (placemarks, error) -> Void in
            
            if error != nil {
                println("Error" + error.localizedDescription)
                return
            }
            
            if placemarks.count > 0
            {
                let pm = placemarks[0] as! CLPlacemark
                self.displayLocationInfo(pm)
            }
            
        })
    }
    
>>>>>>> origin/master
    
    func displayLocationInfo(placemark: CLPlacemark){
        
        self.locationManager.stopUpdatingLocation()
<<<<<<< HEAD
//        println(placemark.locality)
//        println(placemark.postalCode)
//        println(placemark.administrativeArea)
//        println(placemark.country)
=======
        println(placemark.locality)
        println(placemark.postalCode)
        println(placemark.administrativeArea)
        println(placemark.country)
>>>>>>> origin/master
        
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println("Error: " + error.localizedDescription)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationItem.title = "Events Near Me"
    }
    
    override func viewDidAppear(animated: Bool) {
        
    }
    
}