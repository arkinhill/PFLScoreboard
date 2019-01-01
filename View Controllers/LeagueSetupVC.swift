//
//  LeagueSetupVC.swift
//  PFLScoreboard
//
//  Created by Arkin Hill on 12/20/18.
//  Copyright © 2018 Arkin Hill. All rights reserved.
//

import UIKit

class LeagueSetupVC: UIViewController {
    
    // MARK: - OUTLETS
    
    @IBOutlet weak var leagueNameTextField: UITextField!
    
    @IBOutlet weak var teamATeamNameTextField: UITextField!
    @IBOutlet weak var teamACoachNameTextField: UITextField!
    
    @IBOutlet weak var teamBTeamNameTextField: UITextField!
    @IBOutlet weak var teamBCoachNameTextField: UITextField!
    
    @IBOutlet weak var teamCTeamNameTextField: UITextField!
    @IBOutlet weak var teamCCoachNameTextField: UITextField!
    
    @IBOutlet weak var teamDTeamNameTextField: UITextField!
    @IBOutlet weak var teamDCoachNameTextField: UITextField!
    
    @IBOutlet weak var teamETeamNameTextField: UITextField!
    @IBOutlet weak var teamECoachNameTextField: UITextField!
    
    @IBOutlet weak var teamFTeamNameTextField: UITextField!
    @IBOutlet weak var teamFCoachNameTextField: UITextField!
    
    @IBOutlet weak var teamGTeamNameTextField: UITextField!
    @IBOutlet weak var teamGCoachNameTextField: UITextField!
    
    @IBOutlet weak var teamHTeamNameTextField: UITextField!
    @IBOutlet weak var teamHCoachNameTextField: UITextField!
    
    @IBOutlet weak var PFLUsername1TextField: UITextField!
    @IBOutlet weak var PFLUserName2TextField: UITextField!
    @IBOutlet weak var PFLUsername3TextField: UITextField!
    @IBOutlet weak var PFLUsername4TextField: UITextField!
    @IBOutlet weak var PFLUsername5TextField: UITextField!
    @IBOutlet weak var PFLUsername6TextField: UITextField!
    @IBOutlet weak var PFLUsername7Textfield: UITextField!
    @IBOutlet weak var PFLUsername8TextField: UITextField!
    
    // MARK: - VIEW DID LOAD
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - ACTIONS
    
    @IBAction func createNewLeagueButton(_ sender: UIButton) {
        LeagueController.shared.createLeague(leagueName: leagueNameTextField.text!, isPending: false, users: []) { (league) in
            if let league = league {
                league.teams = []
                
                // Team A information
                if let teamATeamName = self.teamATeamNameTextField.text, !teamATeamName.isEmpty,
                    let teamACoachName = self.teamACoachNameTextField.text, !teamACoachName.isEmpty {
                    TeamController.shared.createTeam(coach: teamACoachName, name: teamATeamName, color: "red", league: league, completion: { (team) in
                        guard let team = team else { return }
                        LeagueController.shared.addTeamToLeague(league: league, team: team, completion: { (success) in
                        })
                    })
                }
                
                // Team B information
                if let teamBTeamName = self.teamBTeamNameTextField.text, !teamBTeamName.isEmpty,
                    let teamBCoachName = self.teamBCoachNameTextField.text, !teamBCoachName.isEmpty {
                    TeamController.shared.createTeam(coach: teamBCoachName, name: teamBTeamName, color: "orange", league: league, completion: { (team) in
                        guard let team = team else { return }
                        LeagueController.shared.addTeamToLeague(league: league, team: team, completion: { (success) in
                        })
                    })
                }
                
                // Team C information
                if let teamCTeamName = self.teamCTeamNameTextField.text, !teamCTeamName.isEmpty,
                    let teamCCoachName = self.teamCCoachNameTextField.text, !teamCCoachName.isEmpty {
                    TeamController.shared.createTeam(coach: teamCCoachName, name: teamCTeamName, color: "yellow", league: league, completion: { (team) in
                        guard let team = team else { return }
                        LeagueController.shared.addTeamToLeague(league: league, team: team, completion: { (success) in
                        })
                    })
                }
                
                // Team D information
                if let teamDTeamName = self.teamDTeamNameTextField.text, !teamDTeamName.isEmpty,
                    let teamDCoachName = self.teamDCoachNameTextField.text, !teamDCoachName.isEmpty {
                    TeamController.shared.createTeam(coach: teamDCoachName, name: teamDTeamName, color: "green", league: league, completion: { (team) in
                        guard let team = team else { return }
                        LeagueController.shared.addTeamToLeague(league: league, team: team, completion: { (success) in
                        })
                    })
                }
                
                // Team E information
                if let teamETeamName = self.teamETeamNameTextField.text, !teamETeamName.isEmpty,
                    let teamECoachName = self.teamECoachNameTextField.text, !teamECoachName.isEmpty {
                    TeamController.shared.createTeam(coach: teamECoachName, name: teamETeamName, color: "blue", league: league, completion: { (team) in
                        guard let team = team else { return }
                        LeagueController.shared.addTeamToLeague(league: league, team: team, completion: { (success) in
                        })
                    })
                }
                
                // Team F information
                if let teamFTeamName = self.teamFTeamNameTextField.text, !teamFTeamName.isEmpty,
                    let teamFCoachName = self.teamFCoachNameTextField.text, !teamFCoachName.isEmpty {
                    TeamController.shared.createTeam(coach: teamFCoachName, name: teamFTeamName, color: "purple", league: league, completion: { (team) in
                        guard let team = team else { return }
                        LeagueController.shared.addTeamToLeague(league: league, team: team, completion: { (success) in
                        })
                    })
                }
                
                // Team G information
                if let teamGTeamName = self.teamGTeamNameTextField.text, !teamGTeamName.isEmpty,
                    let teamGCoachName = self.teamGCoachNameTextField.text, !teamGCoachName.isEmpty {
                    TeamController.shared.createTeam(coach: teamGCoachName, name: teamGTeamName, color: "silver", league: league, completion: { (team) in
                        guard let team = team else { return }
                        LeagueController.shared.addTeamToLeague(league: league, team: team, completion: { (success) in
                        })
                    })
                }
                
                // Team H information
                if let teamHTeamName = self.teamHTeamNameTextField.text, !teamHTeamName.isEmpty,
                    let teamHCoachName = self.teamHCoachNameTextField.text, !teamHCoachName.isEmpty {
                    TeamController.shared.createTeam(coach: teamHCoachName, name: teamHTeamName, color: "black", league: league, completion: { (team) in
                        guard let team = team else { return }
                        LeagueController.shared.addTeamToLeague(league: league, team: team, completion: { (success) in
                        })
                    })
                }
                
                // Selecting the right game schedule based on number of teams in league
                if league.teams.count == 4 {
                    LeagueController.shared.addGamesTo4TeamLeague(league: league)
                } else if league.teams.count == 6 {
                    LeagueController.shared.addGamesTo6TeamLeague(league: league)
                } else if league.teams.count == 8 {
                    LeagueController.shared.addGamesTo8TeamLeague(league: league)
                    
                // Presenting alert controller if league info is incorrect
                } else {
                    self.presentAlertController()
                }
                
// ❎ NEED TO ASSIGN USERS TO LEAGUE
                
            }
        }
    }

// ❎ NEED TO COMPLETE NAVIGATION
    
    // MARK: - NAVIGATION
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toUserProfile" {}
            
        if segue.identifier == "toGameSchedule" {}
    }
}

// MARK: - ALERT CONTROLLER

extension LeagueSetupVC {
    
    func presentAlertController() {
        let alertController = UIAlertController(title: "Incorrect League Info", message: "Please make sure you have a league name, and either four, six, or eight teams with complete information for each.", preferredStyle: .alert)
        
        let dismissAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(dismissAction)
        present(alertController, animated: true, completion: nil)
    }
}

