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
    var newLocationRefHandle: FIRDatabaseHandle?
    
    var mapView = GoogleMapViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = FIRDatabase.database().reference()
        
        locationRef = ref.child("caponego").child("locations")
        let locationQuery = locationRef.queryLimited(toLast:25)
        newLocationRefHandle = locationQuery.observe(.childAdded, with: { (snapshot) -> Void in
            let locationData = snapshot.value as? NSDictionary
            
            print("New Location")
            print(locationData?["imageAddress"] as? String ?? "")
            print(locationData?["name"] as? String ?? "")
            print(locationData?["latitude"] as? Double ?? 0.0)
            print(locationData?["longitude"] as? Double ?? 0.0)
            
            
        })
        
        
        levelCounter.text = "\(level)"
        rewardPointCounter.text = "\(rewardPoints)"
        capitalPointCounter.text = "\(capitalPoints)"
        
        
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

