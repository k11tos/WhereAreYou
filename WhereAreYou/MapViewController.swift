//
//  ViewController.swift
//  WhereAreYou
//
//  Created by Jang Hyeon Lee on 2016. 5. 7..
//  Copyright © 2016년 Jang Hyeon Lee. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController, CLLocationManagerDelegate {

    let locationManager = CLLocationManager()
    var location        = CLLocationCoordinate2D(latitude: 0,longitude: 0)
    var membersInMap    = [MemberInMap]()
    @IBOutlet weak var mapView: GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        location = self.getCurrentLocationFromGPS()

        let camera = GMSCameraPosition.cameraWithLatitude(location.latitude,
                                                          longitude:location.longitude, zoom:10)
        mapView.camera = camera
        
        mapView.myLocationEnabled = true
        
        //let mapInsets = UIEdgeInsetsMake(100.0, 0.0, 0.0, 300.0)
        //mapView.padding = mapInsets
        mapView.settings.compassButton = true

        loadSampleMembers()

        var markers = [GMSMarker]()

        for member in membersInMap {
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: member.latitude, longitude:member.longitude)
            marker.title = member.name
            marker.appearAnimation = kGMSMarkerAnimationPop
            marker.map = mapView

            markers.append(marker)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    func loadSampleMembers() {
        let member1 = MemberInMap(name: "A",  updatedDate: NSDate(), latitude: 37.566535, longitude: 126.97796919999996)
        let member2 = MemberInMap(name: "B",  updatedDate: NSDate(), latitude: 37.4449168, longitude: 127.13886839999998)
        let member3 = MemberInMap(name: "C", updatedDate: NSDate(), latitude: 37.2410864, longitude: 127.17755369999998)
        let member4 = MemberInMap(name: "D",    updatedDate: NSDate(), latitude: 36.9921075, longitude: 127.11294509999993)
   
        membersInMap.append(member1!)
        membersInMap.append(member2!)
        membersInMap.append(member3!)
        membersInMap.append(member4!)
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
                                                              longitude:location.longitude, zoom:10)
            mapView.camera = camera

//            let marker = GMSMarker()
//            marker.position = camera.target
//            marker.title = "Hello World"
//            marker.appearAnimation = kGMSMarkerAnimationPop
//            marker.map = mapView
        }
    }
}

