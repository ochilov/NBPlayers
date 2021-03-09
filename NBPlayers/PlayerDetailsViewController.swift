//
//  PlayerDetailsViewController.swift
//  NBPlayers
//
//  Created by JohnO on 09.03.2021.
//

import UIKit

class PlayerDetailsViewController: UIViewController {
	
	@IBOutlet weak var positionLabel: UILabel!
	@IBOutlet weak var heightLabel: UILabel!
	@IBOutlet weak var teamDetails: UIButton!
	
	var player: Player?
	
    override func viewDidLoad() {
        super.viewDidLoad()
		navigationItem.title = player?.fullName
		navigationController?.navigationBar.prefersLargeTitles = true
		
		positionLabel.text = player?.position
		heightLabel.text = player?.height
		teamDetails.setTitle(player?.teamName, for: .normal)
    }
	
	@IBAction func onTeamDetailsTapped(_ sender: Any) {
		let storyboard = UIStoryboard(name: "Main", bundle: .main)
		let vc = storyboard.instantiateViewController(identifier: "TeamViewController") as! TeamViewController
		
		vc.team = player?.team
		navigationController?.pushViewController(vc, animated: true)
	}
}
