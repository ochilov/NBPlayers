//
//  GameDetailsViewController.swift
//  NBPlayers
//
//  Created by JohnO on 10.03.2021.
//

import UIKit

class GameDetailsViewController: UIViewController {
	@IBOutlet weak var seasonLabel: UILabel!
	@IBOutlet weak var periodLabel: UILabel!
	@IBOutlet weak var timeLabel: UILabel!
	@IBOutlet weak var homeTeamButton: UIButton!
	@IBOutlet weak var homeTeamScoreLabel: UILabel!
	@IBOutlet weak var visitorTeamButton: UIButton!
	@IBOutlet weak var visitorTeamScoreLabel: UILabel!
	
	var game: Game?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		navigationItem.title = "Game"
		navigationController?.navigationBar.prefersLargeTitles = true
		
		seasonLabel.text = humanReadable(of: game?.season, or: "") + " " + humanReadable(of: game?.status, or: "")
		periodLabel.text = humanReadable(of: game?.period, or: "-")

		timeLabel.text = game?.time
		homeTeamButton.setTitle(game?.homeTeam.name, for: .normal)
		visitorTeamButton.setTitle(game?.visitorTeam.name, for: .normal)
		
		homeTeamScoreLabel.text = humanReadable(of: game?.homeTeamScore, or: "-")
		visitorTeamScoreLabel.text = humanReadable(of: game?.visitorTeamScore, or: "-")
		
		let winnerTeam = game?.winnerTeam
		homeTeamScoreLabel   .textColor = winnerTeam == game?.homeTeam    ? UIColor.label : UIColor.red
		visitorTeamScoreLabel.textColor = winnerTeam == game?.visitorTeam ? UIColor.label : UIColor.red
	}
	
	@IBAction func teamDetailsTapped(_ sender: UIButton) {
		guard let team = (sender.tag == 1 ? game?.visitorTeam : game?.homeTeam) else {
			return
		}
	
		let storyboard = UIStoryboard(name: "Main", bundle: .main)
		let vc = storyboard.instantiateViewController(identifier: "TeamViewController") as! TeamViewController
		
		vc.team = team
		navigationController?.pushViewController(vc, animated: true)
	}
	
	func humanReadable(of number: Int?, or defValue: String) -> String {
		if let number = number {
			return "\(number)"
		} else {
			return defValue
		}
	}
	
	func humanReadable(of str: String?, or defValue: String) -> String {
		if let str = str {
			return str
		} else {
			return defValue
		}
	}
}

