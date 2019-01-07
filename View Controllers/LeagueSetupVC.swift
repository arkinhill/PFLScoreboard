//
//  LeagueSetupVC.swift
//  PFLScoreboard
//
//  Created by Arkin Hill on 12/20/18.
//  Copyright © 2018 Arkin Hill. All rights reserved.
//

import UIKit
import CloudKit

class LeagueSetupVC: UIViewController {
    
    // 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
    // 🔸 MARK: - SOURCE OF TRUTH
    
    var league: League?
    
    
    // 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
    // 🔸 MARK: - OUTLETS
    
    @IBOutlet weak var leagueNameTextField: UITextField!
    
    @IBOutlet var teamNameTextFields: [UITextField]!
    @IBOutlet var coachNameTextFields: [UITextField]!
    
    // Outlet collection (dragged out one username field, selected "collection" instead of "outlet", then joined all other username fields by dragging from filled circle at left up to each field on storyboard)
    
    @IBOutlet var usernameTextFields: [UITextField]!
    
    
    // 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
    // 🔸 MARK: - VIEW DID LOAD
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
    // 🔸 MARK: - ACTIONS
    
    @IBAction func createNewLeagueButton(_ sender: UIButton) {
        let teamCount = self.checkHowManyTeams()
        LeagueController.shared.createLeague(leagueName: leagueNameTextField.text!, isPending: false, users: []) { (league) in
            if let league = league {
                self.league = league
                self.addAllTeamsTo(league: league, endIndex: (teamCount - 1), completion: { (success) in
                    if success {
                        
                        // Selecting the right game schedule based on number of teams in league
                        if self.league!.teams.count == 4 {
                            LeagueController.shared.addGamesTo4TeamLeague(league: league)
                        } else if league.teams.count == 6 {
                            LeagueController.shared.addGamesTo6TeamLeague(league: league)
                        } else if league.teams.count == 8 {
                            LeagueController.shared.addGamesTo8TeamLeague(league: league)
                
                        // Presenting alert notification if league info is incorrect
                        } else {
                            self.presentAlertController()
                        }
                        DispatchQueue.main.async {
                            
                        self.addUsersTo(league: league, completion: { (success) in
                            if success {
                            }
                        })
                        }
                    }
                })
            }
        }
    }
    
    // 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
    // 🔸 MARK: - CREATE LEAGUE BUTTON FUNCTIONS
    
    func checkHowManyTeams() -> Int {
        var teamNameCount = 0
        var coachNameCount = 0
        for textField in teamNameTextFields {
            if textField.text != nil && textField.text != "" {
                teamNameCount += 1
            }
        }
        for textField in coachNameTextFields {
            if textField.text != nil && textField.text != "" {
                coachNameCount += 1
            }
        }
        if teamNameCount == coachNameCount {
            return coachNameCount
        } else {
            return 0
        }
    }
    
    func addAllTeamsTo(league: League, index: Int = 0, endIndex: Int, completion: @escaping (Bool) -> Void) {
        DispatchQueue.main.async {
            
            if let teamName = self.teamNameTextFields[index].text, !teamName.isEmpty,
                let coachName = self.coachNameTextFields[index].text, !coachName.isEmpty {
                TeamController.shared.createTeam(coach: coachName, name: teamName, color: LeagueController.shared.teamColors[index], league: league) { (team) in
                    guard let team = team else { completion(false); return }
                    LeagueController.shared.addTeamToLeague(league: league, team: team, completion: { (success) in
                        if success {
                            if index == endIndex {
                                completion(true)
                            } else {
                                self.addAllTeamsTo(league: league, index: index + 1, endIndex: endIndex, completion: completion)
                            }
                        }
                    })
                }
            }
        }
    }
    
    // ⭐️ RIP: Eric Lanza gave the best years of his life to make this function work...
    
    func addUsersTo(league: League, completion: @escaping (Bool) -> Void) {
        for textField in self.usernameTextFields {
            guard let username = textField.text,!username.isEmpty else { continue }
            
            // Set predicate to username, query to find username records
            let predicate = NSPredicate(format: "username == %@", username)
            let query = CKQuery(recordType: User.userTypeKey, predicate: predicate)
            
            CKContainer.default().publicCloudDatabase.perform(query, inZoneWith: nil) { (records, error) in
                if let error = error {
                    print("Error fetching user: \(error.localizedDescription)")
                    return
                }
                if let records = records, let userRecord = records.first {
                    if let user = User(ckRecord: userRecord), let userRecordID = user.ckRecordID {
                        let userReference = CKRecord.Reference(recordID: userRecordID, action: .none)
                        league.userReference.append(userReference)
                        
                        LeagueController.shared.updateLeague(league: league, leagueName: league.leagueName, isPending: league.isPending ?? false, teams: league.teams, users: league.users, completion: completion)
                    }
                }
            }
        }
    }
    
    // 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
    // 🔸 MARK: - NAVIGATION
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toUserProfile" {
        }
    }
}

// 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
// 🔸 MARK: - ALERT CONTROLLER EXTENSION

extension LeagueSetupVC {
    
    func presentAlertController() {
        let alertController = UIAlertController(title: "Incorrect League Info", message: "Please make sure you have a league name, and either four, six, or eight teams with complete information for each.", preferredStyle: .alert)
        
        let dismissAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(dismissAction)
        present(alertController, animated: true, completion: nil)
    }
}

// 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
// 🔸 MARK: - RESIGN TEXT FIELD EXTENSION

extension LeagueSetupVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
