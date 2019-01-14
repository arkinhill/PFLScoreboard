//
//  ScoreboardVC.swift
//  PFLScoreboard
//
//  Created by Arkin Hill on 1/2/19.
//  Copyright © 2019 Arkin Hill. All rights reserved.
//

import UIKit
import CloudKit
import AVFoundation

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
    
    // Play/Pause button
    @IBOutlet weak var playPauseButton: UIButton!
    
    
    // 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
    // 🔸 MARK: - OUTLETS - CLOCK AND SCORE
    
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
    
    // 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
    // 🔸 MARK: - OUTLETS - BUTTON COLLECTIONS
    
    @IBOutlet var team1StatsButtons: [UIButton]!
    @IBOutlet var team2StatsButtons: [UIButton]!
    
    
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
        
        let path = Bundle.main.path(forResource: "sportsArenaBuzzer", ofType: "wav")
        let soundUrl = URL(fileURLWithPath: path!)
        
        do {
            try buzzer = AVAudioPlayer(contentsOf: soundUrl)
            buzzer.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        // Set stat cell background colors
        setCellBackgroundColor()
        updateViews()
        changeScore()
    }
    
    func changeScore() {
        guard let team1Score = selectedGame?.team1Score,
            let team2Score = selectedGame?.team2Score else { return }
        
        // Split score into digits
        let team1FirstDigit = team1Score / 10
        let team1SecondDigit = team1Score % 10
        let team2FirstDigit = team2Score / 10
        let team2SecondDigit = team2Score % 10
        
        // Change Team 1 score (first digit, second digit) -- format: scoreboard4Red
        team1ScoreFirstDigitImageView.image = UIImage(named: "scoreboard\(team1FirstDigit)Red")
        team1ScoreSecondDigitImageView.image = UIImage(named: "scoreboard\(team1SecondDigit)Red")
        
        // Change Team 2 score (first digit, second digit)
        team2ScoreFirstDigitImageView.image = UIImage(named: "scoreboard\(team2FirstDigit)Red")
        team2ScoreSecondDigitImageView.image = UIImage(named: "scoreboard\(team2SecondDigit)Red")
    }
    
    // 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
    // 🔸 MARK: - UPDATE VIEWS FUNCTION
    
    func updateViews() {
        guard let game = selectedGame else { return }
        
        // UPDATE TEAM HEADERS
        
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
        
        // UPDATE TEAM 1 STATS
        
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
        
        // UPDATE TEAM 2 STATS
            
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
        
        updateScoreboard()

    }
    
    // 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
    // 🔸 MARK: - SWITCH STAT CELL COLOR FUNCTION
    
    func setCellBackgroundColor() {
        
        guard let game = selectedGame else { return }
        let color1 = UIColor(named: game.team1Color)
        let color2 = UIColor(named: game.team2Color)
        
        for button in team1StatsButtons {
            button.backgroundColor = color1
        }
        for button in team2StatsButtons {
            button.backgroundColor = color2
        }
    }
    
    // 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
    // 🔸 MARK: - END GAME FUNCTION
    
    func endGame(sender: UIButton) {
        
        // Change font and color of notificaton alert title
        let attributedStringTitle = NSAttributedString(string: "WANT TO END THE GAME?", attributes: [
            NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBold", size: 18) as Any,
            NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.9976590276, green: 0.7437580228, blue: 0.1992819309, alpha: 1) ])
        
        // Change font and color of notificaton alert message
        let attributedStringMessage = NSAttributedString(string: "This action will end the game and finalize scores and stats.", attributes: [
            NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Light", size: 16) as Any,
            NSAttributedString.Key.foregroundColor : #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) ])
        
        // Have notification appear to ask if they are sure they want to end game
        let alertController = UIAlertController(title: "", message: "", preferredStyle: .alert)
        alertController.setValue(attributedStringTitle, forKey: "attributedTitle")
        alertController.setValue(attributedStringMessage, forKey: "attributedMessage")
        
        // change the background color
        let subview = (alertController.view.subviews.first?.subviews.first?.subviews.first!)! as UIView
        subview.layer.cornerRadius = 5
        subview.backgroundColor = #colorLiteral(red: 0.3096027874, green: 0.3096027874, blue: 0.3096027874, alpha: 1)
        
        let dismissAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        let continueAction = UIAlertAction(title: "Proceed", style: .default) { (_) in
            guard let selectedGame = self.selectedGame,
                let team1 = selectedGame.team1,
                let team2 = selectedGame.team2
                else { return }
            
            // Assign an end date, win/loss, and update to CloudKit
            GameController.shared.assignGameEndDate(game: selectedGame)
            TeamController.shared.assignWinOrLoss(game: selectedGame)
            GameController.shared.update(selectedGame, from: sender, completion: { (success) in
                if success {
                    TeamController.shared.updateTeams(teams: [team1, team2], completion: { (success) in
                        DispatchQueue.main.async {
                            self.dismiss(animated: true, completion: nil)
                        }
                    })
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
    
    // 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
    // 🔸 MARK: - TIMER FUNCTIONS
    
    var timer = Timer()
    
    @objc func counter() {
        guard let selectedGame = selectedGame else { return }
        selectedGame.clockTime -= 1
        updateScoreboard()
        
        if selectedGame.clockTime == 0 && selectedGame.whichHalf == 1 {
            timer.invalidate()
            buzzerSound()
            selectedGame.clockTime = 720
            selectedGame.whichHalf = 2
            updateScoreboard()
            playPauseButton.setBackgroundImage(UIImage(named: "buttonPlay"), for: .normal)
        } else if selectedGame.clockTime == 0 {
            timer.invalidate()
            buzzerSound()
        }
    }
    
    func updateScoreboard() {
        let formattedTime = TimeStringFormatter.shared.timeString(time: TimeInterval(selectedGame?.clockTime ?? 0))
        
        // Clock image labels
        clockFirstDigitImageView.image = UIImage(named: "scoreboard\(formattedTime[0])Yellow")
        clockSecondDigitImageView.image = UIImage(named: "scoreboard\(formattedTime[1])Yellow")
        clockThirdDigitImageView.image = UIImage(named: "scoreboard\(formattedTime[2])Yellow")
        clockFourthDigitImageView.image = UIImage(named: "scoreboard\(formattedTime[3])Yellow")
        
        let halfImage = selectedGame?.whichHalf == 1 ? UIImage(named: "half1") : UIImage(named: "half2")
        
        halfIndicatorImageView.image = halfImage
    }
    
    var buzzer: AVAudioPlayer!
    
    func buzzerSound() {
        if buzzer.isPlaying {
            buzzer.stop()
        }
        buzzer.play()
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
        if !timer.isValid {
            selectedGame?.clockTime -= 1
         updateScoreboard()
            
        } else {
            // Give alert that they can rewind while timer is running
        }
    }
    
    @IBAction func forwardButtonTapped(_ sender: Any) {
        if !timer.isValid {
            selectedGame?.clockTime += 1
          updateScoreboard()
            
        } else {
            // Give alert that they can rewind while timer is running
        }
    }
    
    @IBAction func playPauseButtonTapped(_ sender: Any) {
        if timer.isValid {
            timer.invalidate()
            playPauseButton.setBackgroundImage(UIImage(named: "buttonPlay"), for: .normal)
        } else {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ScoreboardVC.counter), userInfo: nil, repeats: true)
            playPauseButton.setBackgroundImage(UIImage(named: "buttonPause"), for: .normal)
        }
    }
    
    @IBAction func endGameButtonTapped(_ sender: UIButton) {
        endGame(sender: sender)
    }
    
    
    @IBAction func exitButtonTapped(_ sender: UIButton) {
        guard let game = selectedGame else { return }
        timer.invalidate()
        
        GameController.shared.update(game, completion: { (success) in
            if success {
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
                }
            }
        })
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
        guard let team1 = game.team1 else { print("Error unwrapping team1") ; return }
        guard let team2 = game.team2 else { print("Error unwrapping team2") ; return }
        guard let gamesPlayed = game.team1?.gamesPlayed else { print("Error unwrapping games played") ; return }
        
        // Cell labels
        let cellA1 = team1GameIntThrownButton
        let cellB1 = team1AvgIntThrownButton
        let cellC1 = team2GameIntCaughtButton
        let cellD1 = team2AvgIntCaughtButton
        
        // Update source of truth
        game.team1InterceptionsThrown += 1
        game.team2InterceptionsCaught += 1
        team1.interceptionsThrown += 1
        team2.interceptionsCaught += 1
        
        // Model object properties
        let gameCountTeam1 = game.team1InterceptionsThrown
        let gameCountTeam2 = game.team2InterceptionsCaught
        let team1Avg = team1.interceptionsThrown
        let team2Avg = team2.interceptionsCaught
        
        // Update stat labels
        cellA1?.setTitle("\(gameCountTeam1)", for: .normal)
        cellB1?.setTitle(String(format: "%.1f", Double(team1Avg / (gamesPlayed + 1))), for: .normal)
        cellC1?.setTitle("\(gameCountTeam2)", for: .normal)
        cellD1?.setTitle(String(format: "%.1f", Double(team2Avg / (gamesPlayed + 1))), for: .normal)
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
        guard let team1 = game.team1 else { print("Error unwrapping team") ; return }
        guard let team2 = game.team2 else { print("Error unwrapping team") ; return }
        guard let gamesPlayed = game.team1?.gamesPlayed else { print("Error unwrapping games played") ; return }
        
        // Guard against subtracting to negative numbers
        if game.team1InterceptionsThrown == 0 { return }
        
        // Cell labels
        let cellA1 = team1GameIntThrownButton
        let cellB1 = team1AvgIntThrownButton
        let cellC1 = team2GameIntCaughtButton
        let cellD1 = team2AvgIntCaughtButton
        
        // Update source of truth
        game.team1InterceptionsThrown -= 1
        game.team2InterceptionsCaught -= 1
        team1.interceptionsThrown -= 1
        team2.interceptionsCaught -= 1
        
        // Model object properties
        let gameCountTeam1 = game.team1InterceptionsThrown
        let gameCountTeam2 = game.team2InterceptionsCaught
        let team1Avg = team1.interceptionsThrown
        let team2Avg = team2.interceptionsCaught
        
        // Update stat labels
        cellA1?.setTitle("\(gameCountTeam1)", for: .normal)
        cellB1?.setTitle(String(format: "%.1f", Double(team1Avg / (gamesPlayed + 1))), for: .normal)
        cellC1?.setTitle("\(gameCountTeam2)", for: .normal)
        cellD1?.setTitle(String(format: "%.1f", Double(team2Avg / (gamesPlayed + 1))), for: .normal)
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
        game.team1Score += 3
        
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
        changeScore()
        
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
        game.team1Score -= 3
        
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
        changeScore()
        
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
        game.team1Score += 1
        
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
        changeScore()
        
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
        game.team1Score -= 1
        
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
        changeScore()
        
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
        game.team1Score += 6
        
        // Model object properties
        let gameCountA1 = game.team1Touchdowns
        let teamAvgA1 = team.touchdowns
        
        // Update stat labels
        cellA1?.setTitle("\(gameCountA1)", for: .normal)
        cellB1?.setTitle(String(format: "%.1f", Double(teamAvgA1 / (gamesPlayed + 1))), for: .normal)
        changeScore()
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
        game.team1Score += 2
        
        // Model object properties
        let gameCountA1 = game.team1TwoPointConversions
        let teamAvgA1 = team.twoPointConversions
        
        // Update stat labels
        cellA1?.setTitle("\(gameCountA1)", for: .normal)
        cellB1?.setTitle(String(format: "%.1f", Double(teamAvgA1 / (gamesPlayed + 1))), for: .normal)
        changeScore()
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
        game.team1Score -= 6
        
        // Model object properties
        let gameCountA1 = game.team1Touchdowns
        let teamAvgA1 = team.touchdowns
        
        // Update stat labels
        cellA1?.setTitle("\(gameCountA1)", for: .normal)
        cellB1?.setTitle(String(format: "%.1f", Double(teamAvgA1 / (gamesPlayed + 1))), for: .normal)
        changeScore()
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
        game.team1Score -= 2
        
        // Model object properties
        let gameCountA1 = game.team1TwoPointConversions
        let teamAvgA1 = team.twoPointConversions
        
        // Update stat labels
        cellA1?.setTitle("\(gameCountA1)", for: .normal)
        cellB1?.setTitle(String(format: "%.1f", Double(teamAvgA1 / (gamesPlayed + 1))), for: .normal)
        changeScore()
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
        guard let team1 = game.team1 else { print("Error unwrapping team1") ; return }
        guard let team2 = game.team2 else { print("Error unwrapping team2") ; return }
        guard let gamesPlayed = game.team1?.gamesPlayed else { print("Error unwrapping games played") ; return }
        
        // Cell labels
        let cellA1 = team2GameIntThrownButton
        let cellB1 = team2AvgIntThrownButton
        let cellC1 = team1GameIntCaughtButton
        let cellD1 = team1AvgIntCaughtButton
        
        // Update source of truth
        game.team2InterceptionsThrown += 1
        game.team1InterceptionsCaught += 1
        team2.interceptionsThrown += 1
        team1.interceptionsCaught += 1
        
        // Model object properties
        let gameCountTeam1 = game.team2InterceptionsThrown
        let gameCountTeam2 = game.team1InterceptionsCaught
        let team1Avg = team2.interceptionsThrown
        let team2Avg = team1.interceptionsCaught
        
        // Update stat labels
        cellA1?.setTitle("\(gameCountTeam2)", for: .normal)
        cellB1?.setTitle(String(format: "%.1f", Double(team2Avg / (gamesPlayed + 1))), for: .normal)
        cellC1?.setTitle("\(gameCountTeam1)", for: .normal)
        cellD1?.setTitle(String(format: "%.1f", Double(team1Avg / (gamesPlayed + 1))), for: .normal)
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
        guard let team1 = game.team1 else { print("Error unwrapping team1") ; return }
        guard let team2 = game.team2 else { print("Error unwrapping team2") ; return }
        guard let gamesPlayed = game.team1?.gamesPlayed else { print("Error unwrapping games played") ; return }
        
        // Cell labels
        let cellA1 = team2GameIntThrownButton
        let cellB1 = team2AvgIntThrownButton
        let cellC1 = team1GameIntCaughtButton
        let cellD1 = team1AvgIntCaughtButton
        
        // Update source of truth
        game.team2InterceptionsThrown -= 1
        game.team1InterceptionsCaught -= 1
        team2.interceptionsThrown -= 1
        team1.interceptionsCaught -= 1
        
        // Model object properties
        let gameCountTeam1 = game.team2InterceptionsThrown
        let gameCountTeam2 = game.team1InterceptionsCaught
        let team1Avg = team2.interceptionsThrown
        let team2Avg = team1.interceptionsCaught
        
        // Update stat labels
        cellA1?.setTitle("\(gameCountTeam2)", for: .normal)
        cellB1?.setTitle(String(format: "%.1f", Double(team2Avg / (gamesPlayed + 1))), for: .normal)
        cellC1?.setTitle("\(gameCountTeam1)", for: .normal)
        cellD1?.setTitle(String(format: "%.1f", Double(team1Avg / (gamesPlayed + 1))), for: .normal)
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
        game.team2Score += 3
        
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
        changeScore()
        
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
        game.team2Score -= 3
        
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
        changeScore()
        
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
        game.team2Score += 1
        
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
        changeScore()
        
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
        game.team2Score -= 1
        
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
        changeScore()
        
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
        game.team2Score += 6
        
        // Model object properties
        let gameCountA1 = game.team2Touchdowns
        let teamAvgA1 = team.touchdowns
        
        // Update stat labels
        cellA1?.setTitle("\(gameCountA1)", for: .normal)
        cellB1?.setTitle(String(format: "%.1f", Double(teamAvgA1 / (gamesPlayed + 1))), for: .normal)
        changeScore()
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
        game.team2Score += 2
        
        // Model object properties
        let gameCountA1 = game.team2TwoPointConversions
        let teamAvgA1 = team.twoPointConversions
        
        // Update stat labels
        cellA1?.setTitle("\(gameCountA1)", for: .normal)
        cellB1?.setTitle(String(format: "%.1f", Double(teamAvgA1 / (gamesPlayed + 1))), for: .normal)
        changeScore()
    }
    
    // Stats - Team 2 Misc - Subtract
    @IBAction func team2SubtractTouchdownsMadeButton(_ sender: Any) {
        
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
        game.team2Score -= 6
        
        // Model object properties
        let gameCountA1 = game.team2Touchdowns
        let teamAvgA1 = team.touchdowns
        
        // Update stat labels
        cellA1?.setTitle("\(gameCountA1)", for: .normal)
        cellB1?.setTitle(String(format: "%.1f", Double(teamAvgA1 / (gamesPlayed + 1))), for: .normal)
        changeScore()
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
        game.team2Score -= 2
        
        // Model object properties
        let gameCountA1 = game.team2TwoPointConversions
        let teamAvgA1 = team.twoPointConversions
        
        // Update stat labels
        cellA1?.setTitle("\(gameCountA1)", for: .normal)
        cellB1?.setTitle(String(format: "%.1f", Double(teamAvgA1 / (gamesPlayed + 1))), for: .normal)
        changeScore()
    }
    
    // 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
    // 🔸 MARK: - FIRST TIME LABEL SET UP
    
    func updateAverages(){
        
        guard let game = self.selectedGame else { return }
        DispatchQueue.main.async {
            
            self.team1AvgCompletionsButton.setTitle("\(game.team1?.completionsMade ?? 0 / (game.team1?.gamesPlayed ?? 0 + 1))", for: .normal)
            
            //team 2 completion avgs
            self.team1AvgCompletionsButton.setTitle("\(game.team2?.completionsMade ?? 0 / (game.team2?.gamesPlayed ?? 0 + 1))", for: .normal)
        }
        //team 1 completion avgs
    }
    
    // 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
    // 🔸 MARK: - NAVIGATION
    
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


