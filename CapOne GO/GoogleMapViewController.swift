//
//  GoogleMapViewController.swift
//  CapOne GO
//
//  Created by Jacob Bashista on 7/21/17.
//  Copyright © 2017 Jacob Bashista. All rights reserved.
//

import UIKit
import GoogleMaps
import SCLAlertView

class GoogleMapViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate {
    
    var mapView : GMSMapView?
    let locationManager = CLLocationManager()
    var camera = GMSCameraPosition()
    

    override func viewDidLoad() {
        mapView = GMSMapView()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            switch(CLLocationManager.authorizationStatus()) {
            case .notDetermined, .restricted, .denied:
                print("No access")
            case .authorizedAlways, .authorizedWhenInUse:
                camera = GMSCameraPosition.camera(withLatitude: (locationManager.location?.coordinate.latitude)!, longitude: (locationManager.location?.coordinate.longitude)!, zoom: 22.0)
            }
        } else {
            print("Location services are not enabled")
        }
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView?.isMyLocationEnabled = true
        
        mapView?.delegate = self
        view = mapView
        mapView?.animate(toViewingAngle: 45)
    }
    
    func addMarker(name: String, imageAddress: String, latitude: Double, longitude: Double){
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        marker.title = name
        marker.snippet = imageAddress
        marker.icon = UIImage(named: "capOneLogo.png")
        marker.map = self.mapView
    }
    
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        
        let userLocation = locationManager.location
        let markerLocation = CLLocation(latitude: marker.position.latitude, longitude: marker.position.longitude)
        
        var distance = userLocation?.distance(from: markerLocation).rounded()
        
        distance = distance?.magnitude
        
        if(distance! > 200){
        
            let appearance = SCLAlertView.SCLAppearance(
                showCircularIcon: true
            )
            let alertView = SCLAlertView(appearance: appearance)
            let alertViewIcon = UIImage(named: "capOneLogo.png")
            alertView.showInfo(marker.title!, subTitle: "This Location is Too Far Away", circleIconImage: alertViewIcon)
        }else{
            let appearance = SCLAlertView.SCLAppearance(
                showCircularIcon: true
            )
            let alertView = SCLAlertView(appearance: appearance)
            
            
            let subView = UIView(frame: CGRect(x: 0,y: 0,width: 216,height: 100))
            let x = (subView.frame.width - 180) / 2
            
            let textLabel1 = UILabel(frame: CGRect(x: x,y: 10,width: 180,height: 25))
            textLabel1.text = "400 CP / hr"
            textLabel1.textAlignment = NSTextAlignment.center
            textLabel1.textColor = UIColor.orange
            subView.addSubview(textLabel1)
            
            let textLabel2 = UILabel(frame: CGRect(x: x,y: 50,width: 180,height: 25))
            textLabel2.text = "0%"
            textLabel2.textAlignment = NSTextAlignment.center
            textLabel2.font = UIFont.boldSystemFont(ofSize: 30)
            subView.addSubview(textLabel2)            
            
            alertView.customSubview = subView
            
            let alertViewIcon = UIImage(named: "capOneLogo.png")
            alertView.addButton("Invest", action: {
                
            })
            alertView.showInfo(marker.title!, subTitle: "Available for Investment", circleIconImage: alertViewIcon)
        }
        return true
    }
}
