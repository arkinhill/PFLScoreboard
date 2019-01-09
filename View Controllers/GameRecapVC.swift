//
//  GameRecapVC.swift
//  PFL
//
//  Created by Arkin Hill on 1/4/19.
//  Copyright © 2019 Arkin Hill. All rights reserved.
//

import UIKit

class GameRecapVC: UIViewController {
    
    // MARK: - LANDING PAD
    
    var selectedGame: Game?
    
    // MARK: - OUTLETS
    
    // MARK: - VIEW DID LOAD

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - ACTIONS
    
    @IBAction func exitButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
