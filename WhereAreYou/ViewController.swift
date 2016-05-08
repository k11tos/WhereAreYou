//
//  ViewController.swift
//  WhereAreYou
//
//  Created by Jang Hyeon Lee on 2016. 5. 7..
//  Copyright © 2016년 Jang Hyeon Lee. All rights reserved.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController, CLLocationManagerDelegate {

    let locationManager = CLLocationManager()
    var location        = CLLocationCoordinate2D(latitude: 0,longitude: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        location = self.getCurrentLocationFromGPS()

        let camera = GMSCameraPosition.cameraWithLatitude(location.latitude,
                                                          longitude:location.longitude, zoom:15)
        let mapView = GMSMapView.mapWithFrame(CGRectZero, camera:camera)
        
        mapView.myLocationEnabled = true
        
        //let mapInsets = UIEdgeInsetsMake(100.0, 0.0, 0.0, 300.0)
        //mapView.padding = mapInsets
        mapView.settings.compassButton = true
        self.view = mapView
        
//        let marker = GMSMarker()
//        marker.position = camera.target
//        marker.snippet = "Hello World"
//        marker.appearAnimation = kGMSMarkerAnimationPop
//        marker.map = mapView
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    func initLocationManager() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.distanceFilter  = kCLDistanceFilterNone
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func getCurrentLocationFromGPS () -> CLLocationCoordinate2D {
        
        var currentLocation = CLLocationCoordinate2D(latitude: 0,longitude: 0)

        self.initLocationManager()
        
        if let locationManagerLocation = locationManager.location {
            locationManager.startUpdatingLocation()
            currentLocation = locationManagerLocation.coordinate
            locationManager.stopUpdatingLocation()
        } else {
            currentLocation.latitude  = 0
            currentLocation.longitude = 0
        }
        
        return currentLocation
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.AuthorizedWhenInUse
        {
            location = getCurrentLocationFromGPS()
            let camera = GMSCameraPosition.cameraWithLatitude(location.latitude,
                                                              longitude:location.longitude, zoom:15)
            let mapView = GMSMapView.mapWithFrame(CGRectZero, camera:camera)
            
            let marker = GMSMarker()
            marker.position = camera.target
            marker.snippet = "Hello World"
            marker.appearAnimation = kGMSMarkerAnimationPop
            marker.map = mapView
        }
    }
}

