//
//  ViewController.swift
//  CapOne GO
//
//  Created by Jacob Bashista on 7/21/17.
//  Copyright © 2017 Jacob Bashista. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController {
    
    
    @IBOutlet weak var levelCounter: UILabel!
    @IBOutlet weak var rewardPointCounter: UILabel!
    @IBOutlet weak var capitalPointCounter: UILabel!
    
    
    var level = 0
    var rewardPoints = 0
    var capitalPoints = 0
    
    var ref: FIRDatabaseReference!
    var locationRef: FIRDatabaseReference!
    var userRef: FIRDatabaseReference!
    var newLocationRefHandle: FIRDatabaseHandle?
    var userRefHandle: FIRDatabaseHandle?
    
    var mapView = GoogleMapViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        levelCounter.text = "\(level)"
        rewardPointCounter.text = "\(rewardPoints)"
        capitalPointCounter.text = "\(capitalPoints)"
        
        getLocations()
        populateUser()
    }
    
    func populateUser(){
        
        ref = FIRDatabase.database().reference()
        ref.child("caponego").child("userInfo").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            
            //let name = value?["name"] as? String ?? ""
            //let photo = value?["photo"] as? String ?? ""
            self.rewardPoints = value?["rewardPoints"] as? Int ?? 0
            //let travelPoints = value?["travelPoints"] as? Int ?? 0
            self.capitalPoints = value?["capitalPoint"] as? Int ?? 0
            //let lifeTimePoints = value?["lifeTimeRewardPoints"] as? Int ?? 0
            
            self.levelCounter.text = "\(self.level)"
            self.rewardPointCounter.text = "\(self.rewardPoints)"
            self.capitalPointCounter.text = "\(self.capitalPoints)"

            
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
    
    
    func getLocations(){
        ref = FIRDatabase.database().reference()
        
        locationRef = ref.child("caponego").child("locations")
        let locationQuery = locationRef.queryLimited(toLast:25)
        newLocationRefHandle = locationQuery.observe(.childAdded, with: { (snapshot) -> Void in
            let locationData = snapshot.value as? NSDictionary
    
            let image = locationData?["imageAddress"] as? String ?? ""
            let name = locationData?["name"] as? String ?? ""
            let latitude = locationData?["latitude"] as? Double ?? 0.0
            let longitude = locationData?["longitude"] as? Double ?? 0.0
            
            
            self.mapView.addMarker(name: name, imageAddress: image, latitude: latitude, longitude: longitude)
            
            
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "openMap"){
            mapView = segue.destination as! GoogleMapViewController
        }
    }


}

