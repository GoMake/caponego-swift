//
//  GoogleMapViewController.swift
//  CapOne GO
//
//  Created by Jacob Bashista on 7/21/17.
//  Copyright © 2017 Jacob Bashista. All rights reserved.
//

import UIKit
import GoogleMaps

class GoogleMapViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate {
    
    
    var mapView = GMSMapView()
    let locationManager = CLLocationManager()
    var camera = GMSCameraPosition()
    

    override func viewDidLoad() {
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            switch(CLLocationManager.authorizationStatus()) {
            case .notDetermined, .restricted, .denied:
                print("No access")
            case .authorizedAlways, .authorizedWhenInUse:
                camera = GMSCameraPosition.camera(withLatitude: (locationManager.location?.coordinate.latitude)!, longitude: (locationManager.location?.coordinate.longitude)!, zoom: 13.5)
            }
        } else {
            print("Location services are not enabled")
        }
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.isMyLocationEnabled = true
        
        mapView.delegate = self
        view = mapView
    }
}
