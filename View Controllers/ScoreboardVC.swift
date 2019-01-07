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
    @IBOutlet weak var team1AvgCoompletionsButton: UIButton!
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
    
    // Array of Team Buttons
    var team1Buttons: [UIButton] = []
    var team2Buttons: [UIButton] = []
    
    // 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
    // 🔸 MARK: - VIEW DID LOAD
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        team1Buttons = [
            
            // Stats - Team 1 Pass Completion - Game
            team1GameCompletionsButton,
            team1GamePassesAttemptedButton,
            team1GameCompletionPercentButton,
            team1GameIntThrownButton,
        
            // Stats - Team 1 Pass Completion - Averages
            team1AvgCoompletionsButton,
            team1AvgPassesAttemptedButton,
            team1AvgCompletionPercentButton,
            team1AvgIntThrownButton,
        
            // Stats - Team 1 Field Goals - Game
            team1GameFieldGoalsButton,
            team1GameFieldGoalsAttemptedButton,
            team1GameFieldGoalPercentButton,
        
            // Stats - Team 1 Field Goals - Averages
            team1AvgFieldGoalsButton,
            team1AvgFieldGoalsAttemptedButton,
            team1AvgFieldGoalPercentButton,
        
            // Stats - Team 1 PATs - Game
            team1GamePATsMadeButton,
            team1GamePATsAttemptedButton,
            team1GamePATPercentButton,
        
            // Stats - Team 1 PATs - Averages
            team1AvgPATsMadeButton,
            team1AvgPATsAttemptedButton,
            team1AvgPATPercentButton,
        
            // Stats - Team 1 Misc - Game
            team1GameTDsButton,
            team1Game2PTsButton,
            team1GameIntCaughtButton,
        
            // Stats - Team 1 Misc - Averages
            team1AvgTDsButton,
            team1Avg2PTsButton,
            team1AvgIntCaughtButton]
        
        team2Buttons = [
            
            // Stats - Team 2 Pass Completion - Game
            team2GameCompletionsButton,
            team2GamePassesAttemptedButton,
            team2GameCompletionPercentButton,
            team2GameIntThrownButton,
            
            // Stats - Team 2 Pass Completion - Averages
            team2AvgCompletionsButton,
            team2AvgPassesAttemptedButton,
            team2AvgCompletionPercentButton,
            team2AvgIntThrownButton,
            
            // Stats - Team 2 Field Goals - Game
            team2GameFieldGoalsButton,
            team2GameFieldGoalsAttemptedButton,
            team2GameFieldGoalPercentButton,
            
            // Stats - Team 2 Field Goals - Averages
            team2AvgFieldGoalsButton,
            team2AvgFieldGoalsAttemptedButton,
            team2AvgFieldGoalPercentButton,
            
            // Stats - Team 2 PATs - Game
            team2GamePATsMadeButton,
            team2GamePATsAttemptedButton,
            team2GamePATPercentButton,
            
            // Stats - Team 2 PATs - Averages
            team2AvgPATsMadeButton,
            team2AvgPATsAttemptedButton,
            team2AvgPATPercentButton,
            
            // Stats - Team 2 Misc - Game
            team2GameTDsButton,
            team2Game2PTsButton,
            team2GameIntCaughtButton,
            
            // Stats - Team 2 Misc - Averages
            team2AvgTDsButton,
            team2Avg2PTsButton,
            team2AvgIntCaughtButton]
        
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
        
        // Check to see if denominator is zero
        if game.team1CompletionsAttempted == 0 {
            team1GameCompletionPercentButton.setTitle("0%", for: .normal)
        } else {
            team1GameCompletionPercentButton.setTitle("\(game.team1CompletionsMade / game.team1CompletionsAttempted)%", for: .normal)
        }
        
        team1GameIntThrownButton.setTitle("\(game.team1InterceptionsThrown)", for: .normal)
        
        // Stats - Team 1 Pass Completion - Averages
        team1AvgCoompletionsButton.setTitle("ADD", for: .normal)
        team1AvgPassesAttemptedButton.setTitle("ADD", for: .normal)
        team1AvgCompletionPercentButton.setTitle("ADD", for: .normal)
        team1AvgIntThrownButton.setTitle("ADD", for: .normal)
        
        // Stats - Team 1 Field Goals - Game
        team1GameFieldGoalsButton.setTitle("\(game.team1FieldGoalsMade)", for: .normal)
        team1GameFieldGoalsAttemptedButton.setTitle("\(game.team1FieldGoalsAttempted)", for: .normal)
        team1GameFieldGoalPercentButton.setTitle("ADD", for: .normal)
        
        // Stats - Team 1 Field Goals - Averages
        team1AvgFieldGoalsButton.setTitle("ADD", for: .normal)
        team1AvgFieldGoalsAttemptedButton.setTitle("ADD", for: .normal)
        team1AvgFieldGoalPercentButton.setTitle("ADD", for: .normal)
        
        // Stats - Team 1 PATs - Game
        team1GamePATsMadeButton.setTitle("\(game.team1PATsMade)", for: .normal)
        team1GamePATsAttemptedButton.setTitle("\(game.team1PATsAttempted)", for: .normal)
        team1GamePATPercentButton.setTitle("ADD", for: .normal)
        
        // Stats - Team 1 PATs - Averages
        team1AvgPATsMadeButton.setTitle("ADD", for: .normal)
        team1AvgPATsAttemptedButton.setTitle("ADD", for: .normal)
        team1AvgPATPercentButton.setTitle("ADD", for: .normal)
        
        // Stats - Team 1 Misc - Game
        team1GameTDsButton.setTitle("\(game.team1Touchdowns)", for: .normal)
        team1Game2PTsButton.setTitle("\(game.team1TwoPointConversions)", for: .normal)
        team1GameIntCaughtButton.setTitle("\(game.team1InterceptionsCaught)", for: .normal)
        
        // Stats - Team 1 Misc - Averages
        team1AvgTDsButton.setTitle("ADD", for: .normal)
        team1Avg2PTsButton.setTitle("ADD", for: .normal)
        team1AvgIntCaughtButton.setTitle("ADD", for: .normal)
        
        // 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
        // 🔸 MARK: - UPDATE TEAM 2 STATS
            
        // Stats - Team 2 Pass Completion - Game
        team2GameCompletionsButton.setTitle("\(game.team2CompletionsMade)", for: .normal)
        team2GamePassesAttemptedButton.setTitle("\(game.team2CompletionsAttempted)", for: .normal)
        team2GameCompletionPercentButton.setTitle("ADD", for: .normal)
        team2GameIntThrownButton.setTitle("\(game.team2InterceptionsThrown)", for: .normal)
        
        // Stats - Team 2 Pass Completion - Averages
        team2AvgCoompletionsButton.setTitle("ADD", for: .normal)
        team2AvgPassesAttemptedButton.setTitle("ADD", for: .normal)
        team2AvgCompletionPercentButton.setTitle("ADD", for: .normal)
        team2AvgIntThrownButton.setTitle("ADD", for: .normal)
        
        // Stats - Team 2 Field Goals - Game
        team2GameFieldGoalsButton.setTitle("\(game.team2FieldGoalsMade)", for: .normal)
        team2GameFieldGoalsAttemptedButton.setTitle("\(game.team2FieldGoalsAttempted)", for: .normal)
        team2GameFieldGoalPercentButton.setTitle("ADD", for: .normal)
        
        // Stats - Team 2 Field Goals - Averages
        team2AvgFieldGoalsButton.setTitle("ADD", for: .normal)
        team2AvgFieldGoalsAttemptedButton.setTitle("ADD", for: .normal)
        team2AvgFieldGoalPercentButton.setTitle("ADD", for: .normal)
        
        // Stats - Team 2 PATs - Game
        team2GamePATsMadeButton.setTitle("\(game.team2PATsMade)", for: .normal)
        team2GamePATsAttemptedButton.setTitle("\(game.team2PATsAttempted)", for: .normal)
        team2GamePATPercentButton.setTitle("ADD", for: .normal)
        
        // Stats - Team 2 PATs - Averages
        team2AvgPATsMadeButton.setTitle("ADD", for: .normal)
        team2AvgPATsAttemptedButton.setTitle("ADD", for: .normal)
        team2AvgPATPercentButton.setTitle("ADD", for: .normal)
        
        // Stats - Team 2 Misc - Game
        team2GameTDsButton.setTitle("\(game.team2Touchdowns)", for: .normal)
        team2Game2PTsButton.setTitle("\(game.team2TwoPointConversions)", for: .normal)
        team2GameIntCaughtButton.setTitle("\(game.team2InterceptionsCaught)", for: .normal)
        
        // Stats - Team 2 Misc - Averages
        team2AvgTDsButton.setTitle("ADD", for: .normal)
        team2Avg2PTsButton.setTitle("ADD", for: .normal)
        team2AvgIntCaughtButton.setTitle("ADD", for: .normal)
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
    }
    
    @IBAction func team1AddCompletionMissedButton(_ sender: Any) {
    }
    
    @IBAction func team1AddInterceptionThrownButton(_ sender: Any) {
    }
    
    // Stats - Team 1 Pass Completion - Subtract
    @IBAction func team1SubtractCompletionMadeButton(_ sender: Any) {
    }
    
    @IBAction func team1SubtractCompletionMissedButton(_ sender: Any) {
    }
    
    @IBAction func team1SubtractInterceptionThrownButton(_ sender: Any) {
    }
    
    // Stats - Team 1 Field Goals - Add
    @IBAction func team1AddFieldGoalMadeButton(_ sender: Any) {
    }
    
    @IBAction func team1AddFieldGoalMissedButton(_ sender: Any) {
    }
    
    // Stats - Team 1 Field Goals - Subtract
    @IBAction func team1SubtractFieldGoalMadeButton(_ sender: Any) {
    }
    
    @IBAction func team1SubractFieldGoalMissedButton(_ sender: Any) {
    }
    
    // Stats - Team 1 PATs - Add
    @IBAction func team1AddPATMadeButton(_ sender: Any) {
    }
    
    @IBAction func team1AddPATMIssedButton(_ sender: Any) {
    }
    
    // Stats - Team 1 PATs - Subtract
    @IBAction func team1SubtractPATMadeButton(_ sender: Any) {
    }
    
    @IBAction func team1SubractPATMIssedButton(_ sender: Any) {
    }
    
    // Stats - Team 1 Misc - Add
    @IBAction func team1AddTDMadeButton(_ sender: Any) {
    }
    
    @IBAction func team1Add2PTMadeButton(_ sender: Any) {
    }
    
    @IBAction func teeam1AddInterceptionCaughtButton(_ sender: Any) {
    }
    
    // Stats - Team 1 Misc - Subtract
    @IBAction func team1SubtractMadeButton(_ sender: Any) {
    }
    
    @IBAction func team1Subtract2PTMadeButton(_ sender: Any) {
    }
    
    @IBAction func teeam1SubtractInterceptionCaughtButton(_ sender: Any) {
    }
    
    // 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
    // 🔸 MARK: - ACTIONS - TEAM 2 STATS BUTTONS
    
    // Stats - Team 2 Pass Completion - Add
    @IBAction func team2AddCompletionMadeButton(_ sender: Any) {
    }
    
    @IBAction func team2AddCompletionMissedButton(_ sender: Any) {
    }
    
    @IBAction func team2AddInterceptionThrownButton(_ sender: Any) {
    }
    
    // Stats - Team 2 Pass Completion - Subtract
    @IBAction func team2SubtractCompletionMadeButton(_ sender: Any) {
    }
    
    @IBAction func team2SubtractCompletionMissedButton(_ sender: Any) {
    }
    
    @IBAction func team2SubtractInterceptionThrownButton(_ sender: Any) {
    }
    
    // Stats - Team 2 Field Goals - Add
    @IBAction func team2AddFieldGoalMadeButton(_ sender: Any) {
    }
    
    @IBAction func team2AddFieldGoalMissedButton(_ sender: Any) {
    }
    
    // Stats - Team 2 Field Goals - Subtract
    @IBAction func team2SubtractFieldGoalMadeButton(_ sender: Any) {
    }
    
    @IBAction func team2SubractFieldGoalMissedButton(_ sender: Any) {
    }
    
    // Stats - Team 2 PATs - Add
    @IBAction func team2AddPATMadeButton(_ sender: Any) {
    }
    
    @IBAction func team2AddPATMIssedButton(_ sender: Any) {
    }
    
    // Stats - Team 2 PATs - Subtract
    @IBAction func team2SubtractPATMadeButton(_ sender: Any) {
    }
    
    @IBAction func team2SubractPATMIssedButton(_ sender: Any) {
    }
    
    // Stats - Team 2 Misc - Add
    @IBAction func team2AddTDMadeButton(_ sender: Any) {
    }
    
    @IBAction func team2Add2PTMadeButton(_ sender: Any) {
    }
    
    @IBAction func teeam2AddInterceptionCaughtButton(_ sender: Any) {
    }
    
    // Stats - Team 2 Misc - Subtract
    @IBAction func team2SubtractMadeButton(_ sender: Any) {
    }
    
    @IBAction func team2Subtract2PTMadeButton(_ sender: Any) {
    }
    
    @IBAction func teeam2SubtractInterceptionCaughtButton(_ sender: Any) {
    }
    
    // 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
    // 🔸 MARK: - NAVIGATION
    
    // JUST NEED TO POP OFF STACK WITH EXIT BUTTON
}
