//
//  LoginViewController.swift
//  CapOne GO
//
//  Created by Jacob Bashista on 7/22/17.
//  Copyright © 2017 Jacob Bashista. All rights reserved.
//

import UIKit
import OAuthSwift

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func login(_ sender: Any) {
      let oauthswift = OAuth2Swift(
            consumerKey:    "70048ab0247b478baef288dae9f36f98",
            consumerSecret: "cf6e918da6dce17cd4dcf37c8801b3e1",
            authorizeUrl:   "https://api-sandbox.capitalone.com/oauth2/authorize?",
            responseType:   "code"
        )
            _ = oauthswift.authorize(
            withCallbackURL: URL(string: "https://huvcyixh0b.execute-api.us-east-1.amazonaws.com/prod/caponego-prod-getCapOneRewards")!,
            scope: "read_rewards_account_info",
            state:"CapOneGo",
            success: { credential, response, parameters in
                print(credential.oauthToken)
        },
            failure: { error in
                print(error.localizedDescription)
        }
        )
    }
    
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
