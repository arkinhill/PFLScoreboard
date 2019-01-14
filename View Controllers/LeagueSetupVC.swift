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
    var usernames: [String] = []
    var teamColors = LeagueController.shared.teamColors
    
    // 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
    // 🔸 MARK: - OUTLETS
    
    @IBOutlet weak var leagueNameTextField: UITextField!
    
    @IBOutlet var teamNameTextFields: [UITextField]!
    @IBOutlet var coachNameTextFields: [UITextField]!
    
    @IBOutlet var teamNameTextFieldsCopy: [UITextField]!
    @IBOutlet var coachNameTextFieldsCopy: [UITextField]!
    
    
    // Outlet collection (dragged out one username field, selected "collection" instead of "outlet", then joined all other username fields by dragging from filled circle at left up to each field on storyboard)
    
    @IBOutlet var usernameTextFields: [UITextField]!
    
    
    
    @IBOutlet var networkIndicatorView: UIView!
    
    
    
    // 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
    // 🔸 MARK: - VIEW DID LOAD
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
    // 🔸 MARK: - ACTIONS
    
    @IBAction func createNewLeagueButton(_ sender: UIButton) {
        teamNameTextFields = teamNameTextFieldsCopy
        coachNameTextFields = coachNameTextFieldsCopy
        teamColors = LeagueController.shared.teamColors
        getUsernames()
        view.addSubview(networkIndicatorView)
        networkIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            networkIndicatorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            networkIndicatorView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            networkIndicatorView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            networkIndicatorView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
            ])
        view.bringSubviewToFront(networkIndicatorView)
        
        let teamCount = self.checkHowManyTeams()
        if teamCount == 4 || teamCount == 6 || teamCount == 8 {
            LeagueController.shared.createLeague(leagueName: leagueNameTextField.text!, isPending: false, users: []) { (league) in
                if let league = league {
                    self.league = league
                    self.addAllTeamsTo(league: league, endIndex: (teamCount - 1), completion: { (success) in
                        if success {
                            // Selecting the right game schedule based on number of teams in league
                            switch league.teams.count {
                            case 4:
                                LeagueController.shared.addGamesTo4TeamLeague(league: league)
                            case 6:
                                LeagueController.shared.addGamesTo6TeamLeague(league: league)
                            case 8:
                                LeagueController.shared.addGamesTo8TeamLeague(league: league)
                            default:
                                self.presentAlertController()
                                return
                            }
                            self.addUsersTo(league: league, completion: { (success) in
                                DispatchQueue.main.async {
                                    self.navigationController?.popViewController(animated: true)
                                }
                            })
                            
                        }
                    })
                }
            }
        } else {
            presentAlertController()
            view.sendSubviewToBack(networkIndicatorView)
        }
    }
    
    // Set maximum character count
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        return updatedText.count <= 15
    }
    
    // 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
    // 🔸 MARK: - CREATE LEAGUE BUTTON FUNCTIONS
    
    func checkHowManyTeams() -> Int {
        var teamNameCount = 0
        var coachNameCount = 0
        var colorsToRemove: [Team.Color] = []
        var textFieldsToRemove: [UITextField] = []
        
        for index in 0...(teamNameTextFields.count - 1) {
            if teamNameTextFields[index].text != nil && teamNameTextFields[index].text != "" {
                teamNameCount += 1
            } else {
                textFieldsToRemove.append(teamNameTextFields[index])
                colorsToRemove.append(teamColors[index])
            }
        }
        
//        for textField in teamNameTextFields {
//            if textField.text != nil && textField.text != "" {
//                teamNameCount += 1
//            } else {
//                teamNameTextFields.removeAll { (textfield) -> Bool in
//                    return textfield == textField
//                }
//            }
//        }
        for textField in coachNameTextFields {
            if textField.text != nil && textField.text != "" {
                coachNameCount += 1
            } else {
                coachNameTextFields.removeAll { (textfieldToDelete) -> Bool in
                    return textfieldToDelete == textField
                }
            }
        }
        
        
        
        if teamNameCount == coachNameCount {
            colorsToRemove.forEach { (teamColor) in
                teamColors.removeAll(where: { (colorToRemove) -> Bool in
                    return colorToRemove == teamColor
                })
            }
            
            textFieldsToRemove.forEach { (textField) in
                teamNameTextFields.removeAll { (textFieldToRemove) -> Bool in
                    return textField == textFieldToRemove
                }
            }
            return coachNameCount
        } else {
            return 0
        }
    }
    
    func addAllTeamsTo(league: League, index: Int = 0, endIndex: Int, completion: @escaping (Bool) -> Void) {
        DispatchQueue.main.async {
            
            if let teamName = self.teamNameTextFields[index].text, !teamName.isEmpty,
                let coachName = self.coachNameTextFields[index].text, !coachName.isEmpty {
                TeamController.shared.createTeam(coach: coachName, name: teamName, color: self.teamColors[index], league: league) { (team) in
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
        
        if usernames.isEmpty {
            completion(true)
            return
        }
        
        usernames.forEach { (username) in
            
            
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
                        
                        LeagueController.shared.updateLeague(league: league, completion: completion)
                    }
                }
            }
        }
    }
    
    func getUsernames() {
        for textField in usernameTextFields {
            guard let username = textField.text?.lowercased().trimmingCharacters(in: .whitespacesAndNewlines),!username.isEmpty else { continue }
            usernames.append(username)
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
        
        // Change font and color of notificaton alert title and message
        let attributedStringTitle = NSAttributedString(string: "INCORRECT LEAGUE INFO", attributes: [
            NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBold", size: 18) as Any,
            NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.9976590276, green: 0.7437580228, blue: 0.1992819309, alpha: 1)
            ])
        
        let attributedStringMessage = NSAttributedString(string: "Make sure you have a league name, and either four, six, or eight teams with complete information for each.", attributes: [
            NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Light", size: 16) as Any,
            NSAttributedString.Key.foregroundColor : #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            ])
        
        // Have notification appear to ask if they are sure they want to end game
        let alertController = UIAlertController(title: "", message: "", preferredStyle: .alert)
        alertController.setValue(attributedStringTitle, forKey: "attributedTitle")
        alertController.setValue(attributedStringMessage, forKey: "attributedMessage")
        
        // change the background color
        let subview = (alertController.view.subviews.first?.subviews.first?.subviews.first!)! as UIView
        subview.layer.cornerRadius = 3
        subview.backgroundColor = #colorLiteral(red: 0.3096027874, green: 0.3096027874, blue: 0.3096027874, alpha: 1)

        // Set alert controller buttons
        let dismissAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        dismissAction.setValue(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), forKey: "titleTextColor")
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
