//
//  ScoreboardVC.swift
//  PFLScoreboard
//
//  Created by Arkin Hill on 1/2/19.
//  Copyright © 2019 Arkin Hill. All rights reserved.
//

import UIKit
import CloudKit

class ScoreboardVC: UIViewController {
    
    // 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
    // 🔸 MARK: - LANDING PAD
    
    var selectedGame: Game?
    
    // 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
    // 🔸 MARK: - OUTLETS - TEAM HEADERS, SCORE, AND CLOCK
    
    // Team 1 header
    @IBOutlet weak var team1NameLabel: UILabel!
    @IBOutlet weak var team1CoachLabel: UILabel!
    @IBOutlet weak var team1RecordLabel: UILabel!
    @IBOutlet weak var team1RankImageView: UIImageView!
    @IBOutlet weak var team1HelmetButton: UIButton!
    @IBOutlet weak var team1HelmetLetterImageView: UIImageView!
    
    // Team 2 header
    @IBOutlet weak var team2NameLabel: UILabel!
    @IBOutlet weak var team2CoachLabel: UILabel!
    @IBOutlet weak var team2RecordLabel: UILabel!
    @IBOutlet weak var team2RankImageView: UIImageView!
    @IBOutlet weak var team2HelmetButton: UIButton!
    @IBOutlet weak var team2HelmetLetterImageView: UIImageView!
    
    // Clock and Half Indicator
    @IBOutlet weak var halfIndicatorImageView: UIImageView!
    @IBOutlet weak var clockFirstDigitImageView: UIImageView!
    @IBOutlet weak var clockSecondDigitImageView: UIImageView!
    @IBOutlet weak var clockThirdDigitImageView: UIImageView!
    @IBOutlet weak var clockFourthDigitImageView: UIImageView!
    
    // Scores
    @IBOutlet weak var team1ScoreFirstDigitImageView: UIImageView!
    @IBOutlet weak var team1ScoreSecondDigitImageView: UIImageView!
    @IBOutlet weak var team2ScoreFirstDigitImageView: UIImageView!
    @IBOutlet weak var team2ScoreSecondDigitImageView: UIImageView!
    
    // 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
    // 🔸 MARK: - OUTLETS - TEAM 1 STATS
    
    // Stats - Team 1 Pass Completion - Game
    @IBOutlet weak var team1GameCompletionsButton: UIButton!
    @IBOutlet weak var team1GamePassesAttemptedButton: UIButton!
    @IBOutlet weak var team1GameCompletionPercentButton: UIButton!
    @IBOutlet weak var team1GameIntThrownButton: UIButton!
    
    // Stats - Team 1 Pass Completion - Averages
    @IBOutlet weak var team1AvgCompletionsButton: UIButton!
    @IBOutlet weak var team1AvgPassesAttemptedButton: UIButton!
    @IBOutlet weak var team1AvgCompletionPercentButton: UIButton!
    @IBOutlet weak var team1AvgIntThrownButton: UIButton!
    
    // Stats - Team 1 Field Goals - Game
    @IBOutlet weak var team1GameFieldGoalsButton: UIButton!
    @IBOutlet weak var team1GameFieldGoalsAttemptedButton: UIButton!
    @IBOutlet weak var team1GameFieldGoalPercentButton: UIButton!
    
    // Stats - Team 1 Field Goals - Averages
    @IBOutlet weak var team1AvgFieldGoalsButton: UIButton!
    @IBOutlet weak var team1AvgFieldGoalsAttemptedButton: UIButton!
    @IBOutlet weak var team1AvgFieldGoalPercentButton: UIButton!
    
    // Stats - Team 1 PATs - Game
    @IBOutlet weak var team1GamePATsMadeButton: UIButton!
    @IBOutlet weak var team1GamePATsAttemptedButton: UIButton!
    @IBOutlet weak var team1GamePATPercentButton: UIButton!
    
    // Stats - Team 1 PATs - Averages
    @IBOutlet weak var team1AvgPATsMadeButton: UIButton!
    @IBOutlet weak var team1AvgPATsAttemptedButton: UIButton!
    @IBOutlet weak var team1AvgPATPercentButton: UIButton!
    
    // Stats - Team 1 Misc - Game
    @IBOutlet weak var team1GameTDsButton: UIButton!
    @IBOutlet weak var team1Game2PTsButton: UIButton!
    @IBOutlet weak var team1GameIntCaughtButton: UIButton!
    
    // Stats - Team 1 Misc - Averages
    @IBOutlet weak var team1AvgTDsButton: UIButton!
    @IBOutlet weak var team1Avg2PTsButton: UIButton!
    @IBOutlet weak var team1AvgIntCaughtButton: UIButton!
    
    // 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
    // 🔸 MARK: - OUTLETS - TEAM 2 STATS
    
    // Stats - Team 2 Pass Completion - Game
    @IBOutlet weak var team2GameCompletionsButton: UIButton!
    @IBOutlet weak var team2GamePassesAttemptedButton: UIButton!
    @IBOutlet weak var team2GameCompletionPercentButton: UIButton!
    @IBOutlet weak var team2GameIntThrownButton: UIButton!
    
    // Stats - Team 2 Pass Completion - Averages
    @IBOutlet weak var team2AvgCompletionsButton: UIButton!
    @IBOutlet weak var team2AvgPassesAttemptedButton: UIButton!
    @IBOutlet weak var team2AvgCompletionPercentButton: UIButton!
    @IBOutlet weak var team2AvgIntThrownButton: UIButton!
    
    // Stats - Team 2 Field Goals - Game
    @IBOutlet weak var team2GameFieldGoalsButton: UIButton!
    @IBOutlet weak var team2GameFieldGoalsAttemptedButton: UIButton!
    @IBOutlet weak var team2GameFieldGoalPercentButton: UIButton!
    
    // Stats - Team 2 Field Goals - Averages
    @IBOutlet weak var team2AvgFieldGoalsButton: UIButton!
    @IBOutlet weak var team2AvgFieldGoalsAttemptedButton: UIButton!
    @IBOutlet weak var team2AvgFieldGoalPercentButton: UIButton!
    
    // Stats - Team 2 PATs - Game
    @IBOutlet weak var team2GamePATsMadeButton: UIButton!
    @IBOutlet weak var team2GamePATsAttemptedButton: UIButton!
    @IBOutlet weak var team2GamePATPercentButton: UIButton!
    
    // Stats - Team 2 PATs - Averages
    @IBOutlet weak var team2AvgPATsMadeButton: UIButton!
    @IBOutlet weak var team2AvgPATsAttemptedButton: UIButton!
    @IBOutlet weak var team2AvgPATPercentButton: UIButton!
    
    // Stats - Team 2 Misc - Game
    @IBOutlet weak var team2GameTDsButton: UIButton!
    @IBOutlet weak var team2Game2PTsButton: UIButton!
    @IBOutlet weak var team2GameIntCaughtButton: UIButton!
    
    // Stats - Team 2 Misc - Averages
    @IBOutlet weak var team2AvgTDsButton: UIButton!
    @IBOutlet weak var team2Avg2PTsButton: UIButton!
    @IBOutlet weak var team2AvgIntCaughtButton: UIButton!
    
    // Array of Team Buttons (to set button backgrounds)
    @IBOutlet var team1Buttons: [UIButton]!
    @IBOutlet var team2Buttons: [UIButton]!
    
    // 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
    // 🔸 MARK: - VIEW DID LOAD
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let game = selectedGame {
            GameController.shared.fetchTeamsFor(game: game) { (success) in
                if success {
                    print("Do something?")
                    self.updateAverages()
                }
            }
        }
        
        // Set stat cell background colors
        setCellBackgroundColor()
        updateViews()
    }
    
    // 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
    // 🔸 MARK: - UPDATE VIEWS FUNCTION
    
    func updateViews() {
        guard let game = selectedGame else { return }
        
        // 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
        // 🔸 MARK: - UPDATE TEAM HEADERS
        
        // Team 1 header
        team1NameLabel.text = "\(game.team1Name.uppercased())"
        team1CoachLabel.text = game.team1Coach
//        team1RecordLabel
//        team1RankImageView
        team1HelmetButton.setBackgroundImage(UIImage(named: "helmet\(game.team1Color)Left"), for: .normal)
        team1HelmetLetterImageView.image = UIImage(named: "letter\(game.team1Name.prefix(1).capitalized)")
        
        // Team 2 header
        team2NameLabel.text = "\(game.team2Name.uppercased())"
        team2CoachLabel.text = game.team2Coach
        //        team2RecordLabel
        //        team2RankImageView
        team2HelmetButton.setBackgroundImage(UIImage(named: "helmet\(game.team2Color)Right"), for: .normal)
        team2HelmetLetterImageView.image = UIImage(named: "letter\(game.team2Name.prefix(1).capitalized)")
        
        // 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
        // 🔸 MARK: - UPDATE TEAM 1 STATS
        
        // Stats - Team 1 Pass Completion - Game
        team1GameCompletionsButton.setTitle("\(game.team1CompletionsMade)", for: .normal)
        team1GamePassesAttemptedButton.setTitle("\(game.team1CompletionsAttempted)", for: .normal)
        
            // For percentage calculation: Check to see if denominator is zero
            if game.team1CompletionsAttempted == 0 {
                team1GameCompletionPercentButton.setTitle("0%", for: .normal)
            } else {
                let percentage = getPercentageString(numerator: game.team1CompletionsMade, denominator: game.team1CompletionsAttempted)
                team1GameCompletionPercentButton.setTitle(percentage, for: .normal)
            }
        team1GameIntThrownButton.setTitle("\(game.team1InterceptionsThrown)", for: .normal)
        
        // Stats - Team 1 Pass Completion - Averages
        team1AvgCompletionsButton.setTitle("0.0", for: .normal)
        team1AvgPassesAttemptedButton.setTitle("0.0", for: .normal)
        team1AvgCompletionPercentButton.setTitle("0%", for: .normal)
        team1AvgIntThrownButton.setTitle("0.0", for: .normal)
        
        // Stats - Team 1 Field Goals - Game
        team1GameFieldGoalsButton.setTitle("\(game.team1FieldGoalsMade)", for: .normal)
        team1GameFieldGoalsAttemptedButton.setTitle("\(game.team1FieldGoalsAttempted)", for: .normal)
        
            // For percentage calculation: Check to see if denominator is zero
            if game.team1FieldGoalsAttempted == 0 {
                team1GameFieldGoalPercentButton.setTitle("0%", for: .normal)
            } else {
                team1GameFieldGoalPercentButton.setTitle("\(game.team1FieldGoalsMade / game.team1FieldGoalsAttempted)%", for: .normal)
            }
        
        // Stats - Team 1 Field Goals - Averages
        team1AvgFieldGoalsButton.setTitle("0.0", for: .normal)
        team1AvgFieldGoalsAttemptedButton.setTitle("0.0", for: .normal)
        team1AvgFieldGoalPercentButton.setTitle("0%", for: .normal)
        
        // Stats - Team 1 PATs - Game
        team1GamePATsMadeButton.setTitle("\(game.team1PATsMade)", for: .normal)
        team1GamePATsAttemptedButton.setTitle("\(game.team1PATsAttempted)", for: .normal)
        
            // For percentage calculation: Check to see if denominator is zero
            if game.team1PATsAttempted == 0 {
                team1GamePATPercentButton.setTitle("0%", for: .normal)
            } else {
                team1GamePATPercentButton.setTitle("\(game.team1PATsMade / game.team1PATsAttempted)%", for: .normal)
            }
        
        // Stats - Team 1 PATs - Averages
        team1AvgPATsMadeButton.setTitle("0.0", for: .normal)
        team1AvgPATsAttemptedButton.setTitle("0.0", for: .normal)
        team1AvgPATPercentButton.setTitle("0%", for: .normal)
        
        // Stats - Team 1 Misc - Game
        team1GameTDsButton.setTitle("\(game.team1Touchdowns)", for: .normal)
        team1Game2PTsButton.setTitle("\(game.team1TwoPointConversions)", for: .normal)
        team1GameIntCaughtButton.setTitle("\(game.team1InterceptionsCaught)", for: .normal)
        
        // Stats - Team 1 Misc - Averages
        team1AvgTDsButton.setTitle("0.0", for: .normal)
        team1Avg2PTsButton.setTitle("0.0", for: .normal)
        team1AvgIntCaughtButton.setTitle("0.0", for: .normal)
        
        // 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
        // 🔸 MARK: - UPDATE TEAM 2 STATS
            
        // Stats - Team 2 Pass Completion - Game
        team2GameCompletionsButton.setTitle("\(game.team2CompletionsMade)", for: .normal)
        team2GamePassesAttemptedButton.setTitle("\(game.team2CompletionsAttempted)", for: .normal)
        team2GameCompletionPercentButton.setTitle("0%", for: .normal)
        
        // For percentage calculation: Check to see if denominator is zero
        if game.team2CompletionsAttempted == 0 {
            team2GameCompletionPercentButton.setTitle("0%", for: .normal)
        } else {
            team2GameCompletionPercentButton.setTitle("\(game.team2CompletionsMade / game.team2CompletionsAttempted)%", for: .normal)
        }
        
        team2GameIntThrownButton.setTitle("\(game.team2InterceptionsThrown)", for: .normal)
        
        // Stats - Team 2 Pass Completion - Averages
        team2AvgCompletionsButton.setTitle("0.0", for: .normal)
        team2AvgPassesAttemptedButton.setTitle("0.0", for: .normal)
        team2AvgCompletionPercentButton.setTitle("0%", for: .normal)
        team2AvgIntThrownButton.setTitle("0.0", for: .normal)
        
        // Stats - Team 2 Field Goals - Game
        team2GameFieldGoalsButton.setTitle("\(game.team2FieldGoalsMade)", for: .normal)
        team2GameFieldGoalsAttemptedButton.setTitle("\(game.team2FieldGoalsAttempted)", for: .normal)
        
            // For percentage calculation: Check to see if denominator is zero
            if game.team2FieldGoalsAttempted == 0 {
                team2GameFieldGoalPercentButton.setTitle("0%", for: .normal)
            } else {
                team2GameFieldGoalPercentButton.setTitle("\(game.team2FieldGoalsMade / game.team2FieldGoalsAttempted)%", for: .normal)
            }
        
        // Stats - Team 2 Field Goals - Averages
        team2AvgFieldGoalsButton.setTitle("0.0", for: .normal)
        team2AvgFieldGoalsAttemptedButton.setTitle("0.0", for: .normal)
        team2AvgFieldGoalPercentButton.setTitle("0.0", for: .normal)
        
        // Stats - Team 2 PATs - Game
        team2GamePATsMadeButton.setTitle("\(game.team2PATsMade)", for: .normal)
        team2GamePATsAttemptedButton.setTitle("\(game.team2PATsAttempted)", for: .normal)
        
        // Stats - Team 2 PATs - Averages
        team2AvgPATsMadeButton.setTitle("0.0", for: .normal)
        team2AvgPATsAttemptedButton.setTitle("0.0", for: .normal)
        team2AvgPATPercentButton.setTitle("0.0", for: .normal)
        
        // Stats - Team 2 Misc - Game
        team2GameTDsButton.setTitle("\(game.team2Touchdowns)", for: .normal)
        team2Game2PTsButton.setTitle("\(game.team2TwoPointConversions)", for: .normal)
        team2GameIntCaughtButton.setTitle("\(game.team2InterceptionsCaught)", for: .normal)
        
        // Stats - Team 2 Misc - Averages
        team2AvgTDsButton.setTitle("0.0", for: .normal)
        team2Avg2PTsButton.setTitle("0.0", for: .normal)
        team2AvgIntCaughtButton.setTitle("0.0", for: .normal)
    }
    
    // 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
    // 🔸 MARK: - SWITCH STAT CELL COLOR FUNCTION
    
    func setCellBackgroundColor() {
        
        guard let game = selectedGame else { return }
        let color1 = UIColor(named: game.team1Color)
        let color2 = UIColor(named: game.team2Color)
        
        for button in team1Buttons {
            button.backgroundColor = color1
        }
        for button in team2Buttons {
            button.backgroundColor = color2
        }
    }
    
    // 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
    // 🔸 MARK: - ACTIONS - TEAM HEADERS, SCORE, AND CLOCK
    
    // Headers
    @IBAction func team1HelmetTapped(_ sender: Any) {
    }
    
    @IBAction func team2HelmetTapped(_ sender: Any) {
    }
    
    // Clock buttons and exit
    @IBAction func rewindButtonTapped(_ sender: Any) {
    }
    
    @IBAction func forwardButtonTapped(_ sender: Any) {
    }
    
    @IBAction func playPauseButtonTapped(_ sender: Any) {
    }
    
    @IBAction func exitButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
    // 🔸 MARK: - ACTIONS - TEAM 1 STATS BUTTONS
    
    // Stats - Team 1 Pass Completion - Add
    @IBAction func team1AddCompletionMadeButton(_ sender: Any) {
        
        guard let game = selectedGame else { print("Error unwrapping game") ; return }
        guard let team = game.team1 else { print("Error unwrapping team") ; return }
        guard let gamesPlayed = game.team1?.gamesPlayed else { print("Error unwrapping games played") ; return }
        
        // Cell labels
        let cellA1 = team1GameCompletionsButton
        let cellA2 = team1GamePassesAttemptedButton
        let cellA3 = team1GameCompletionPercentButton
        let cellB1 = team1AvgCompletionsButton
        let cellB2 = team1AvgPassesAttemptedButton
        let cellB3 = team1AvgCompletionPercentButton
        
        //update source of truth
        game.team1CompletionsMade += 1
        game.team1CompletionsAttempted += 1
        team.completionsMade += 1
        team.completionsAttempted += 1
        
        // Model object properties
        let gameCountA1 = game.team1CompletionsMade
        let gameCountA2 = game.team1CompletionsAttempted
        let teamAvgA1 = team.completionsMade
        let teamAvgA2 = team.completionsAttempted
        
        // Update stat labels
        cellA1?.setTitle("\(gameCountA1)", for: .normal)
        cellA2?.setTitle("\(gameCountA2)", for: .normal)
        cellB1?.setTitle(String(format: "%.1f", Double(teamAvgA1 / (gamesPlayed + 1))), for: .normal)
        cellB2?.setTitle(String(format: "%.1f", Double(teamAvgA2 / (gamesPlayed + 1))), for: .normal)
        
        // Update percentage lables
        if gameCountA2 == 0 {
            cellA3?.setTitle("0%", for: .normal)
        } else {
            let percentage = getPercentageString(numerator: gameCountA1, denominator: gameCountA2)
            cellA3?.setTitle(percentage, for: .normal)
        }

        if teamAvgA2 == 0 {
            cellB3?.setTitle("0%", for: .normal)
        } else {
            let percentage = getPercentageString(numerator: teamAvgA1, denominator: teamAvgA2)
            cellB3?.setTitle(percentage, for: .normal)
        }
    }
    
    @IBAction func team1AddCompletionMissedButton(_ sender: Any) {

        guard let game = selectedGame else { print("Error unwrapping game") ; return }
        guard let team = game.team1 else { print("Error unwrapping team") ; return }
        guard let gamesPlayed = game.team1?.gamesPlayed else { print("Error unwrapping games played") ; return }
        
        // Cell labels
        let cellA1 = team1GameCompletionsButton
        let cellA2 = team1GamePassesAttemptedButton
        let cellA3 = team1GameCompletionPercentButton
        let cellB1 = team1AvgCompletionsButton
        let cellB2 = team1AvgPassesAttemptedButton
        let cellB3 = team1AvgCompletionPercentButton
        
        //update source of truth
        game.team1CompletionsMade += 0
        game.team1CompletionsAttempted += 1
        team.completionsMade += 0
        team.completionsAttempted += 1
        
        // Model object properties
        let gameCountA1 = game.team1CompletionsMade
        let gameCountA2 = game.team1CompletionsAttempted
        let teamAvgA1 = team.completionsMade
        let teamAvgA2 = team.completionsAttempted
        
        // Update stat labels
        cellA1?.setTitle("\(gameCountA1)", for: .normal)
        cellA2?.setTitle("\(gameCountA2)", for: .normal)
        cellB1?.setTitle(String(format: "%.1f", Double(teamAvgA1 / (gamesPlayed + 1))), for: .normal)
        cellB2?.setTitle(String(format: "%.1f", Double(teamAvgA2 / (gamesPlayed + 1))), for: .normal)
        
        // Update percentage lables
        if gameCountA2 == 0 {
            cellA3?.setTitle("0%", for: .normal)
        } else {
            let percentage = getPercentageString(numerator: gameCountA1, denominator: gameCountA2)
            cellA3?.setTitle(percentage, for: .normal)
        }
        
        if teamAvgA2 == 0 {
            cellB3?.setTitle("0%", for: .normal)
        } else {
            let percentage = getPercentageString(numerator: teamAvgA1, denominator: teamAvgA2)
            cellB3?.setTitle(percentage, for: .normal)
        }
    }
    
    @IBAction func team1AddInterceptionThrownButton(_ sender: Any) {
        
        guard let game = selectedGame else { print("Error unwrapping game") ; return }
        guard let team = game.team1 else { print("Error unwrapping team") ; return }
        guard let gamesPlayed = game.team1?.gamesPlayed else { print("Error unwrapping games played") ; return }
        
        // Cell labels
        let cellA1 = team1GameIntThrownButton
        let cellB1 = team1AvgIntThrownButton
        
        //update source of truth
        game.team1InterceptionsThrown += 1
        team.interceptionsThrown += 1
        
        // Model object properties
        let gameCountA1 = game.team1InterceptionsThrown
        let teamAvgA1 = team.interceptionsThrown
        
        // Update stat labels
        cellA1?.setTitle("\(gameCountA1)", for: .normal)
        cellB1?.setTitle(String(format: "%.1f", Double(teamAvgA1 / (gamesPlayed + 1))), for: .normal)
    }
    
    // Stats - Team 1 Pass Completion - Subtract
    @IBAction func team1SubtractCompletionMadeButton(_ sender: Any) {
        
        guard let game = selectedGame else { print("Error unwrapping game") ; return }
        guard let team = game.team1 else { print("Error unwrapping team") ; return }
        guard let gamesPlayed = game.team1?.gamesPlayed else { print("Error unwrapping games played") ; return }
        
        // Guard against subtracting to negative numbers
        if game.team1CompletionsMade == 0 || team.completionsMade == 0 { return }
        
        // Cell labels
        let cellA1 = team1GameCompletionsButton
        let cellA2 = team1GamePassesAttemptedButton
        let cellA3 = team1GameCompletionPercentButton
        let cellB1 = team1AvgCompletionsButton
        let cellB2 = team1AvgPassesAttemptedButton
        let cellB3 = team1AvgCompletionPercentButton
        
        //update source of truth
        game.team1CompletionsMade -= 1
        game.team1CompletionsAttempted -= 0
        team.completionsMade -= 1
        team.completionsAttempted -= 0
        
        // Model object properties
        let gameCountA1 = game.team1CompletionsMade
        let gameCountA2 = game.team1CompletionsAttempted
        let teamAvgA1 = team.completionsMade
        let teamAvgA2 = team.completionsAttempted
        
        // Update stat labels
        cellA1?.setTitle("\(gameCountA1)", for: .normal)
        cellA2?.setTitle("\(gameCountA2)", for: .normal)
        cellB1?.setTitle(String(format: "%.1f", Double(teamAvgA1 / (gamesPlayed + 1))), for: .normal)
        cellB2?.setTitle(String(format: "%.1f", Double(teamAvgA2 / (gamesPlayed + 1))), for: .normal)
        
        // Update percentage lables
        if gameCountA2 == 0 {
            cellA3?.setTitle("0%", for: .normal)
        } else {
            let percentage = getPercentageString(numerator: gameCountA1, denominator: gameCountA2)
            cellA3?.setTitle(percentage, for: .normal)
        }
        
        if teamAvgA2 == 0 {
            cellB3?.setTitle("0%", for: .normal)
        } else {
            let percentage = getPercentageString(numerator: teamAvgA1, denominator: teamAvgA2)
            cellB3?.setTitle(percentage, for: .normal)
        }
    }
    
    @IBAction func team1SubtractCompletionMissedButton(_ sender: Any) {
        
        guard let game = selectedGame else { print("Error unwrapping game") ; return }
        guard let team = game.team1 else { print("Error unwrapping team") ; return }
        guard let gamesPlayed = game.team1?.gamesPlayed else { print("Error unwrapping games played") ; return }
        
        // Guard against subtracting to negative numbers
        if game.team1CompletionsAttempted == 0 || team.completionsAttempted == 0 { return }
        
        // Cell labels
        let cellA1 = team1GameCompletionsButton
        let cellA2 = team1GamePassesAttemptedButton
        let cellA3 = team1GameCompletionPercentButton
        let cellB1 = team1AvgCompletionsButton
        let cellB2 = team1AvgPassesAttemptedButton
        let cellB3 = team1AvgCompletionPercentButton
        
        //update source of truth
        game.team1CompletionsMade += 0
        game.team1CompletionsAttempted -= 1
        team.completionsMade += 0
        team.completionsAttempted -= 1
        
        // Model object properties
        let gameCountA1 = game.team1CompletionsMade
        let gameCountA2 = game.team1CompletionsAttempted
        let teamAvgA1 = team.completionsMade
        let teamAvgA2 = team.completionsAttempted
        
        // Update stat labels
        cellA1?.setTitle("\(gameCountA1)", for: .normal)
        cellA2?.setTitle("\(gameCountA2)", for: .normal)
        cellB1?.setTitle(String(format: "%.1f", Double(teamAvgA1 / (gamesPlayed + 1))), for: .normal)
        cellB2?.setTitle(String(format: "%.1f", Double(teamAvgA2 / (gamesPlayed + 1))), for: .normal)
        
        // Update percentage lables
        if gameCountA2 == 0 {
            cellA3?.setTitle("0%", for: .normal)
        } else {
            let percentage = getPercentageString(numerator: gameCountA1, denominator: gameCountA2)
            cellA3?.setTitle(percentage, for: .normal)
        }
        
        if teamAvgA2 == 0 {
            cellB3?.setTitle("0%", for: .normal)
        } else {
            let percentage = getPercentageString(numerator: teamAvgA1, denominator: teamAvgA2)
            cellB3?.setTitle(percentage, for: .normal)
        }
    }
    
    @IBAction func team1SubtractInterceptionThrownButton(_ sender: Any) {
        
        guard let game = selectedGame else { print("Error unwrapping game") ; return }
        guard let team = game.team1 else { print("Error unwrapping team") ; return }
        guard let gamesPlayed = game.team1?.gamesPlayed else { print("Error unwrapping games played") ; return }
        
        // Guard against subtracting to negative numbers
        if game.team1InterceptionsThrown == 0 { return }
        
        // Cell labels
        let cellA1 = team1GameIntThrownButton
        let cellB1 = team1AvgIntThrownButton
        
        //update source of truth
        game.team1InterceptionsThrown -= 1
        team.interceptionsThrown -= 1
        
        // Model object properties
        let gameCountA1 = game.team1InterceptionsThrown
        let teamAvgA1 = team.interceptionsThrown
        
        // Update stat labels
        cellA1?.setTitle("\(gameCountA1)", for: .normal)
        cellB1?.setTitle(String(format: "%.1f", Double(teamAvgA1 / (gamesPlayed + 1))), for: .normal)
    }
    
    // Stats - Team 1 Field Goals - Add
    @IBAction func team1AddFieldGoalMadeButton(_ sender: Any) {
        
        guard let game = selectedGame else { print("Error unwrapping game") ; return }
        guard let team = game.team1 else { print("Error unwrapping team") ; return }
        guard let gamesPlayed = game.team1?.gamesPlayed else { print("Error unwrapping games played") ; return }
        
        // Cell labels
        let cellA1 = team1GameFieldGoalsButton
        let cellA2 = team1GameFieldGoalsAttemptedButton
        let cellA3 = team1GameFieldGoalPercentButton
        let cellB1 = team1AvgFieldGoalsButton
        let cellB2 = team1AvgFieldGoalsAttemptedButton
        let cellB3 = team1AvgFieldGoalPercentButton
        
        //update source of truth
        game.team1FieldGoalsMade += 1
        game.team1FieldGoalsAttempted += 1
        team.fieldGoalsMade += 1
        team.fieldGoalsAttempted += 1
        
        // Model object properties
        let gameCountA1 = game.team1FieldGoalsMade
        let gameCountA2 = game.team1FieldGoalsAttempted
        let teamAvgA1 = team.fieldGoalsMade
        let teamAvgA2 = team.fieldGoalsAttempted
        
        // Update stat labels
        cellA1?.setTitle("\(gameCountA1)", for: .normal)
        cellA2?.setTitle("\(gameCountA2)", for: .normal)
        cellB1?.setTitle(String(format: "%.1f", Double(teamAvgA1 / (gamesPlayed + 1))), for: .normal)
        cellB2?.setTitle(String(format: "%.1f", Double(teamAvgA2 / (gamesPlayed + 1))), for: .normal)
        
        // Update percentage lables
        if gameCountA2 == 0 {
            cellA3?.setTitle("0%", for: .normal)
        } else {
            let percentage = getPercentageString(numerator: gameCountA1, denominator: gameCountA2)
            cellA3?.setTitle(percentage, for: .normal)
        }
        
        if teamAvgA2 == 0 {
            cellB3?.setTitle("0%", for: .normal)
        } else {
            let percentage = getPercentageString(numerator: teamAvgA1, denominator: teamAvgA2)
            cellB3?.setTitle(percentage, for: .normal)
        }
    }
    
    @IBAction func team1AddFieldGoalMissedButton(_ sender: Any) {
        
        guard let game = selectedGame else { print("Error unwrapping game") ; return }
        guard let team = game.team1 else { print("Error unwrapping team") ; return }
        guard let gamesPlayed = game.team1?.gamesPlayed else { print("Error unwrapping games played") ; return }
        
        // Cell labels
        let cellA1 = team1GameFieldGoalsButton
        let cellA2 = team1GameFieldGoalsAttemptedButton
        let cellA3 = team1GameFieldGoalPercentButton
        let cellB1 = team1AvgFieldGoalsButton
        let cellB2 = team1AvgFieldGoalsAttemptedButton
        let cellB3 = team1AvgFieldGoalPercentButton
        
        //update source of truth
        game.team1FieldGoalsMade += 0
        game.team1FieldGoalsAttempted += 1
        team.fieldGoalsMade += 0
        team.fieldGoalsAttempted += 1
        
        // Model object properties
        let gameCountA1 = game.team1FieldGoalsMade
        let gameCountA2 = game.team1FieldGoalsAttempted
        let teamAvgA1 = team.fieldGoalsMade
        let teamAvgA2 = team.fieldGoalsAttempted
        
        // Update stat labels
        cellA1?.setTitle("\(gameCountA1)", for: .normal)
        cellA2?.setTitle("\(gameCountA2)", for: .normal)
        cellB1?.setTitle(String(format: "%.1f", Double(teamAvgA1 / (gamesPlayed + 1))), for: .normal)
        cellB2?.setTitle(String(format: "%.1f", Double(teamAvgA2 / (gamesPlayed + 1))), for: .normal)
        
        // Update percentage lables
        if gameCountA2 == 0 {
            cellA3?.setTitle("0%", for: .normal)
        } else {
            let percentage = getPercentageString(numerator: gameCountA1, denominator: gameCountA2)
            cellA3?.setTitle(percentage, for: .normal)
        }
        
        if teamAvgA2 == 0 {
            cellB3?.setTitle("0%", for: .normal)
        } else {
            let percentage = getPercentageString(numerator: teamAvgA1, denominator: teamAvgA2)
            cellB3?.setTitle(percentage, for: .normal)
        }
    }
    
    // Stats - Team 1 Field Goals - Subtract
    @IBAction func team1SubtractFieldGoalMadeButton(_ sender: Any) {
        
        guard let game = selectedGame else { print("Error unwrapping game") ; return }
        guard let team = game.team1 else { print("Error unwrapping team") ; return }
        guard let gamesPlayed = game.team1?.gamesPlayed else { print("Error unwrapping games played") ; return }
        
        // Guard against subtracting to negative numbers
        if game.team1FieldGoalsMade == 0 || team.fieldGoalsMade == 0 { return }
        
        // Cell labels
        let cellA1 = team1GameFieldGoalsButton
        let cellA2 = team1GameFieldGoalsAttemptedButton
        let cellA3 = team1GameFieldGoalPercentButton
        let cellB1 = team1AvgFieldGoalsButton
        let cellB2 = team1AvgFieldGoalsAttemptedButton
        let cellB3 = team1AvgFieldGoalPercentButton
        
        //update source of truth
        game.team1FieldGoalsMade -= 1
        game.team1FieldGoalsAttempted -= 0
        team.fieldGoalsMade -= 1
        team.fieldGoalsAttempted -= 0
        
        // Model object properties
        let gameCountA1 = game.team1FieldGoalsMade
        let gameCountA2 = game.team1FieldGoalsAttempted
        let teamAvgA1 = team.fieldGoalsMade
        let teamAvgA2 = team.fieldGoalsAttempted
        
        // Update stat labels
        cellA1?.setTitle("\(gameCountA1)", for: .normal)
        cellA2?.setTitle("\(gameCountA2)", for: .normal)
        cellB1?.setTitle(String(format: "%.1f", Double(teamAvgA1 / (gamesPlayed + 1))), for: .normal)
        cellB2?.setTitle(String(format: "%.1f", Double(teamAvgA2 / (gamesPlayed + 1))), for: .normal)
        
        // Update percentage lables
        if gameCountA2 == 0 {
            cellA3?.setTitle("0%", for: .normal)
        } else {
            let percentage = getPercentageString(numerator: gameCountA1, denominator: gameCountA2)
            cellA3?.setTitle(percentage, for: .normal)
        }
        
        if teamAvgA2 == 0 {
            cellB3?.setTitle("0%", for: .normal)
        } else {
            let percentage = getPercentageString(numerator: teamAvgA1, denominator: teamAvgA2)
            cellB3?.setTitle(percentage, for: .normal)
        }
    }
    
    @IBAction func team1SubractFieldGoalMissedButton(_ sender: Any) {
        
        guard let game = selectedGame else { print("Error unwrapping game") ; return }
        guard let team = game.team1 else { print("Error unwrapping team") ; return }
        guard let gamesPlayed = game.team1?.gamesPlayed else { print("Error unwrapping games played") ; return }
        
        // Guard against subtracting to negative numbers
        if game.team1FieldGoalsAttempted == 0 || team.fieldGoalsAttempted == 0 { return }
        
        // Cell labels
        let cellA1 = team1GameFieldGoalsButton
        let cellA2 = team1GameFieldGoalsAttemptedButton
        let cellA3 = team1GameFieldGoalPercentButton
        let cellB1 = team1AvgFieldGoalsButton
        let cellB2 = team1AvgFieldGoalsAttemptedButton
        let cellB3 = team1AvgFieldGoalPercentButton
        
        //update source of truth
        game.team1FieldGoalsMade -= 0
        game.team1FieldGoalsAttempted -= 1
        team.fieldGoalsMade -= 0
        team.fieldGoalsAttempted -= 1
        
        // Model object properties
        let gameCountA1 = game.team1FieldGoalsMade
        let gameCountA2 = game.team1FieldGoalsAttempted
        let teamAvgA1 = team.fieldGoalsMade
        let teamAvgA2 = team.fieldGoalsAttempted
        
        // Update stat labels
        cellA1?.setTitle("\(gameCountA1)", for: .normal)
        cellA2?.setTitle("\(gameCountA2)", for: .normal)
        cellB1?.setTitle(String(format: "%.1f", Double(teamAvgA1 / (gamesPlayed + 1))), for: .normal)
        cellB2?.setTitle(String(format: "%.1f", Double(teamAvgA2 / (gamesPlayed + 1))), for: .normal)
        
        // Update percentage lables
        if gameCountA2 == 0 {
            cellA3?.setTitle("0%", for: .normal)
        } else {
            let percentage = getPercentageString(numerator: gameCountA1, denominator: gameCountA2)
            cellA3?.setTitle(percentage, for: .normal)
        }
        
        if teamAvgA2 == 0 {
            cellB3?.setTitle("0%", for: .normal)
        } else {
            let percentage = getPercentageString(numerator: teamAvgA1, denominator: teamAvgA2)
            cellB3?.setTitle(percentage, for: .normal)
        }
    }
    
    // Stats - Team 1 PATs - Add
    @IBAction func team1AddPATMadeButton(_ sender: Any) {
        
        guard let game = selectedGame else { print("Error unwrapping game") ; return }
        guard let team = game.team1 else { print("Error unwrapping team") ; return }
        guard let gamesPlayed = game.team1?.gamesPlayed else { print("Error unwrapping games played") ; return }
        
        // Cell labels
        let cellA1 = team1GamePATsMadeButton
        let cellA2 = team1GamePATsAttemptedButton
        let cellA3 = team1GamePATPercentButton
        let cellB1 = team1AvgPATsMadeButton
        let cellB2 = team1AvgPATsAttemptedButton
        let cellB3 = team1AvgPATPercentButton
        
        //update source of truth
        game.team1PATsMade += 1
        game.team1PATsAttempted += 1
        team.pATsMade += 1
        team.pATsAttempted += 1
        
        // Model object properties
        let gameCountA1 = game.team1PATsMade
        let gameCountA2 = game.team1PATsAttempted
        let teamAvgA1 = team.pATsMade
        let teamAvgA2 = team.pATsAttempted
        
        // Update stat labels
        cellA1?.setTitle("\(gameCountA1)", for: .normal)
        cellA2?.setTitle("\(gameCountA2)", for: .normal)
        cellB1?.setTitle(String(format: "%.1f", Double(teamAvgA1 / (gamesPlayed + 1))), for: .normal)
        cellB2?.setTitle(String(format: "%.1f", Double(teamAvgA2 / (gamesPlayed + 1))), for: .normal)
        
        // Update percentage lables
        if gameCountA2 == 0 {
            cellA3?.setTitle("0%", for: .normal)
        } else {
            let percentage = getPercentageString(numerator: gameCountA1, denominator: gameCountA2)
            cellA3?.setTitle(percentage, for: .normal)
        }
        
        if teamAvgA2 == 0 {
            cellB3?.setTitle("0%", for: .normal)
        } else {
            let percentage = getPercentageString(numerator: teamAvgA1, denominator: teamAvgA2)
            cellB3?.setTitle(percentage, for: .normal)
        }
    }
    
    @IBAction func team1AddPATMIssedButton(_ sender: Any) {
        
        guard let game = selectedGame else { print("Error unwrapping game") ; return }
        guard let team = game.team1 else { print("Error unwrapping team") ; return }
        guard let gamesPlayed = game.team1?.gamesPlayed else { print("Error unwrapping games played") ; return }
        
        // Cell labels
        let cellA1 = team1GamePATsMadeButton
        let cellA2 = team1GamePATsAttemptedButton
        let cellA3 = team1GamePATPercentButton
        let cellB1 = team1AvgPATsMadeButton
        let cellB2 = team1AvgPATsAttemptedButton
        let cellB3 = team1AvgPATPercentButton
        
        //update source of truth
        game.team1PATsMade += 0
        game.team1PATsAttempted += 1
        team.pATsMade += 0
        team.pATsAttempted += 1
        
        // Model object properties
        let gameCountA1 = game.team1PATsMade
        let gameCountA2 = game.team1PATsAttempted
        let teamAvgA1 = team.pATsMade
        let teamAvgA2 = team.pATsAttempted
        
        // Update stat labels
        cellA1?.setTitle("\(gameCountA1)", for: .normal)
        cellA2?.setTitle("\(gameCountA2)", for: .normal)
        cellB1?.setTitle(String(format: "%.1f", Double(teamAvgA1 / (gamesPlayed + 1))), for: .normal)
        cellB2?.setTitle(String(format: "%.1f", Double(teamAvgA2 / (gamesPlayed + 1))), for: .normal)
        
        // Update percentage lables
        if gameCountA2 == 0 {
            cellA3?.setTitle("0%", for: .normal)
        } else {
            let percentage = getPercentageString(numerator: gameCountA1, denominator: gameCountA2)
            cellA3?.setTitle(percentage, for: .normal)
        }
        
        if teamAvgA2 == 0 {
            cellB3?.setTitle("0%", for: .normal)
        } else {
            let percentage = getPercentageString(numerator: teamAvgA1, denominator: teamAvgA2)
            cellB3?.setTitle(percentage, for: .normal)
        }
    }
    
    // Stats - Team 1 PATs - Subtract
    @IBAction func team1SubtractPATMadeButton(_ sender: Any) {
        
        guard let game = selectedGame else { print("Error unwrapping game") ; return }
        guard let team = game.team1 else { print("Error unwrapping team") ; return }
        guard let gamesPlayed = game.team1?.gamesPlayed else { print("Error unwrapping games played") ; return }
        
        // Guard against subtracting to negative numbers
        if game.team1PATsMade == 0 || team.pATsMade == 0 { return }
        
        // Cell labels
        let cellA1 = team1GamePATsMadeButton
        let cellA2 = team1GamePATsAttemptedButton
        let cellA3 = team1GamePATPercentButton
        let cellB1 = team1AvgPATsMadeButton
        let cellB2 = team1AvgPATsAttemptedButton
        let cellB3 = team1AvgPATPercentButton
        
        //update source of truth
        game.team1PATsMade -= 1
        game.team1PATsAttempted -= 0
        team.pATsMade -= 1
        team.pATsAttempted -= 0
        
        // Model object properties
        let gameCountA1 = game.team1PATsMade
        let gameCountA2 = game.team1PATsAttempted
        let teamAvgA1 = team.pATsMade
        let teamAvgA2 = team.pATsAttempted
        
        // Update stat labels
        cellA1?.setTitle("\(gameCountA1)", for: .normal)
        cellA2?.setTitle("\(gameCountA2)", for: .normal)
        cellB1?.setTitle(String(format: "%.1f", Double(teamAvgA1 / (gamesPlayed + 1))), for: .normal)
        cellB2?.setTitle(String(format: "%.1f", Double(teamAvgA2 / (gamesPlayed + 1))), for: .normal)
        
        // Update percentage lables
        if gameCountA2 == 0 {
            cellA3?.setTitle("0%", for: .normal)
        } else {
            let percentage = getPercentageString(numerator: gameCountA1, denominator: gameCountA2)
            cellA3?.setTitle(percentage, for: .normal)
        }
        
        if teamAvgA2 == 0 {
            cellB3?.setTitle("0%", for: .normal)
        } else {
            let percentage = getPercentageString(numerator: teamAvgA1, denominator: teamAvgA2)
            cellB3?.setTitle(percentage, for: .normal)
        }
    }
    
    @IBAction func team1SubractPATMIssedButton(_ sender: Any) {
        
        guard let game = selectedGame else { print("Error unwrapping game") ; return }
        guard let team = game.team1 else { print("Error unwrapping team") ; return }
        guard let gamesPlayed = game.team1?.gamesPlayed else { print("Error unwrapping games played") ; return }
        
        // Guard against subtracting to negative numbers
        if game.team1PATsAttempted == 0 || team.pATsAttempted == 0 { return }
        
        // Cell labels
        let cellA1 = team1GamePATsMadeButton
        let cellA2 = team1GamePATsAttemptedButton
        let cellA3 = team1GamePATPercentButton
        let cellB1 = team1AvgPATsMadeButton
        let cellB2 = team1AvgPATsAttemptedButton
        let cellB3 = team1AvgPATPercentButton
        
        //update source of truth
        game.team1PATsMade -= 0
        game.team1PATsAttempted -= 1
        team.pATsMade -= 0
        team.pATsAttempted -= 1
        
        // Model object properties
        let gameCountA1 = game.team1PATsMade
        let gameCountA2 = game.team1PATsAttempted
        let teamAvgA1 = team.pATsMade
        let teamAvgA2 = team.pATsAttempted
        
        // Update stat labels
        cellA1?.setTitle("\(gameCountA1)", for: .normal)
        cellA2?.setTitle("\(gameCountA2)", for: .normal)
        cellB1?.setTitle(String(format: "%.1f", Double(teamAvgA1 / (gamesPlayed + 1))), for: .normal)
        cellB2?.setTitle(String(format: "%.1f", Double(teamAvgA2 / (gamesPlayed + 1))), for: .normal)
        
        // Update percentage lables
        if gameCountA2 == 0 {
            cellA3?.setTitle("0%", for: .normal)
        } else {
            let percentage = getPercentageString(numerator: gameCountA1, denominator: gameCountA2)
            cellA3?.setTitle(percentage, for: .normal)
        }
        
        if teamAvgA2 == 0 {
            cellB3?.setTitle("0%", for: .normal)
        } else {
            let percentage = getPercentageString(numerator: teamAvgA1, denominator: teamAvgA2)
            cellB3?.setTitle(percentage, for: .normal)
        }
    }
    
    // Stats - Team 1 Misc - Add
    @IBAction func team1AddTDMadeButton(_ sender: Any) {
        
        guard let game = selectedGame else { print("Error unwrapping game") ; return }
        guard let team = game.team1 else { print("Error unwrapping team") ; return }
        guard let gamesPlayed = game.team1?.gamesPlayed else { print("Error unwrapping games played") ; return }
        
        // Cell labels
        let cellA1 = team1GameTDsButton
        let cellB1 = team1AvgTDsButton
        
        //update source of truth
        game.team1Touchdowns += 1
        team.touchdowns += 1
        
        // Model object properties
        let gameCountA1 = game.team1Touchdowns
        let teamAvgA1 = team.touchdowns
        
        // Update stat labels
        cellA1?.setTitle("\(gameCountA1)", for: .normal)
        cellB1?.setTitle(String(format: "%.1f", Double(teamAvgA1 / (gamesPlayed + 1))), for: .normal)
    }
    
    @IBAction func team1Add2PTMadeButton(_ sender: Any) {
        
        guard let game = selectedGame else { print("Error unwrapping game") ; return }
        guard let team = game.team1 else { print("Error unwrapping team") ; return }
        guard let gamesPlayed = game.team1?.gamesPlayed else { print("Error unwrapping games played") ; return }
        
        // Cell labels
        let cellA1 = team1Game2PTsButton
        let cellB1 = team1Avg2PTsButton
        
        //update source of truth
        game.team1TwoPointConversions += 1
        team.twoPointConversions += 1
        
        // Model object properties
        let gameCountA1 = game.team1TwoPointConversions
        let teamAvgA1 = team.twoPointConversions
        
        // Update stat labels
        cellA1?.setTitle("\(gameCountA1)", for: .normal)
        cellB1?.setTitle(String(format: "%.1f", Double(teamAvgA1 / (gamesPlayed + 1))), for: .normal)
    }
    
    @IBAction func teeam1AddInterceptionCaughtButton(_ sender: Any) {
        
        guard let game = selectedGame else { print("Error unwrapping game") ; return }
        guard let team = game.team1 else { print("Error unwrapping team") ; return }
        guard let gamesPlayed = game.team1?.gamesPlayed else { print("Error unwrapping games played") ; return }
        
        // Cell labels
        let cellA1 = team1GameIntCaughtButton
        let cellB1 = team1AvgIntCaughtButton
        
        //update source of truth
        game.team1InterceptionsCaught += 1
        team.interceptionsCaught += 1
        
        // Model object properties
        let gameCountA1 = game.team1InterceptionsCaught
        let teamAvgA1 = team.interceptionsCaught
        
        // Update stat labels
        cellA1?.setTitle("\(gameCountA1)", for: .normal)
        cellB1?.setTitle(String(format: "%.1f", Double(teamAvgA1 / (gamesPlayed + 1))), for: .normal)
    }
    
    // Stats - Team 1 Misc - Subtract
    @IBAction func team1SubtractTDMadeButton(_ sender: Any) {
        
        guard let game = selectedGame else { print("Error unwrapping game") ; return }
        guard let team = game.team1 else { print("Error unwrapping team") ; return }
        guard let gamesPlayed = game.team1?.gamesPlayed else { print("Error unwrapping games played") ; return }
        
        
        // Guard against subtracting to negative numbers
        if game.team1Touchdowns == 0 { return }
        
        // Cell labels
        let cellA1 = team1GameTDsButton
        let cellB1 = team1AvgTDsButton
        
        //update source of truth
        game.team1Touchdowns -= 1
        team.touchdowns -= 1
        
        // Model object properties
        let gameCountA1 = game.team1Touchdowns
        let teamAvgA1 = team.touchdowns
        
        // Update stat labels
        cellA1?.setTitle("\(gameCountA1)", for: .normal)
        cellB1?.setTitle(String(format: "%.1f", Double(teamAvgA1 / (gamesPlayed + 1))), for: .normal)
    }
    
    @IBAction func team1Subtract2PTMadeButton(_ sender: Any) {
        
        guard let game = selectedGame else { print("Error unwrapping game") ; return }
        guard let team = game.team1 else { print("Error unwrapping team") ; return }
        guard let gamesPlayed = game.team1?.gamesPlayed else { print("Error unwrapping games played") ; return }
        
        // Guard against subtracting to negative numbers
        if game.team1TwoPointConversions == 0 { return }
        
        // Cell labels
        let cellA1 = team1Game2PTsButton
        let cellB1 = team1Avg2PTsButton
        
        //update source of truth
        game.team1TwoPointConversions -= 1
        team.twoPointConversions -= 1
        
        // Model object properties
        let gameCountA1 = game.team1TwoPointConversions
        let teamAvgA1 = team.twoPointConversions
        
        // Update stat labels
        cellA1?.setTitle("\(gameCountA1)", for: .normal)
        cellB1?.setTitle(String(format: "%.1f", Double(teamAvgA1 / (gamesPlayed + 1))), for: .normal)
    }
    
    @IBAction func teeam1SubtractInterceptionCaughtButton(_ sender: Any) {
        
        guard let game = selectedGame else { print("Error unwrapping game") ; return }
        guard let team = game.team1 else { print("Error unwrapping team") ; return }
        guard let gamesPlayed = game.team1?.gamesPlayed else { print("Error unwrapping games played") ; return }
        
        // Guard against subtracting to negative numbers
        if game.team1InterceptionsCaught == 0 { return }
        
        // Cell labels
        let cellA1 = team1GameIntCaughtButton
        let cellB1 = team1AvgIntCaughtButton
        
        //update source of truth
        game.team1InterceptionsCaught -= 1
        team.interceptionsCaught -= 1
        
        // Model object properties
        let gameCountA1 = game.team1InterceptionsCaught
        let teamAvgA1 = team.interceptionsCaught
        
        // Update stat labels
        cellA1?.setTitle("\(gameCountA1)", for: .normal)
        cellB1?.setTitle(String(format: "%.1f", Double(teamAvgA1 / (gamesPlayed + 1))), for: .normal)
    }
    
    // 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
    // 🔸 MARK: - ACTIONS - TEAM 2 STATS BUTTONS
    
    // Stats - Team 2 Pass Completion - Add
    @IBAction func team2AddCompletionMadeButton(_ sender: Any) {
        
        guard let game = selectedGame else { print("Error unwrapping game") ; return }
        guard let team = game.team2 else { print("Error unwrapping team") ; return }
        guard let gamesPlayed = game.team2?.gamesPlayed else { print("Error unwrapping games played") ; return }
        
        // Cell labels
        let cellA1 = team2GameCompletionsButton
        let cellA2 = team2GamePassesAttemptedButton
        let cellA3 = team2GameCompletionPercentButton
        let cellB1 = team2AvgCompletionsButton
        let cellB2 = team2AvgPassesAttemptedButton
        let cellB3 = team2AvgCompletionPercentButton
        
        //update source of truth
        game.team2CompletionsMade += 1
        game.team2CompletionsAttempted += 1
        team.completionsMade += 1
        team.completionsAttempted += 1
        
        // Model object properties
        let gameCountA1 = game.team2CompletionsMade
        let gameCountA2 = game.team2CompletionsAttempted
        let teamAvgA1 = team.completionsMade
        let teamAvgA2 = team.completionsAttempted
        
        // Update stat labels
        cellA1?.setTitle("\(gameCountA1)", for: .normal)
        cellA2?.setTitle("\(gameCountA2)", for: .normal)
        cellB1?.setTitle(String(format: "%.1f", Double(teamAvgA1 / (gamesPlayed + 1))), for: .normal)
        cellB2?.setTitle(String(format: "%.1f", Double(teamAvgA2 / (gamesPlayed + 1))), for: .normal)
        
        // Update percentage lables
        if gameCountA2 == 0 {
            cellA3?.setTitle("0%", for: .normal)
        } else {
            let percentage = getPercentageString(numerator: gameCountA1, denominator: gameCountA2)
            cellA3?.setTitle(percentage, for: .normal)
        }
        
        if teamAvgA2 == 0 {
            cellB3?.setTitle("0%", for: .normal)
        } else {
            let percentage = getPercentageString(numerator: teamAvgA1, denominator: teamAvgA2)
            cellB3?.setTitle(percentage, for: .normal)
        }
    }
    
    @IBAction func team2AddCompletionMissedButton(_ sender: Any) {
        
        guard let game = selectedGame else { print("Error unwrapping game") ; return }
        guard let team = game.team2 else { print("Error unwrapping team") ; return }
        guard let gamesPlayed = game.team2?.gamesPlayed else { print("Error unwrapping games played") ; return }
        
        // Cell labels
        let cellA1 = team2GameCompletionsButton
        let cellA2 = team2GamePassesAttemptedButton
        let cellA3 = team2GameCompletionPercentButton
        let cellB1 = team2AvgCompletionsButton
        let cellB2 = team2AvgPassesAttemptedButton
        let cellB3 = team2AvgCompletionPercentButton
        
        //update source of truth
        game.team2CompletionsMade += 0
        game.team2CompletionsAttempted += 1
        team.completionsMade += 0
        team.completionsAttempted += 1
        
        // Model object properties
        let gameCountA1 = game.team2CompletionsMade
        let gameCountA2 = game.team2CompletionsAttempted
        let teamAvgA1 = team.completionsMade
        let teamAvgA2 = team.completionsAttempted
        
        // Update stat labels
        cellA1?.setTitle("\(gameCountA1)", for: .normal)
        cellA2?.setTitle("\(gameCountA2)", for: .normal)
        cellB1?.setTitle(String(format: "%.1f", Double(teamAvgA1 / (gamesPlayed + 1))), for: .normal)
        cellB2?.setTitle(String(format: "%.1f", Double(teamAvgA2 / (gamesPlayed + 1))), for: .normal)
        
        // Update percentage lables
        if gameCountA2 == 0 {
            cellA3?.setTitle("0%", for: .normal)
        } else {
            let percentage = getPercentageString(numerator: gameCountA1, denominator: gameCountA2)
            cellA3?.setTitle(percentage, for: .normal)
        }
        
        if teamAvgA2 == 0 {
            cellB3?.setTitle("0%", for: .normal)
        } else {
            let percentage = getPercentageString(numerator: teamAvgA1, denominator: teamAvgA2)
            cellB3?.setTitle(percentage, for: .normal)
        }
    }
    
    @IBAction func team2AddInterceptionThrownButton(_ sender: Any) {
        
        guard let game = selectedGame else { print("Error unwrapping game") ; return }
        guard let team = game.team2 else { print("Error unwrapping team") ; return }
        guard let gamesPlayed = game.team2?.gamesPlayed else { print("Error unwrapping games played") ; return }
        
        // Cell labels
        let cellA1 = team2GameIntThrownButton
        let cellB1 = team2AvgIntThrownButton
        
        //update source of truth
        game.team2InterceptionsThrown += 1
        team.interceptionsThrown += 1
        
        // Model object properties
        let gameCountA1 = game.team2InterceptionsThrown
        let teamAvgA1 = team.interceptionsThrown
        
        // Update stat labels
        cellA1?.setTitle("\(gameCountA1)", for: .normal)
        cellB1?.setTitle(String(format: "%.1f", Double(teamAvgA1 / (gamesPlayed + 1))), for: .normal)
    }
    
    // Stats - Team 2 Pass Completion - Subtract
    @IBAction func team2SubtractCompletionMadeButton(_ sender: Any) {
        
        guard let game = selectedGame else { print("Error unwrapping game") ; return }
        guard let team = game.team2 else { print("Error unwrapping team") ; return }
        guard let gamesPlayed = game.team2?.gamesPlayed else { print("Error unwrapping games played") ; return }
        
        // Guard against subtracting to negative numbers
        if game.team2CompletionsMade == 0 || team.completionsMade == 0 { return }
        
        // Cell labels
        let cellA1 = team2GameCompletionsButton
        let cellA2 = team2GamePassesAttemptedButton
        let cellA3 = team2GameCompletionPercentButton
        let cellB1 = team2AvgCompletionsButton
        let cellB2 = team2AvgPassesAttemptedButton
        let cellB3 = team2AvgCompletionPercentButton
        
        //update source of truth
        game.team2CompletionsMade -= 1
        game.team2CompletionsAttempted -= 0
        team.completionsMade -= 1
        team.completionsAttempted -= 0
        
        // Model object properties
        let gameCountA1 = game.team2CompletionsMade
        let gameCountA2 = game.team2CompletionsAttempted
        let teamAvgA1 = team.completionsMade
        let teamAvgA2 = team.completionsAttempted
        
        // Update stat labels
        cellA1?.setTitle("\(gameCountA1)", for: .normal)
        cellA2?.setTitle("\(gameCountA2)", for: .normal)
        cellB1?.setTitle(String(format: "%.1f", Double(teamAvgA1 / (gamesPlayed + 1))), for: .normal)
        cellB2?.setTitle(String(format: "%.1f", Double(teamAvgA2 / (gamesPlayed + 1))), for: .normal)
        
        // Update percentage lables
        if gameCountA2 == 0 {
            cellA3?.setTitle("0%", for: .normal)
        } else {
            let percentage = getPercentageString(numerator: gameCountA1, denominator: gameCountA2)
            cellA3?.setTitle(percentage, for: .normal)
        }
        
        if teamAvgA2 == 0 {
            cellB3?.setTitle("0%", for: .normal)
        } else {
            let percentage = getPercentageString(numerator: teamAvgA1, denominator: teamAvgA2)
            cellB3?.setTitle(percentage, for: .normal)
        }
    }
    
    @IBAction func team2SubtractCompletionMissedButton(_ sender: Any) {
        
        guard let game = selectedGame else { print("Error unwrapping game") ; return }
        guard let team = game.team2 else { print("Error unwrapping team") ; return }
        guard let gamesPlayed = game.team2?.gamesPlayed else { print("Error unwrapping games played") ; return }
        
        // Guard against subtracting to negative numbers
        if game.team2CompletionsAttempted == 0 || team.completionsAttempted == 0 { return }
        
        // Cell labels
        let cellA1 = team2GameCompletionsButton
        let cellA2 = team2GamePassesAttemptedButton
        let cellA3 = team2GameCompletionPercentButton
        let cellB1 = team2AvgCompletionsButton
        let cellB2 = team2AvgPassesAttemptedButton
        let cellB3 = team2AvgCompletionPercentButton
        
        //update source of truth
        game.team2CompletionsMade += 0
        game.team2CompletionsAttempted -= 1
        team.completionsMade += 0
        team.completionsAttempted -= 1
        
        // Model object properties
        let gameCountA1 = game.team2CompletionsMade
        let gameCountA2 = game.team2CompletionsAttempted
        let teamAvgA1 = team.completionsMade
        let teamAvgA2 = team.completionsAttempted
        
        // Update stat labels
        cellA1?.setTitle("\(gameCountA1)", for: .normal)
        cellA2?.setTitle("\(gameCountA2)", for: .normal)
        cellB1?.setTitle(String(format: "%.1f", Double(teamAvgA1 / (gamesPlayed + 1))), for: .normal)
        cellB2?.setTitle(String(format: "%.1f", Double(teamAvgA2 / (gamesPlayed + 1))), for: .normal)
        
        // Update percentage lables
        if gameCountA2 == 0 {
            cellA3?.setTitle("0%", for: .normal)
        } else {
            let percentage = getPercentageString(numerator: gameCountA1, denominator: gameCountA2)
            cellA3?.setTitle(percentage, for: .normal)
        }
        
        if teamAvgA2 == 0 {
            cellB3?.setTitle("0%", for: .normal)
        } else {
            let percentage = getPercentageString(numerator: teamAvgA1, denominator: teamAvgA2)
            cellB3?.setTitle(percentage, for: .normal)
        }
    }
    
    @IBAction func team2SubtractInterceptionThrownButton(_ sender: Any) {
        
        guard let game = selectedGame else { print("Error unwrapping game") ; return }
        guard let team = game.team2 else { print("Error unwrapping team") ; return }
        guard let gamesPlayed = game.team2?.gamesPlayed else { print("Error unwrapping games played") ; return }
        
        // Guard against subtracting to negative numbers
        if game.team2InterceptionsThrown == 0 { return }
        
        // Cell labels
        let cellA1 = team2GameIntThrownButton
        let cellB1 = team2AvgIntThrownButton
        
        //update source of truth
        game.team2InterceptionsThrown -= 1
        team.interceptionsThrown -= 1
        
        // Model object properties
        let gameCountA1 = game.team2InterceptionsThrown
        let teamAvgA1 = team.interceptionsThrown
        
        // Update stat labels
        cellA1?.setTitle("\(gameCountA1)", for: .normal)
        cellB1?.setTitle(String(format: "%.1f", Double(teamAvgA1 / (gamesPlayed + 1))), for: .normal)
    }
    
    // Stats - Team 2 Field Goals - Add
    @IBAction func team2AddFieldGoalMadeButton(_ sender: Any) {
        
        guard let game = selectedGame else { print("Error unwrapping game") ; return }
        guard let team = game.team2 else { print("Error unwrapping team") ; return }
        guard let gamesPlayed = game.team2?.gamesPlayed else { print("Error unwrapping games played") ; return }
        
        // Cell labels
        let cellA1 = team2GameFieldGoalsButton
        let cellA2 = team2GameFieldGoalsAttemptedButton
        let cellA3 = team2GameFieldGoalPercentButton
        let cellB1 = team2AvgFieldGoalsButton
        let cellB2 = team2AvgFieldGoalsAttemptedButton
        let cellB3 = team2AvgFieldGoalPercentButton
        
        //update source of truth
        game.team2FieldGoalsMade += 1
        game.team2FieldGoalsAttempted += 1
        team.fieldGoalsMade += 1
        team.fieldGoalsAttempted += 1
        
        // Model object properties
        let gameCountA1 = game.team2FieldGoalsMade
        let gameCountA2 = game.team2FieldGoalsAttempted
        let teamAvgA1 = team.fieldGoalsMade
        let teamAvgA2 = team.fieldGoalsAttempted
        
        // Update stat labels
        cellA1?.setTitle("\(gameCountA1)", for: .normal)
        cellA2?.setTitle("\(gameCountA2)", for: .normal)
        cellB1?.setTitle(String(format: "%.1f", Double(teamAvgA1 / (gamesPlayed + 1))), for: .normal)
        cellB2?.setTitle(String(format: "%.1f", Double(teamAvgA2 / (gamesPlayed + 1))), for: .normal)
        
        // Update percentage lables
        if gameCountA2 == 0 {
            cellA3?.setTitle("0%", for: .normal)
        } else {
            let percentage = getPercentageString(numerator: gameCountA1, denominator: gameCountA2)
            cellA3?.setTitle(percentage, for: .normal)
        }
        
        if teamAvgA2 == 0 {
            cellB3?.setTitle("0%", for: .normal)
        } else {
            let percentage = getPercentageString(numerator: teamAvgA1, denominator: teamAvgA2)
            cellB3?.setTitle(percentage, for: .normal)
        }
    }
    
    @IBAction func team2AddFieldGoalMissedButton(_ sender: Any) {
        
        guard let game = selectedGame else { print("Error unwrapping game") ; return }
        guard let team = game.team2 else { print("Error unwrapping team") ; return }
        guard let gamesPlayed = game.team2?.gamesPlayed else { print("Error unwrapping games played") ; return }
        
        // Cell labels
        let cellA1 = team2GameFieldGoalsButton
        let cellA2 = team2GameFieldGoalsAttemptedButton
        let cellA3 = team2GameFieldGoalPercentButton
        let cellB1 = team2AvgFieldGoalsButton
        let cellB2 = team2AvgFieldGoalsAttemptedButton
        let cellB3 = team2AvgFieldGoalPercentButton
        
        //update source of truth
        game.team2FieldGoalsMade += 0
        game.team2FieldGoalsAttempted += 1
        team.fieldGoalsMade += 0
        team.fieldGoalsAttempted += 1
        
        // Model object properties
        let gameCountA1 = game.team2FieldGoalsMade
        let gameCountA2 = game.team2FieldGoalsAttempted
        let teamAvgA1 = team.fieldGoalsMade
        let teamAvgA2 = team.fieldGoalsAttempted
        
        // Update stat labels
        cellA1?.setTitle("\(gameCountA1)", for: .normal)
        cellA2?.setTitle("\(gameCountA2)", for: .normal)
        cellB1?.setTitle(String(format: "%.1f", Double(teamAvgA1 / (gamesPlayed + 1))), for: .normal)
        cellB2?.setTitle(String(format: "%.1f", Double(teamAvgA2 / (gamesPlayed + 1))), for: .normal)
        
        // Update percentage lables
        if gameCountA2 == 0 {
            cellA3?.setTitle("0%", for: .normal)
        } else {
            let percentage = getPercentageString(numerator: gameCountA1, denominator: gameCountA2)
            cellA3?.setTitle(percentage, for: .normal)
        }
        
        if teamAvgA2 == 0 {
            cellB3?.setTitle("0%", for: .normal)
        } else {
            let percentage = getPercentageString(numerator: teamAvgA1, denominator: teamAvgA2)
            cellB3?.setTitle(percentage, for: .normal)
        }
    }
    
    // Stats - Team 2 Field Goals - Subtract
    @IBAction func team2SubtractFieldGoalMadeButton(_ sender: Any) {
        
        guard let game = selectedGame else { print("Error unwrapping game") ; return }
        guard let team = game.team2 else { print("Error unwrapping team") ; return }
        guard let gamesPlayed = game.team2?.gamesPlayed else { print("Error unwrapping games played") ; return }
        
        // Guard against subtracting to negative numbers
        if game.team2FieldGoalsMade == 0 || team.fieldGoalsMade == 0 { return }
        
        // Cell labels
        let cellA1 = team2GameFieldGoalsButton
        let cellA2 = team2GameFieldGoalsAttemptedButton
        let cellA3 = team2GameFieldGoalPercentButton
        let cellB1 = team2AvgFieldGoalsButton
        let cellB2 = team2AvgFieldGoalsAttemptedButton
        let cellB3 = team2AvgFieldGoalPercentButton
        
        //update source of truth
        game.team2FieldGoalsMade -= 1
        game.team2FieldGoalsAttempted -= 0
        team.fieldGoalsMade -= 1
        team.fieldGoalsAttempted -= 0
        
        // Model object properties
        let gameCountA1 = game.team2FieldGoalsMade
        let gameCountA2 = game.team2FieldGoalsAttempted
        let teamAvgA1 = team.fieldGoalsMade
        let teamAvgA2 = team.fieldGoalsAttempted
        
        // Update stat labels
        cellA1?.setTitle("\(gameCountA1)", for: .normal)
        cellA2?.setTitle("\(gameCountA2)", for: .normal)
        cellB1?.setTitle(String(format: "%.1f", Double(teamAvgA1 / (gamesPlayed + 1))), for: .normal)
        cellB2?.setTitle(String(format: "%.1f", Double(teamAvgA2 / (gamesPlayed + 1))), for: .normal)
        
        // Update percentage lables
        if gameCountA2 == 0 {
            cellA3?.setTitle("0%", for: .normal)
        } else {
            let percentage = getPercentageString(numerator: gameCountA1, denominator: gameCountA2)
            cellA3?.setTitle(percentage, for: .normal)
        }
        
        if teamAvgA2 == 0 {
            cellB3?.setTitle("0%", for: .normal)
        } else {
            let percentage = getPercentageString(numerator: teamAvgA1, denominator: teamAvgA2)
            cellB3?.setTitle(percentage, for: .normal)
        }
    }
    
    @IBAction func team2SubractFieldGoalMissedButton(_ sender: Any) {
        
        guard let game = selectedGame else { print("Error unwrapping game") ; return }
        guard let team = game.team2 else { print("Error unwrapping team") ; return }
        guard let gamesPlayed = game.team2?.gamesPlayed else { print("Error unwrapping games played") ; return }
        
        // Guard against subtracting to negative numbers
        if game.team2FieldGoalsAttempted == 0 || team.fieldGoalsAttempted == 0 { return }
        
        // Cell labels
        let cellA1 = team2GameFieldGoalsButton
        let cellA2 = team2GameFieldGoalsAttemptedButton
        let cellA3 = team2GameFieldGoalPercentButton
        let cellB1 = team2AvgFieldGoalsButton
        let cellB2 = team2AvgFieldGoalsAttemptedButton
        let cellB3 = team2AvgFieldGoalPercentButton
        
        //update source of truth
        game.team2FieldGoalsMade -= 0
        game.team2FieldGoalsAttempted -= 1
        team.fieldGoalsMade -= 0
        team.fieldGoalsAttempted -= 1
        
        // Model object properties
        let gameCountA1 = game.team2FieldGoalsMade
        let gameCountA2 = game.team2FieldGoalsAttempted
        let teamAvgA1 = team.fieldGoalsMade
        let teamAvgA2 = team.fieldGoalsAttempted
        
        // Update stat labels
        cellA1?.setTitle("\(gameCountA1)", for: .normal)
        cellA2?.setTitle("\(gameCountA2)", for: .normal)
        cellB1?.setTitle(String(format: "%.1f", Double(teamAvgA1 / (gamesPlayed + 1))), for: .normal)
        cellB2?.setTitle(String(format: "%.1f", Double(teamAvgA2 / (gamesPlayed + 1))), for: .normal)
        
        // Update percentage lables
        if gameCountA2 == 0 {
            cellA3?.setTitle("0%", for: .normal)
        } else {
            let percentage = getPercentageString(numerator: gameCountA1, denominator: gameCountA2)
            cellA3?.setTitle(percentage, for: .normal)
        }
        
        if teamAvgA2 == 0 {
            cellB3?.setTitle("0%", for: .normal)
        } else {
            let percentage = getPercentageString(numerator: teamAvgA1, denominator: teamAvgA2)
            cellB3?.setTitle(percentage, for: .normal)
        }
    }
    
    // Stats - Team 2 PATs - Add
    @IBAction func team2AddPATMadeButton(_ sender: Any) {
        
        guard let game = selectedGame else { print("Error unwrapping game") ; return }
        guard let team = game.team2 else { print("Error unwrapping team") ; return }
        guard let gamesPlayed = game.team2?.gamesPlayed else { print("Error unwrapping games played") ; return }
        
        // Cell labels
        let cellA1 = team2GamePATsMadeButton
        let cellA2 = team2GamePATsAttemptedButton
        let cellA3 = team2GamePATPercentButton
        let cellB1 = team2AvgPATsMadeButton
        let cellB2 = team2AvgPATsAttemptedButton
        let cellB3 = team2AvgPATPercentButton
        
        //update source of truth
        game.team2PATsMade += 1
        game.team2PATsAttempted += 1
        team.pATsMade += 1
        team.pATsAttempted += 1
        
        // Model object properties
        let gameCountA1 = game.team2PATsMade
        let gameCountA2 = game.team2PATsAttempted
        let teamAvgA1 = team.pATsMade
        let teamAvgA2 = team.pATsAttempted
        
        // Update stat labels
        cellA1?.setTitle("\(gameCountA1)", for: .normal)
        cellA2?.setTitle("\(gameCountA2)", for: .normal)
        cellB1?.setTitle(String(format: "%.1f", Double(teamAvgA1 / (gamesPlayed + 1))), for: .normal)
        cellB2?.setTitle(String(format: "%.1f", Double(teamAvgA2 / (gamesPlayed + 1))), for: .normal)
        
        // Update percentage lables
        if gameCountA2 == 0 {
            cellA3?.setTitle("0%", for: .normal)
        } else {
            let percentage = getPercentageString(numerator: gameCountA1, denominator: gameCountA2)
            cellA3?.setTitle(percentage, for: .normal)
        }
        
        if teamAvgA2 == 0 {
            cellB3?.setTitle("0%", for: .normal)
        } else {
            let percentage = getPercentageString(numerator: teamAvgA1, denominator: teamAvgA2)
            cellB3?.setTitle(percentage, for: .normal)
        }
    }
    
    @IBAction func team2AddPATMIssedButton(_ sender: Any) {
        
        guard let game = selectedGame else { print("Error unwrapping game") ; return }
        guard let team = game.team2 else { print("Error unwrapping team") ; return }
        guard let gamesPlayed = game.team2?.gamesPlayed else { print("Error unwrapping games played") ; return }
        
        // Cell labels
        let cellA1 = team2GamePATsMadeButton
        let cellA2 = team2GamePATsAttemptedButton
        let cellA3 = team2GamePATPercentButton
        let cellB1 = team2AvgPATsMadeButton
        let cellB2 = team2AvgPATsAttemptedButton
        let cellB3 = team2AvgPATPercentButton
        
        //update source of truth
        game.team2PATsMade += 0
        game.team2PATsAttempted += 1
        team.pATsMade += 0
        team.pATsAttempted += 1
        
        // Model object properties
        let gameCountA1 = game.team2PATsMade
        let gameCountA2 = game.team2PATsAttempted
        let teamAvgA1 = team.pATsMade
        let teamAvgA2 = team.pATsAttempted
        
        // Update stat labels
        cellA1?.setTitle("\(gameCountA1)", for: .normal)
        cellA2?.setTitle("\(gameCountA2)", for: .normal)
        cellB1?.setTitle(String(format: "%.1f", Double(teamAvgA1 / (gamesPlayed + 1))), for: .normal)
        cellB2?.setTitle(String(format: "%.1f", Double(teamAvgA2 / (gamesPlayed + 1))), for: .normal)
        
        // Update percentage lables
        if gameCountA2 == 0 {
            cellA3?.setTitle("0%", for: .normal)
        } else {
            let percentage = getPercentageString(numerator: gameCountA1, denominator: gameCountA2)
            cellA3?.setTitle(percentage, for: .normal)
        }
        
        if teamAvgA2 == 0 {
            cellB3?.setTitle("0%", for: .normal)
        } else {
            let percentage = getPercentageString(numerator: teamAvgA1, denominator: teamAvgA2)
            cellB3?.setTitle(percentage, for: .normal)
        }
    }
    
    // Stats - Team 2 PATs - Subtract
    @IBAction func team2SubtractPATMadeButton(_ sender: Any) {
        
        guard let game = selectedGame else { print("Error unwrapping game") ; return }
        guard let team = game.team2 else { print("Error unwrapping team") ; return }
        guard let gamesPlayed = game.team2?.gamesPlayed else { print("Error unwrapping games played") ; return }
        
        // Guard against subtracting to negative numbers
        if game.team2PATsMade == 0 || team.pATsMade == 0 { return }
        
        // Cell labels
        let cellA1 = team2GamePATsMadeButton
        let cellA2 = team2GamePATsAttemptedButton
        let cellA3 = team2GamePATPercentButton
        let cellB1 = team2AvgPATsMadeButton
        let cellB2 = team2AvgPATsAttemptedButton
        let cellB3 = team2AvgPATPercentButton
        
        //update source of truth
        game.team2PATsMade -= 1
        game.team2PATsAttempted -= 0
        team.pATsMade -= 1
        team.pATsAttempted -= 0
        
        // Model object properties
        let gameCountA1 = game.team2PATsMade
        let gameCountA2 = game.team2PATsAttempted
        let teamAvgA1 = team.pATsMade
        let teamAvgA2 = team.pATsAttempted
        
        // Update stat labels
        cellA1?.setTitle("\(gameCountA1)", for: .normal)
        cellA2?.setTitle("\(gameCountA2)", for: .normal)
        cellB1?.setTitle(String(format: "%.1f", Double(teamAvgA1 / (gamesPlayed + 1))), for: .normal)
        cellB2?.setTitle(String(format: "%.1f", Double(teamAvgA2 / (gamesPlayed + 1))), for: .normal)
        
        // Update percentage lables
        if gameCountA2 == 0 {
            cellA3?.setTitle("0%", for: .normal)
        } else {
            let percentage = getPercentageString(numerator: gameCountA1, denominator: gameCountA2)
            cellA3?.setTitle(percentage, for: .normal)
        }
        
        if teamAvgA2 == 0 {
            cellB3?.setTitle("0%", for: .normal)
        } else {
            let percentage = getPercentageString(numerator: teamAvgA1, denominator: teamAvgA2)
            cellB3?.setTitle(percentage, for: .normal)
        }
    }
    
    @IBAction func team2SubractPATMIssedButton(_ sender: Any) {
        
        guard let game = selectedGame else { print("Error unwrapping game") ; return }
        guard let team = game.team2 else { print("Error unwrapping team") ; return }
        guard let gamesPlayed = game.team2?.gamesPlayed else { print("Error unwrapping games played") ; return }
        
        // Guard against subtracting to negative numbers
        if game.team2PATsAttempted == 0 || team.pATsAttempted == 0 { return }
        
        // Cell labels
        let cellA1 = team2GamePATsMadeButton
        let cellA2 = team2GamePATsAttemptedButton
        let cellA3 = team2GamePATPercentButton
        let cellB1 = team2AvgPATsMadeButton
        let cellB2 = team2AvgPATsAttemptedButton
        let cellB3 = team2AvgPATPercentButton
        
        //update source of truth
        game.team2PATsMade -= 0
        game.team2PATsAttempted -= 1
        team.pATsMade -= 0
        team.pATsAttempted -= 1
        
        // Model object properties
        let gameCountA1 = game.team2PATsMade
        let gameCountA2 = game.team2PATsAttempted
        let teamAvgA1 = team.pATsMade
        let teamAvgA2 = team.pATsAttempted
        
        // Update stat labels
        cellA1?.setTitle("\(gameCountA1)", for: .normal)
        cellA2?.setTitle("\(gameCountA2)", for: .normal)
        cellB1?.setTitle(String(format: "%.1f", Double(teamAvgA1 / (gamesPlayed + 1))), for: .normal)
        cellB2?.setTitle(String(format: "%.1f", Double(teamAvgA2 / (gamesPlayed + 1))), for: .normal)
        
        // Update percentage lables
        if gameCountA2 == 0 {
            cellA3?.setTitle("0%", for: .normal)
        } else {
            let percentage = getPercentageString(numerator: gameCountA1, denominator: gameCountA2)
            cellA3?.setTitle(percentage, for: .normal)
        }
        
        if teamAvgA2 == 0 {
            cellB3?.setTitle("0%", for: .normal)
        } else {
            let percentage = getPercentageString(numerator: teamAvgA1, denominator: teamAvgA2)
            cellB3?.setTitle(percentage, for: .normal)
        }
    }
    
    // Stats - Team 2 Misc - Add
    @IBAction func team2AddTDMadeButton(_ sender: Any) {
        
        guard let game = selectedGame else { print("Error unwrapping game") ; return }
        guard let team = game.team2 else { print("Error unwrapping team") ; return }
        guard let gamesPlayed = game.team2?.gamesPlayed else { print("Error unwrapping games played") ; return }
        
        // Cell labels
        let cellA1 = team2GameTDsButton
        let cellB1 = team2AvgTDsButton
        
        //update source of truth
        game.team2Touchdowns += 1
        team.touchdowns += 1
        
        // Model object properties
        let gameCountA1 = game.team2Touchdowns
        let teamAvgA1 = team.touchdowns
        
        // Update stat labels
        cellA1?.setTitle("\(gameCountA1)", for: .normal)
        cellB1?.setTitle(String(format: "%.1f", Double(teamAvgA1 / (gamesPlayed + 1))), for: .normal)
    }
    
    @IBAction func team2Add2PTMadeButton(_ sender: Any) {
        
        guard let game = selectedGame else { print("Error unwrapping game") ; return }
        guard let team = game.team2 else { print("Error unwrapping team") ; return }
        guard let gamesPlayed = game.team2?.gamesPlayed else { print("Error unwrapping games played") ; return }
        
        // Cell labels
        let cellA1 = team2Game2PTsButton
        let cellB1 = team2Avg2PTsButton
        
        //update source of truth
        game.team2TwoPointConversions += 1
        team.twoPointConversions += 1
        
        // Model object properties
        let gameCountA1 = game.team2TwoPointConversions
        let teamAvgA1 = team.twoPointConversions
        
        // Update stat labels
        cellA1?.setTitle("\(gameCountA1)", for: .normal)
        cellB1?.setTitle(String(format: "%.1f", Double(teamAvgA1 / (gamesPlayed + 1))), for: .normal)
    }
    
    @IBAction func teeam2AddInterceptionCaughtButton(_ sender: Any) {
        
        guard let game = selectedGame else { print("Error unwrapping game") ; return }
        guard let team = game.team2 else { print("Error unwrapping team") ; return }
        guard let gamesPlayed = game.team2?.gamesPlayed else { print("Error unwrapping games played") ; return }
        
        // Cell labels
        let cellA1 = team2GameIntCaughtButton
        let cellB1 = team2AvgIntCaughtButton
        
        //update source of truth
        game.team2InterceptionsCaught += 1
        team.interceptionsCaught += 1
        
        // Model object properties
        let gameCountA1 = game.team2InterceptionsCaught
        let teamAvgA1 = team.interceptionsCaught
        
        // Update stat labels
        cellA1?.setTitle("\(gameCountA1)", for: .normal)
        cellB1?.setTitle(String(format: "%.1f", Double(teamAvgA1 / (gamesPlayed + 1))), for: .normal)
    }
    
    // Stats - Team 2 Misc - Subtract
    @IBAction func team2SubtractMadeButton(_ sender: Any) {
        
        guard let game = selectedGame else { print("Error unwrapping game") ; return }
        guard let team = game.team2 else { print("Error unwrapping team") ; return }
        guard let gamesPlayed = game.team2?.gamesPlayed else { print("Error unwrapping games played") ; return }
        
        
        // Guard against subtracting to negative numbers
        if game.team2Touchdowns == 0 { return }
        
        // Cell labels
        let cellA1 = team2GameTDsButton
        let cellB1 = team2AvgTDsButton
        
        //update source of truth
        game.team2Touchdowns -= 1
        team.touchdowns -= 1
        
        // Model object properties
        let gameCountA1 = game.team2Touchdowns
        let teamAvgA1 = team.touchdowns
        
        // Update stat labels
        cellA1?.setTitle("\(gameCountA1)", for: .normal)
        cellB1?.setTitle(String(format: "%.1f", Double(teamAvgA1 / (gamesPlayed + 1))), for: .normal)
    }
    
    @IBAction func team2Subtract2PTMadeButton(_ sender: Any) {
        
        guard let game = selectedGame else { print("Error unwrapping game") ; return }
        guard let team = game.team2 else { print("Error unwrapping team") ; return }
        guard let gamesPlayed = game.team2?.gamesPlayed else { print("Error unwrapping games played") ; return }
        
        // Guard against subtracting to negative numbers
        if game.team2TwoPointConversions == 0 { return }
        
        // Cell labels
        let cellA1 = team2Game2PTsButton
        let cellB1 = team2Avg2PTsButton
        
        //update source of truth
        game.team2TwoPointConversions -= 1
        team.twoPointConversions -= 1
        
        // Model object properties
        let gameCountA1 = game.team2TwoPointConversions
        let teamAvgA1 = team.twoPointConversions
        
        // Update stat labels
        cellA1?.setTitle("\(gameCountA1)", for: .normal)
        cellB1?.setTitle(String(format: "%.1f", Double(teamAvgA1 / (gamesPlayed + 1))), for: .normal)
    }
    
    @IBAction func teeam2SubtractInterceptionCaughtButton(_ sender: Any) {
        
        guard let game = selectedGame else { print("Error unwrapping game") ; return }
        guard let team = game.team2 else { print("Error unwrapping team") ; return }
        guard let gamesPlayed = game.team2?.gamesPlayed else { print("Error unwrapping games played") ; return }
        
        // Guard against subtracting to negative numbers
        if game.team2InterceptionsCaught == 0 { return }
        
        // Cell labels
        let cellA1 = team2GameIntCaughtButton
        let cellB1 = team2AvgIntCaughtButton
        
        //update source of truth
        game.team2InterceptionsCaught -= 1
        team.interceptionsCaught -= 1
        
        // Model object properties
        let gameCountA1 = game.team2InterceptionsCaught
        let teamAvgA1 = team.interceptionsCaught
        
        // Update stat labels
        cellA1?.setTitle("\(gameCountA1)", for: .normal)
        cellB1?.setTitle(String(format: "%.1f", Double(teamAvgA1 / (gamesPlayed + 1))), for: .normal)
    }
    
    // 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
    // 🔸 MARK: - FIRST TIME LABEL SET UP
    
    func updateAverages(){
        guard let game = selectedGame else { return }
        
        //team 1 completion avgs
        team1AvgCompletionsButton.setTitle("\(game.team1?.completionsMade ?? 0 / (game.team1?.gamesPlayed ?? 0 + 1))", for: .normal)
        
        //team 2 completion avgs
        team1AvgCompletionsButton.setTitle("\(game.team2?.completionsMade ?? 0 / (game.team2?.gamesPlayed ?? 0 + 1))", for: .normal)
    }
    
    // MARK: - NAVIGATION
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let team1 = selectedGame?.team1
        let team2 = selectedGame?.team2
        
        if segue.identifier == "fromTeam1" {
            if let destinationVC = segue.destination as? TeamStatsVC {
                let team = team1
                destinationVC.selectedTeam = team
            }
        } else {
            if let destinationVC = segue.destination as? TeamStatsVC {
                let team = team2
                destinationVC.selectedTeam = team
            }
        }
    }
}

// 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
// 🔸 MARK: - GET PERCENTAGE FUNCTION EXTENSION

extension ScoreboardVC {
    
    fileprivate func getPercentageString(numerator: Int, denominator: Int) -> String {
        
        let numeratorDouble = Double(numerator)
        let denominatorDouble = Double(denominator)
        let percent = Int((numeratorDouble / denominatorDouble) * 100)
        
        return "\(String(percent))%"
    }
}
