//
//  UserProfileVC.swift
//  PFLScoreboard
//
//  Created by Arkin Hill on 12/19/18.
//  Copyright © 2018 Arkin Hill. All rights reserved.
//

import UIKit

class UserProfileVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
    // 🔸 MARK: - SOURCE OF TRUTH

// ❎ NEW LEAGUES AREN'T SHOWING UP
    
    var leagues: [League] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
    // 🔸 MARK: - OUTLETS
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    // 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
    // 🔸 MARK: - VIEW DID LOAD / WILL APPEAR
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let user = UserController.shared.loggedInUser?.username else { return }
        usernameLabel?.text = user
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        LeagueController.shared.fetchLeagues { (success) in
            
            DispatchQueue.main.async {
        
            self.tableView.reloadData()
            }
        }
    }
    
    // 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
    // 🔸 MARK: - ACTIONS
    
    @IBAction func addNewLeagueButton(_ sender: UIButton) {
    }
    
    // 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
    // 🔸 MARK: - TABLE VIEW DATA SOURCE
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let leagues = UserController.shared.loggedInUser?.leagues else { return 1 }
        return leagues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let league = UserController.shared.loggedInUser?.leagues[indexPath.row]
        
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "leagueCell", for: indexPath) as? LeagueTVCell
                else { return UITableViewCell() }
            
            // Set delegate to custom view cell
            // (Step 5 of 5 - 3 steps in child, 2 in parent(this file))
            cell.delegate = self
            
            // Configure the cell
            cell.leagueNameLabel?.text = league?.leagueName
            return cell
    }
    
    // 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
    // 🔸 MARK: - NAVIGATION
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toGameSchedule" {
            guard let destinationVC = segue.destination as?
                GameScheduleVC, let indexPath = tableView.indexPathForSelectedRow else { return }
            
            let league = UserController.shared.loggedInUser?.leagues[indexPath.row]
            destinationVC.selectedLeague = league
            
            let backItem = UIBarButtonItem()
            backItem.title = "Back to User Profile"
            navigationItem.backBarButtonItem = backItem
        }
    }
}

// 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
// 🔸 MARK: - LEAGUE ACTIVE TV CELL DELEGATE EXTENSION

// Conforming to delegate set above -
// (Step 4 of 5 - 3 steps in child, 2 in parent(this file))

extension UserProfileVC: LeagueTVCellDelegate {
    
    func unlinkFromLeagueButtonTapped(_ sender: LeagueTVCell) {
    
        let alertController = UIAlertController(title: "Are you sure?", message: "This action will permanently disconnect you from this league.", preferredStyle: .alert)
        
        let dismissAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let continueAction = UIAlertAction(title: "Proceed", style: .default) { (_) in
            print("Continue action was tapped by the user")
        }
        alertController.addAction(dismissAction)
        alertController.addAction(continueAction)
        self.present(alertController, animated: true, completion: nil)
    }
}



