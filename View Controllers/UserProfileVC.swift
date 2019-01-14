//
//  UserProfileVC.swift
//  PFLScoreboard
//
//  Created by Arkin Hill on 12/19/18.
//  Copyright © 2018 Arkin Hill. All rights reserved.
//

import UIKit
import CloudKit

class UserProfileVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
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
        
        // Listen for every update to the leagues source of truth
        NotificationCenter.default.addObserver(self, selector: #selector(updateView), name: leaguesDidUpdate, object: nil)
    }
    
    @objc func updateView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    // 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
    // 🔸 MARK: - ACTIONS
    
    @IBAction func addNewLeagueButton(_ sender: UIButton) {
    }
    
    // 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
    // 🔸 MARK: - TABLE VIEW DATA SOURCE
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LeagueController.shared.leagues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let league = LeagueController.shared.leagues[indexPath.row]
        
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "leagueCell", for: indexPath) as? LeagueTVCell
                else { return UITableViewCell() }
            
            // Set delegate to custom view cell
            // (Step 5 of 5 - 3 steps in child, 2 in parent(this file))
            cell.delegate = self
            cell.league = league
            cell.indexPath = indexPath
            // Configure the cell
            cell.leagueNameLabel?.text = league.leagueName
            return cell
    }
    
    // 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
    // 🔸 MARK: - NAVIGATION
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toGameSchedule" {
            guard let destinationVC = segue.destination as?
                GameScheduleVC, let indexPath = tableView.indexPathForSelectedRow else { return }
            
            let league = LeagueController.shared.leagues[indexPath.row]
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
    
    func unlinkFromLeagueButtonTapped(_ sender: LeagueTVCell, indexPath: IndexPath) {
    
        // Change font and color of notificaton alert title
        let attributedStringTitle = NSAttributedString(string: "WANT TO UNLINK LEAGUE?", attributes: [
            NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBold", size: 18) as Any,
            NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.9976590276, green: 0.7437580228, blue: 0.1992819309, alpha: 1) ])
        
        // Change font and color of notificaton alert message
        let attributedStringMessage = NSAttributedString(string: "This action will permanently disconnect you from this league.", attributes: [
            NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Light", size: 16) as Any,
            NSAttributedString.Key.foregroundColor : #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) ])
        
        let alertController = UIAlertController(title: "", message: "", preferredStyle: .alert)
        alertController.setValue(attributedStringTitle, forKey: "attributedTitle")
        alertController.setValue(attributedStringMessage, forKey: "attributedMessage")
        
        // change the background color
        let subview = (alertController.view.subviews.first?.subviews.first?.subviews.first!)! as UIView
        subview.layer.cornerRadius = 5
        subview.backgroundColor = #colorLiteral(red: 0.3096027874, green: 0.3096027874, blue: 0.3096027874, alpha: 1)
        
        let dismissAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        let continueAction = UIAlertAction(title: "Proceed", style: .default) { (_) in
            print("Continue action was tapped by the user")
            
            guard let league = sender.league,
                let loggedInUser = UserController.shared.loggedInUser
                else { return }
            
            var refs: [CKRecord.Reference] = []
            for ref in league.userReference {
                if ref.recordID == loggedInUser.ckRecordID {
                    continue
                }
                refs.append(ref)
            }
            league.userReference = refs
            
            LeagueController.shared.updateLeague(league: league, completion: { (success) in
                if success {
                    DispatchQueue.main.async {
                        guard let indexToDelete = LeagueController.shared.leagues.firstIndex(of: league) else { return }
                        LeagueController.shared.leagues.remove(at: indexToDelete)
                        
                        self.tableView.deleteRows(at: [indexPath], with: .fade)
                    }
                }
            })
        }
        alertController.addAction(dismissAction)
        alertController.addAction(continueAction)
        
        // Customize alert notification button colors
        continueAction.setValue(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), forKey: "titleTextColor")
        dismissAction.setValue(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), forKey: "titleTextColor")
        
        self.present(alertController, animated: true, completion: nil)
    }
}
