//
//  UserProfileVC.swift
//  PFLScoreboard
//
//  Created by Arkin Hill on 12/19/18.
//  Copyright © 2018 Arkin Hill. All rights reserved.
//

import UIKit

class UserProfileVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - SOURCE OF TRUTH
    
    var leagues: [League] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - OUTLETS
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    // MARK: - VIEW DID LOAD
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - ACTIONS
    
    @IBAction func addNewLeagueButton(_ sender: UIButton) {
    }
    
    // MARK: - TABLE VIEW DATA SOURCE
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if UserController.shared.loggedInUser?.leagueInvites.count ?? 0 > 0 {
            return 2
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sectionCell") as! SectionTVCell
        if section == 0 {
            cell.sectionTitleLabel?.text = "YOUR LEAGUES:"
        } else {
            cell.sectionTitleLabel.text = "YOUR LEAGUE INVITES:"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return UserController.shared.loggedInUser?.leagues.count ?? 0
        } else {
            return UserController.shared.loggedInUser?.leagueInvites.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let league = leagues[indexPath.row]
        
        // Custom cell switch
        switch indexPath.section {
            
        // Send all active leagues to LeagueActiveTVCell
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "leagueActiveCell", for: indexPath) as? LeagueActiveTVCell
                else { return UITableViewCell() }
            
            // Set delegate to custom view cell
            // (Step 5 of 5 - 3 steps in child, 2 in parent(this file))
            cell.delegate = self
            
            // Configure the cell
            cell.leagueNameLabel?.text = league.leagueName
            return cell
            
        // Send all league invites to LeagueInvitedTVCell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "leagueInvitedCell", for: indexPath) as? LeagueInvitedTVCell
                else { return UITableViewCell() }
            
            // Set delegate to custom view cell
            // (Step 5 of 5 - 3 steps in child, 2 in parent(this file))
            cell.delegate = self
            
            // Configure the cell
            cell.leagueNameLabel?.text = league.leagueName
            return cell
            
        default:
            print("Hi")
            return UITableViewCell()
        }
    }
    
// ❎ Need to complete navigation (pass through league object with teams, games)
    
    // MARK: - NAVIGATION
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}

// MARK: - LEAGUE ACTIVE TV CELL DELEGATE EXTENSION

// Conforming to delegate set above -
// (Step 4 of 5 - 3 steps in child, 2 in parent(this file))

extension UserProfileVC: LeagueActiveTVCellDelegate {
    
    func unlinkFromLeagueButtonTapped(_ sender: LeagueActiveTVCell) {
    
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

// MARK: - LEAGUE INVITED TV CELL DELEGATE EXTENSION

// Conforming to delegate set above -
// (Step 4 of 5 - 3 steps in child, 2 in parent(this file))

extension UserProfileVC: LeagueInvitedTVCellDelegate {

// ❎ Need to complete this function
    
    func acceptInviteButtonTapped(_ sender: LeagueInvitedTVCell) {
        // WHAT TO DO WHEN INVITE IS ACCEPTED
    }
    
    func rejectInviteButtonTapped(_ sender: LeagueInvitedTVCell) {
    
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



