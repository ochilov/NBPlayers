//
//  GameDetailsViewController.swift
//  NBPlayers
//
//  Created by JohnO on 10.03.2021.
//

import UIKit

class GameDetailsViewController: UIViewController {
	@IBOutlet weak var homeTeamButton: UIButton!
	@IBOutlet weak var homeTeamLogo: UIImageView!
	@IBOutlet weak var homeTeamScoreLabel: UILabel!
	@IBOutlet weak var visitorTeamButton: UIButton!
	@IBOutlet weak var visitorTeamLogo: UIImageView!
	@IBOutlet weak var visitorTeamScoreLabel: UILabel!
	@IBOutlet weak var statusLabel: UILabel!
	@IBOutlet weak var seasonLabel: UILabel!
	@IBOutlet weak var periodLabel: UILabel!
	@IBOutlet weak var dateLabel: UILabel!
	
	var game: Game?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		navigationItem.title = "Game"
		navigationController?.navigationBar.prefersLargeTitles = true

		homeTeamButton   .setTitle(game?.homeTeam.name, for: .normal)
		visitorTeamButton.setTitle(game?.visitorTeam.name, for: .normal)
		
		homeTeamScoreLabel   .text = humanReadable(of: game?.homeTeamScore, or: "-")
		visitorTeamScoreLabel.text = humanReadable(of: game?.visitorTeamScore, or: "-")
		showWinnerScore(game)
		
		homeTeamLogo   .image = getLogo(of: game?.homeTeam)
		visitorTeamLogo.image = getLogo(of: game?.visitorTeam)
		doLogoTappable(homeTeamLogo)
		doLogoTappable(visitorTeamLogo)
		
		statusLabel.text = game?.status
		seasonLabel.text = humanReadable(of: game?.season, or: "-")
		periodLabel.text = humanReadable(of: game?.period, or: "-")
		dateLabel.text = game?.date.humanReadableDate()
	}
	
	@IBAction func teamDetailsTapped(_ sender: UIView) {
		guard let team = (sender.tag == 1 ? game?.visitorTeam : game?.homeTeam) else {
			return
		}
	
		let storyboard = UIStoryboard(name: "Main", bundle: .main)
		let vc = storyboard.instantiateViewController(identifier: "TeamViewController") as! TeamViewController
		
		vc.team = team
		navigationController?.pushViewController(vc, animated: true)
	}
	
	func doLogoTappable(_ logo:UIImageView) {
		let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(logoTapped(tapGestureRecognizer:)))
		logo.isUserInteractionEnabled = true
		logo.addGestureRecognizer(tapGestureRecognizer)
	}
	
	@objc func logoTapped(tapGestureRecognizer: UITapGestureRecognizer)
	{
		let tappedLogo = tapGestureRecognizer.view as! UIImageView
		self.teamDetailsTapped(tappedLogo)
	}
	
	func showWinnerScore(_ game: Game?) {
		if (game?.homeTeamScore ?? 0 > game?.visitorTeamScore ?? 0) {
			homeTeamScoreLabel.text = homeTeamScoreLabel.text! + " ◂"
		} else if (game?.homeTeamScore ?? 0 < game?.visitorTeamScore ?? 0) {
			visitorTeamScoreLabel.text = "▸ " + visitorTeamScoreLabel.text!
		}
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

