//
//  GameScheduleVC.swift
//  PFLScoreboard
//
//  Created by Arkin Hill on 12/31/18.
//  Copyright © 2018 Arkin Hill. All rights reserved.
//

import UIKit

class GameScheduleVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    // MARK: - LANDING PAD
    
    var selectedLeague: League? {
        didSet {
            guard let selectedLeague = selectedLeague else { return }
            GameController.shared.fetchGamesFor(league: selectedLeague) { (success) in
                if success {
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                }
            }
        }
    }
    
    // MARK: - OUTLETS
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - VIEW DID LOAD
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.collectionView.reloadData()
    }
    
    // MARK: - COLLECTION VIEW DATA SOURCE
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedLeague?.games.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "gameCell", for: indexPath) as? GameCVCell
            else { return UICollectionViewCell() }
        
        let cellGame = selectedLeague?.games[indexPath.row]
        guard let game = cellGame else { return cell }
//            let team1 = game.team1,
//            let team2 = game.team2
//
        // Configure cell
        if let date = game.date {
            cell.backgroundColor = UIColor(named: "Black")
            cell.gameDateLabel.text = date.asHeader
        } else {
            cell.backgroundColor = UIColor(named: "Yellow")
        }
        
        cell.leftHelmetButton.setImage(UIImage(named: "helmet\(game.team1Color)Left"), for: .normal)
        cell.leftHelmetLetterImageView.image = UIImage(named: "letter\(game.team1Name.prefix(1).capitalized)")
        cell.team1NameLabel.text = game.team1Name.uppercased()
        cell.team1ScoreLabel.text = "\(game.team1Score)"
        
        cell.rightHelmetButton.setImage(UIImage(named: "helmet\(game.team2Color)Right"), for: .normal)
        cell.rightHelmetLetterImageView.image = UIImage(named: "letter\(game.team2Name.prefix(1).capitalized)")
        cell.team2NameLabel.text = game.team2Name.uppercased()
        cell.team2ScoreLabel.text = "\(game.team2Score)"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let game = selectedLeague?.games[indexPath.row] else { return }
        if let _ = game.date {
            guard let gameRecapVC = UIStoryboard(name: "GameRecap", bundle: nil).instantiateInitialViewController() as? GameRecapVC else { return }
            gameRecapVC.selectedGame = game
            navigationController?.present(gameRecapVC, animated: true, completion: nil)
        } else {
            guard let scoreboardVC = UIStoryboard(name: "Scoreboard", bundle: nil).instantiateInitialViewController() as? ScoreboardVC else { return }
            scoreboardVC.selectedGame = game
            navigationController?.present(scoreboardVC, animated: true, completion: nil)
        }
    }
}

