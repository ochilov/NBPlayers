//
//  PlayersViewController.swift
//  NBPlayers
//
//  Created by JohnO on 09.03.2021.
//

import UIKit

// MARK: - PlayersVC
class PlayersViewController: UIViewController {
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
	@IBOutlet weak var errorLabel: UILabel!
	@IBOutlet weak var reloadButton: UIButton!
	
	var players: [Player] = []
	let apiClient = ApiClienrImpl()
	override func viewDidLoad() {
        super.viewDidLoad()
		navigationItem.title = "Players"
		navigationController?.navigationBar.prefersLargeTitles = true
		tableView.rowHeight = 60
		reloadData()
    }
	
	@IBAction func reloadButtonTapped(_ sender: Any) {
		reloadData()
	}
	
	func reloadData() {
		showLoading()
		apiClient.getPlayers(completion: {result in
			DispatchQueue.main.async {
				switch result {
				case .success(let players):
					self.players = players
					self.showData()
				case .failure:
					self.players = []
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


// MARK: - Players Data Source
extension PlayersViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return players.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "PlayersTableCell", for: indexPath) as! PlayersTableCell
		let player = players[indexPath.row]
		
		cell.setPlayer(player)
		return cell
	}
}


// MARK: - Players Delegate
extension PlayersViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let storyboard = UIStoryboard(name: "Main", bundle: .main)
		let vc = storyboard.instantiateViewController(identifier: "PlayerDetailsViewController") as! PlayerDetailsViewController
		
		vc.player = players[indexPath.row]
		navigationController?.pushViewController(vc, animated: true)
		tableView.deselectRow(at: indexPath, animated: true)
	}
}


// MARK: - Game Table cell
class PlayersTableCell: UITableViewCell {
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var secondaryInfoLabel: UILabel!
	@IBOutlet weak var teamLogo: UIImageView!
	
	func setPlayer(_ player: Player) {
		nameLabel.text = player.fullName
		secondaryInfoLabel.text = player.teamName + " | " + player.position
		teamLogo.image = getLogo(of: player.team)
	}
}
