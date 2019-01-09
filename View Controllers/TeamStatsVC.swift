//
//  GameRecapVC.swift
//  PFL
//
//  Created by Arkin Hill on 1/4/19.
//  Copyright © 2019 Arkin Hill. All rights reserved.
//

import UIKit

class TeamStatsVC: UIViewController {
    
    // 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
    // 🔸 MARK: -LANDING PAD
    
    var selectedTeam: Team?
    
    // 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
    // 🔸 MARK: - OUTLETS
    
    // Team header
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var coachNameLabel: UILabel!
    @IBOutlet weak var helmetImageView: UIImageView!
    @IBOutlet weak var helmetLetterImageView: UIImageView!
    @IBOutlet weak var rankingBadgeImageView: UIImageView!
    @IBOutlet weak var winsLabel: UILabel!
    @IBOutlet weak var lossesLabel: UILabel!
    
    // Stats - Team Pass Completion - Game
    @IBOutlet weak var totalCompletionsLabel: UILabel!
    @IBOutlet weak var totalPassesAttemptedLabel: UILabel!
    @IBOutlet weak var totalCompletionPercentLabel: UILabel!
    @IBOutlet weak var totalIntThrownLabel: UILabel!
    
    // Stats - Team Pass Completion - Averages
    @IBOutlet weak var avgCoompletionsLabel: UILabel!
    @IBOutlet weak var avgassesAttemptedLabel: UILabel!
    @IBOutlet weak var avgIntThrownLabel: UILabel!
    
    // Stats - Team Field Goals - Game
    @IBOutlet weak var totalFieldGoalsLabel: UILabel!
    @IBOutlet weak var totalFieldGoalsAttemptedLabel: UILabel!
    @IBOutlet weak var totalFieldGoalPercentLabel: UILabel!
    
    // Stats - Team Field Goals - Averages
    @IBOutlet weak var avgFieldGoalsLabel: UILabel!
    @IBOutlet weak var avgFieldGoalsAttemptedLabel: UILabel!
    
    // Stats - Team PATs - Game
    @IBOutlet weak var totalPATsMadeLabel: UILabel!
    @IBOutlet weak var totalPATsAttemptedLabel: UILabel!
    @IBOutlet weak var totalPATPercentLabel: UILabel!
    
    // Stats - Team PATs - Averages
    @IBOutlet weak var avgPATsMadeLabel: UILabel!
    @IBOutlet weak var avgPATsAttemptedLabel: UILabel!
    
    // Stats - Team Misc - Game
    @IBOutlet weak var totalTDsLabel: UILabel!
    @IBOutlet weak var total2PTsLabel: UILabel!
    @IBOutlet weak var totalIntCaughtLabel: UILabel!
    
    // Stats - Team Misc - Averages
    @IBOutlet weak var avgTDsLabel: UILabel!
    @IBOutlet weak var avg2PTsLabel: UILabel!
    @IBOutlet weak var avgIntCaughtLabel: UILabel!
    
    // Collections of stats labels
    @IBOutlet var teamStatsLabels: [UILabel]!
    
    // 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
    // 🔸 MARK: - VIEW DID LOAD

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set stat cell background colors
        setCellBackgroundColor()
        updateViews()
    }
    
    // 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
    // 🔸 MARK: - UPDATE VIEWS FUNCTION
    
    func updateViews() {
        guard let team = selectedTeam else { return }
        
        // 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
        // 🔸 MARK: - UPDATE TEAM HEADERS
        
        teamNameLabel.text = "\(team.name.uppercased())"
        coachNameLabel.text = "\(team.coach)"
        helmetImageView.image = UIImage(named: "helmet\(team.color)Right")
        helmetLetterImageView.image = UIImage(named: "letter\(team.name.prefix(1).capitalized)")
        rankingBadgeImageView.image = UIImage(named: "ranking1")
        winsLabel.text = "\(team.wins)"
        lossesLabel.text = "\(team.losses)"

        // 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
        // 🔸 MARK: - UPDATE TEAM STATS
        
        // Stats - Team Pass Completion - Game
        totalCompletionsLabel.text = "\(team.completionsMade)"
        totalPassesAttemptedLabel.text = "\(team.completionsAttempted)"
        if team.completionsAttempted == 0 {
            totalCompletionPercentLabel.text = "0%"
        } else {
            let percentage = getPercentageString(numerator: team.completionsMade, denominator: team.completionsAttempted)
            totalCompletionPercentLabel.text = "\(percentage)"
        }
        totalIntThrownLabel.text = "\(team.interceptionsThrown)"
        
        // Stats - Team Pass Completion - Averages
        avgCoompletionsLabel.text = String(format: "%.1f", Double(team.completionsMade / (team.gamesPlayed + 1)))
        avgassesAttemptedLabel.text = String(format: "%.1f", Double(team.completionsAttempted / (team.gamesPlayed + 1)))
        avgIntThrownLabel.text = String(format: "%.1f", Double(team.interceptionsThrown / (team.gamesPlayed + 1)))
        
        // Stats - Team Field Goals - Game
        totalFieldGoalsLabel.text = "\(team.fieldGoalsMade)"
        totalFieldGoalsAttemptedLabel.text = "\(team.fieldGoalsAttempted)"
        if team.fieldGoalsAttempted == 0 {
            totalFieldGoalPercentLabel.text = "0%"
        } else {
            let percentage = getPercentageString(numerator: team.fieldGoalsMade, denominator: team.fieldGoalsAttempted)
            totalFieldGoalPercentLabel.text = "\(percentage)"
        }
        
        // Stats - Team Field Goals - Averages
        avgFieldGoalsLabel.text = String(format: "%.1f", Double(team.fieldGoalsMade / (team.gamesPlayed + 1)))
        avgFieldGoalsAttemptedLabel.text = String(format: "%.1f", Double(team.fieldGoalsAttempted / (team.gamesPlayed + 1)))
        
        // Stats - Team PATs - Game
        totalPATsMadeLabel.text = "\(team.pATsMade)"
        totalPATsAttemptedLabel.text = "\(team.pATsAttempted)"
        if team.pATsAttempted == 0 {
            totalPATPercentLabel.text = "0%"
        } else {
            let percentage = getPercentageString(numerator: team.pATsMade, denominator: team.pATsAttempted)
            totalPATPercentLabel.text = "\(percentage)"
        }
        
        // Stats - Team PATs - Averages
        avgPATsMadeLabel.text = String(format: "%.1f", Double(team.pATsMade / (team.gamesPlayed + 1)))
        avgPATsAttemptedLabel.text = String(format: "%.1f", Double(team.pATsAttempted / (team.gamesPlayed + 1)))
        
        // Stats - Team Misc - Game
        totalTDsLabel.text = "\(team.touchdowns)"
        total2PTsLabel.text = "\(team.twoPointConversions)"
        totalIntCaughtLabel.text = "\(team.interceptionsCaught)"
        
        // Stats - Team Misc - Averages
        avgTDsLabel.text = String(format: "%.1f", Double(team.touchdowns / (team.gamesPlayed + 1)))
        avg2PTsLabel.text = String(format: "%.1f", Double(team.twoPointConversions / (team.gamesPlayed + 1)))
        avgIntCaughtLabel.text = String(format: "%.1f", Double(team.interceptionsCaught / (team.gamesPlayed + 1)))
    }
    
    // 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
    // 🔸 MARK: - SWITCH STAT CELL COLOR FUNCTION
    
    func setCellBackgroundColor() {
        
        guard let team = selectedTeam else { return }
        let color = UIColor(named: team.color.rawValue)
        
        for label in teamStatsLabels {
            label.backgroundColor = color
        }
    }
    
    // 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
    // 🔸 MARK: - ACTIONS
    
    @IBAction func exitButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

// 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
// 🔸 MARK: - GET PERCENTAGE FUNCTION EXTENSION

extension TeamStatsVC {
    
    fileprivate func getPercentageString(numerator: Int, denominator: Int) -> String {
        
        let numeratorDouble = Double(numerator)
        let denominatorDouble = Double(denominator)
        let percent = Int((numeratorDouble / denominatorDouble) * 100)
        
        return "\(String(percent))%"
    }
}
