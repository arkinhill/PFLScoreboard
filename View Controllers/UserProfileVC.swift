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
    @IBOutlet weak var usernameTextLabel: UILabel!
    
    // MARK: - VIEW DID LOAD
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - ACTIONS
    
    @IBAction func addNewLeagueButton(_ sender: UIButton) {
    }
    
    // MARK: - TABLE VIEW DATA SOURCE
    
    func numberOfSections(in tableView: UITableView) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let league = leagues[indexPath.row]
        
        // Custom cell switch
        switch league.isPending {
            
        // Send all active leagues to LeagueActiveTVCell
        case false:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "leagueActiveCell", for: indexPath) as? LeagueActiveTVCell
                else { return UITableViewCell() }
            
            // Configure the cell
            cell.leagueNameLabel?.text = league.leagueName
            return cell
            
        // Send all league invites to LeagueInvitedTVCell
        case true:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "leagueInvitedCell", for: indexPath) as? LeagueInvitedTVCell
                else { return UITableViewCell() }
            
            // Configure the cell
            cell.leagueNameLabel?.text = league.leagueName
            return cell
        }
    }
    
//❎
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            let unlinkLeague = UIContextualAction(style: .destructive, title: "Unlink") { (action, view, nil) in
                print("Unlink") // NEED TO ADD CODE HERE TO REMOVE LEAGUE FROM ARRAY
            }
            unlinkLeague.backgroundColor = UIColor(named: Constants.PFLred)
            
            let config = UISwipeActionsConfiguration(actions: [unlinkLeague])
            config.performsFirstActionWithFullSwipe = false
            return config
    }
    
////❎
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//
//            // Get league to be deleted
//            let league = LeagueController.
//        }
//    }
    
    // MARK: - NAVIGATION
}
