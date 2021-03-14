//
//  GamesViewController.swift
//  NBPlayers
//
//  Created by JohnO on 10.03.2021.
//

import UIKit


// MARK: - GamesVC
class GamesViewController: UIViewController {
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
	@IBOutlet weak var errorLabel: UILabel!
	@IBOutlet weak var reloadButton: UIButton!
	
	var games: [Game] = []
	let apiClient = ApiClienrImpl()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		navigationItem.title = "Games"
		navigationController?.navigationBar.prefersLargeTitles = true
		
		tableView.rowHeight = 100
		reloadData()
	}
	
	@IBAction func reloadButtonTapped(_ sender: Any) {
		reloadData()
	}
	
	func reloadData() {
		self.showLoading()
		apiClient.getGames(completion: {result in
			DispatchQueue.main.async {
				switch result {
				case .success(let games):
					self.games = games
					self.showData()
				case .failure:
					self.games = []
					self.showError()
				}
				self.tableView.reloadData()
			}
		})
	}
	
	func showLoading() {
		activityIndicatorView.startAnimating()
		errorLabel.isHidden = true
		reloadButton.isHidden = true
	}
	
	func showData() {
		activityIndicatorView.stopAnimating()
		errorLabel.isHidden = true
		reloadButton.isHidden = true
	}
	
	func showError() {
		activityIndicatorView.stopAnimating()
		errorLabel.isHidden = false
		reloadButton.isHidden = false
	}
}


// MARK: - Games Data Source
extension GamesViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return games.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "GameCell", for: indexPath) as! GameTableCell
		let game = games[indexPath.row]
		
		cell.setGame(game)
		return cell
	}
}


// MARK: - Games Delegate
extension GamesViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let storyboard = UIStoryboard(name: "Main", bundle: .main)
		let vc = storyboard.instantiateViewController(identifier: "GameDetailsViewController") as! GameDetailsViewController
		
		vc.game = games[indexPath.row]
		navigationController?.pushViewController(vc, animated: true)
		tableView.deselectRow(at: indexPath, animated: true)
	}
}


// MARK: - Game Table cell
class GameTableCell: UITableViewCell {
	@IBOutlet weak var statusLabel: UILabel!
	@IBOutlet weak var startDateLabel: UILabel!
	@IBOutlet weak var homeTeamLabel: UILabel!
	@IBOutlet weak var homeTeamScore: UILabel!
	@IBOutlet weak var homeTeamLogo: UIImageView!
	@IBOutlet weak var visitorTeamLabel: UILabel!
	@IBOutlet weak var visitorTeamScore: UILabel!
	@IBOutlet weak var visitorTeamLogo: UIImageView!
	
	func setGame(_ game: Game) {
		statusLabel.text = game.status
		startDateLabel.text = game.date.humanReadableDate()
		
		homeTeamLabel.text = game.homeTeam.name
		homeTeamScore.text = "\(game.homeTeamScore ?? 0)"
		homeTeamLogo.image = getLogo(of: game.homeTeam)
		
		visitorTeamLabel.text = game.visitorTeam.name
		visitorTeamScore.text = "\(game.visitorTeamScore ?? 0)"
		visitorTeamLogo.image = getLogo(of: game.visitorTeam)
		
		showWinnerScore(game)
	}
	
	func showWinnerScore(_ game: Game) {
		if (game.homeTeamScore ?? 0 > game.visitorTeamScore ?? 0) {
			homeTeamScore.text = homeTeamScore.text! + " ◂"
		} else if (game.homeTeamScore ?? 0 < game.visitorTeamScore ?? 0) {
			visitorTeamScore.text = "▸ " + visitorTeamScore.text!
		}
	}
}


// MARK: - Date helper
extension Date {
	func fullDistance(from date: Date, resultIn component: Calendar.Component, calendar: Calendar = .current) -> Int? {
		calendar.dateComponents([component], from: self, to: date).value(for: component)
	}

	func distance(from date: Date, only component: Calendar.Component, calendar: Calendar = .current) -> Int {
		let days1 = calendar.component(component, from: self)
		let days2 = calendar.component(component, from: date)
		return days1 - days2
	}

	func hasSame(_ component: Calendar.Component, as date: Date) -> Bool {
		distance(from: date, only: component) == 0
	}
	
	func humanReadableDate() -> String {
		let currentDate = Date()
		if self.hasSame(.day, as: currentDate) {
			return "Today"
		} else {
			let format = DateFormatter()
			format.dateFormat = "E, d MMM YY"
			return format.string(from: self)
		}
	}
}
