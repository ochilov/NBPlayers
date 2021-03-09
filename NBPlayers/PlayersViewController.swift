//
//  PlayersViewController.swift
//  NBPlayers
//
//  Created by JohnO on 09.03.2021.
//

import UIKit

// MARK: - PlayersVC
class PlayersViewController: UIViewController {
	var teams: [Team] = []
	var players: [Player] = []
	
    override func viewDidLoad() {
        super.viewDidLoad()
		navigationItem.title = "Players"
		navigationController?.navigationBar.prefersLargeTitles = true
		
		// Init/Load Data
		teams.append(contentsOf: [
			Team(name: "Lakers", city: "Los Angeles", conference: "West"),
			Team(name: "Heat", city: "Miami", conference: "East")
		])
		
		players.append(contentsOf: [
			Player(
				firstName: "LeBron",
				lastName: "James",
				position: "SF",
				height: "6'8''",
				team: getTeam(by: "Lakers")
			),
			Player(
				firstName: "Anthony",
				lastName: "Davis",
				position: "PF",
				height: "7'0''",
				team: getTeam(by: "Lakers")
			),
			Player(
				firstName: "Jimmy",
				lastName: "Butler",
				position: "SG",
				height: "6'6''",
				team: getTeam(by: "Heat")
			)
		])
    }
	
	func getTeam(by name: String) -> Team? {
		return teams.first {$0.name == name}
	}
}


// MARK: - Players Data Source
extension PlayersViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return players.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerCell", for: indexPath)
		let player = players[indexPath.row]
		
		cell.textLabel?.text = player.fullName
		cell.detailTextLabel?.text = player.teamName
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
