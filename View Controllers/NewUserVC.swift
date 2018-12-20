//
//  NewUserVC.swift
//  PFLScoreboard
//
//  Created by Arkin Hill on 12/19/18.
//  Copyright © 2018 Arkin Hill. All rights reserved.
//

import UIKit

class NewUserVC: UIViewController {
    
    // MARK: - OUTLETS
    
    @IBOutlet weak var newUsernameTextField: UITextField!
    
    // MARK: - VIEW DID LOAD
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - ACTIONS
    
    @IBAction func submitButton(_ sender: UIButton) {
        
        // Unwrap, grab text from username field
        guard let username = newUsernameTextField.text, !username.isEmpty else { return }
        
        // Create new user
        UserController.shared.createUser(username: username) { (success) in
            if success == true {
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "toProfileFromNew", sender: nil)
                }
            } else {
                // Do something if not successful
            }
        }
    }
}
