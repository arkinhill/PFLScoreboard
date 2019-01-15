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
    
    // 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
    // 🔸 MARK: - OUTLETS - HEADER
    
    // Team 1 header
    @IBOutlet weak var team1NameTextLabel: UILabel!
    @IBOutlet weak var team1CoachTextLabel: UILabel!
    @IBOutlet weak var team1HelmetButton: UIButton!
    @IBOutlet weak var team1HelmetLetterImageView: UIImageView!
    @IBOutlet weak var team1RankingImageView: UIImageView!
    
    // Team 2 header
    @IBOutlet weak var team2NameTextLabel: UILabel!
    @IBOutlet weak var team2CoachTextLabel: UILabel!
    @IBOutlet weak var team2HelmetButton: UIButton!
    @IBOutlet weak var team2HelmetLetterImageView: UIImageView!
    @IBOutlet weak var team2RankingImageView: UIImageView!
    
    // Score and date
    @IBOutlet weak var team1ScoreTextLabel: UILabel!
    @IBOutlet weak var team2ScoreTextLabel: UILabel!
    @IBOutlet weak var gameDateTextLabel: UILabel!
    
    
    // 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
    // 🔸 MARK: - OUTLETS - TEAM 1 STATS
    
    // Stats - Team 1 Pass Completion - Game
    @IBOutlet weak var team1CompletionsTextLabel: UILabel!
    @IBOutlet weak var team1CompletionsAttemptedTextLabel: UILabel!
    @IBOutlet weak var team1CompletionPercentTextLabel: UILabel!
    @IBOutlet weak var team1IntThrownTextLabel: UILabel!
    
    // Stats - Team 1 Field Goals - Game
    @IBOutlet weak var team1FieldGoalsTextLabel: UILabel!
    @IBOutlet weak var team1FieldGoalsAttemptedTextLabel: UILabel!
    @IBOutlet weak var team1FieldGoalPercentTextLabel: UILabel!
    
    // Stats - Team 1 PATs - Game
    @IBOutlet weak var team1PATsMadeTextLabel: UILabel!
    @IBOutlet weak var team1PATsAttemptedTextLabel: UILabel!
    @IBOutlet weak var team1PATPercentTextLabel: UILabel!
    
    // Stats - Team 1 Misc - Game
    @IBOutlet weak var team1TouchdownsTextLabel: UILabel!
    @IBOutlet weak var team1TwoPointConversionsTextLabel: UILabel!
    @IBOutlet weak var team1IntCaughtTextLabel: UILabel!
    
    
    // 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
    // 🔸 MARK: - OUTLETS - TEAM 2 STATS
    
    // Stats - Team 2 Pass Completion - Game
    @IBOutlet weak var team2CompletionsTextLabel: UILabel!
    @IBOutlet weak var team2CompletionsAttemptedTextLabel: UILabel!
    @IBOutlet weak var team2CompletionPercentTextLabel: UILabel!
    @IBOutlet weak var team2IntThrownTextLabel: UILabel!
    
    // Stats - Team 2 Field Goals - Game
    @IBOutlet weak var team2FieldGoalsTextLabel: UILabel!
    @IBOutlet weak var team2FieldGoalsAttemptedTextLabel: UILabel!
    @IBOutlet weak var team2FieldGoalPercentTextLabel: UILabel!
    
    // Stats - Team 2 PATs - Game
    @IBOutlet weak var team2PATsMadeTextLabel: UILabel!
    @IBOutlet weak var team2PATsAttemptedTextLabel: UILabel!
    @IBOutlet weak var team2PATPercentTextLabel: UILabel!
    
    // Stats - Team 2 Misc - Game
    @IBOutlet weak var team2TouchdownsTextLabel: UILabel!
    @IBOutlet weak var team2TwoPointConversionsTextLabel: UILabel!
    @IBOutlet weak var team2IntCaughtTextLabel: UILabel!
    
    
    // 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
    // 🔸 MARK: - OUTLETS - LABELS COLLECTIONS
    
    @IBOutlet var team1StatsLabels: [UILabel]!
    @IBOutlet var team2StatsLabels: [UILabel]!
    
    
    // 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
    // 🔸 MARK: - VIEW DID LOAD

    override func viewDidLoad() {
        super.viewDidLoad()
        if let game = selectedGame {
            GameController.shared.fetchTeamsFor(game: game) { (success) in
                if success {
                    DispatchQueue.main.async {
                        self.updateViews()
                    }
                }
            }
        }
        // Set stat cell background colors
        setCellBackgroundColor()
    }
    
    // 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
    // 🔸 MARK: - UPDATE VIEWS FUNCTION
    
    func updateViews() {
        guard let game = selectedGame,
        let team1 = selectedGame?.team1,
        let team2 = selectedGame?.team2 else { return }
        
        // 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
        // 🔸 MARK: - UPDATE TEAM HEADERS
        
        // Team 1 header
        team1NameTextLabel.text = "\(team1.name.uppercased())"
        team1CoachTextLabel.text = "\(team1.coach.capitalized)"
        team1HelmetButton.setBackgroundImage(UIImage(named: "helmet\(game.team1Color)Left"), for: .normal)
            team1HelmetLetterImageView.image = UIImage(named: "letter\(team1.name.prefix(1).capitalized)")
        team1RankingImageView.image = UIImage(named: "")
        
        // Team 2 header
        team2NameTextLabel.text = "\(team2.name.uppercased())"
        team2CoachTextLabel.text = "\(team2.coach.capitalized)"
        team2HelmetButton.setBackgroundImage(UIImage(named: "helmet\(game.team2Color)Right"), for: .normal)
        team2HelmetLetterImageView.image = UIImage(named: "letter\(team2.name.prefix(1).capitalized)")
        team2RankingImageView.image = UIImage(named: "")
        
        // Score and date
        team1ScoreTextLabel.text = "\(String(describing: game.team1Score))"
        team2ScoreTextLabel.text = "\(String(describing: game.team2Score))"
        gameDateTextLabel.text = "\(String(describing: game.date!.asString))"
        
        
        // 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
        // 🔸 MARK: - UPDATE TEAM 1 STATS
        
        // Stats - Team 1 Pass Completion - Game
        team1CompletionsTextLabel.text = "\(game.team1CompletionsMade)"
        team1CompletionsAttemptedTextLabel.text = "\(game.team1CompletionsAttempted)"
        if team1.completionsAttempted == 0 {
            team1CompletionPercentTextLabel.text = "0%"
        } else {
            let percentage = getPercentageString(numerator: game.team1CompletionsMade, denominator: game.team1CompletionsAttempted)
            team1CompletionPercentTextLabel.text = "\(percentage)"
        }
        team1IntThrownTextLabel.text = "\(game.team1InterceptionsThrown)"
        
        // Stats - Team 1 Field Goals - Game
        team1FieldGoalsTextLabel.text = "\(game.team1FieldGoalsMade)"
        team1FieldGoalsAttemptedTextLabel.text = "\(game.team1FieldGoalsAttempted)"
        if team1.fieldGoalsAttempted == 0 {
            team1FieldGoalPercentTextLabel.text = "0%"
        } else {
            let percentage = getPercentageString(numerator: game.team1FieldGoalsMade, denominator: game.team1FieldGoalsAttempted)
            team1FieldGoalPercentTextLabel.text = "\(percentage)"
        }
        
        // Stats - Team 1 PATs - Game
        team1PATsMadeTextLabel.text = "\(game.team1PATsMade)"
        team1PATsAttemptedTextLabel.text = "\(game.team1PATsAttempted)"
        if team1.fieldGoalsAttempted == 0 {
            team1PATPercentTextLabel.text = "0%"
        } else {
            let percentage = getPercentageString(numerator: game.team1PATsMade, denominator: game.team1PATsAttempted)
            team1PATPercentTextLabel.text = "\(percentage)"
        }
        
        // Stats - Team 1 Misc - Game
        team1TouchdownsTextLabel.text = "\(game.team1Touchdowns)"
        team1TwoPointConversionsTextLabel.text = "\(game.team1TwoPointConversions)"
        team1IntCaughtTextLabel.text = "\(game.team1InterceptionsCaught)"
        
        
        // 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
        // 🔸 MARK: - UPDATE TEAM 2 STATS
        
        // Stats - Team 2 Pass Completion - Game
        team2CompletionsTextLabel.text = "\(game.team2CompletionsMade)"
        team2CompletionsAttemptedTextLabel.text = "\(game.team2CompletionsAttempted)"
        if team2.completionsAttempted == 0 {
            team2CompletionPercentTextLabel.text = "0%"
        } else {
            let percentage = getPercentageString(numerator: game.team2CompletionsMade, denominator: game.team2CompletionsAttempted)
            team2CompletionPercentTextLabel.text = "\(percentage)"
        }
        team2IntThrownTextLabel.text = "\(game.team2InterceptionsThrown)"
        
        // Stats - Team 2 Field Goals - Game
        team2FieldGoalsTextLabel.text = "\(game.team2FieldGoalsMade)"
        team2FieldGoalsAttemptedTextLabel.text = "\(game.team2FieldGoalsAttempted)"
        if team2.fieldGoalsAttempted == 0 {
            team2FieldGoalPercentTextLabel.text = "0%"
        } else {
            let percentage = getPercentageString(numerator: game.team2FieldGoalsMade, denominator: game.team2FieldGoalsAttempted)
            team2FieldGoalPercentTextLabel.text = "\(percentage)"
        }
        
        // Stats - Team 2 PATs - Game
        team2PATsMadeTextLabel.text = "\(game.team2PATsMade)"
        team2PATsAttemptedTextLabel.text = "\(game.team2PATsAttempted)"
        if team2.fieldGoalsAttempted == 0 {
            team2PATPercentTextLabel.text = "0%"
        } else {
            let percentage = getPercentageString(numerator: game.team2PATsMade, denominator: game.team2PATsAttempted)
            team2PATPercentTextLabel.text = "\(percentage)"
        }
        
        // Stats - Team 2 Misc - Game
        team2TouchdownsTextLabel.text = "\(game.team2Touchdowns)"
        team2TwoPointConversionsTextLabel.text = "\(game.team2TwoPointConversions)"
        team2IntCaughtTextLabel.text = "\(game.team2InterceptionsCaught)"
    }
   
    // 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
    // 🔸 MARK: - SWITCH STAT CELL COLOR FUNCTION
    
    func setCellBackgroundColor() {
        
        guard let game = selectedGame else { return }
        let color1 = UIColor(named: game.team1Color)
        let color2 = UIColor(named: game.team2Color)
        
        for button in team1StatsLabels {
            button.backgroundColor = color1
        }
        for button in team2StatsLabels {
            button.backgroundColor = color2
        }
    }
    // 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
    // 🔸 MARK: - ACTIONS
    
    @IBAction func team1HelmetButton(_ sender: Any) {
    }
    
    @IBAction func team2HelmetButton(_ sender: Any) {
    }
    
    @IBAction func exitButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
//    // 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
//    // 🔸 MARK: - NAVIGATION
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let team1 = selectedGame?.team1
        let team2 = selectedGame?.team2
        
        if segue.identifier == "fromTeam1Again" {
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

extension GameRecapVC {
    
    fileprivate func getPercentageString(numerator: Int, denominator: Int) -> String {
        
        if numerator == 0 || denominator == 0 {
            return "0%"
        } else {
            let numeratorDouble = Double(numerator)
            let denominatorDouble = Double(denominator)
            let percent = Int((numeratorDouble / denominatorDouble) * 100)
            
            return "\(String(percent))%"
        }
    }
}
