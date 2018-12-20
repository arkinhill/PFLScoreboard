//
//  StartupVC.swift
//  PFLScoreboard
//
//  Created by Arkin Hill on 12/19/18.
//  Copyright © 2018 Arkin Hill. All rights reserved.
//

import UIKit

class StartupVC: UIViewController {
    
    // MARK: - VIEW DID LOAD

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserController.shared.fetchLoggedInUser { (userLoggedIn) in
            DispatchQueue.main.async {
                
                // If user exists, send to user profile view
                if userLoggedIn == true {
                    self.performSegue(withIdentifier: "toUserProfile", sender: nil)
                    
                    // If user doesn't exist yet, send to new user view
                } else {
                    self.performSegue(withIdentifier: "toNewUser", sender: nil)
                }
            }
        }
    }
}
