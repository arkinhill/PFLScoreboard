//
//  GameRecapVC.swift
//  PFL
//
//  Created by Arkin Hill on 1/4/19.
//  Copyright © 2019 Arkin Hill. All rights reserved.
//

import UIKit

class TeamStatsVC: UIViewController {
    
    // MARK: - OUTLETS
    
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
    
    // MARK: - VIEW DID LOAD

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - ACTIONS
    
    @IBAction func exitButton(_ sender: Any) {
    }
    
    
    /*
    // MARK: - NAVIGATION

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
