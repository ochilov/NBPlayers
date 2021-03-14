//
//  TeamViewController.swift
//  NBPlayers
//
//  Created by JohnO on 09.03.2021.
//

import UIKit

class TeamViewController: UIViewController {

	@IBOutlet weak var teamLogo: UIImageView!
	@IBOutlet weak var cityLabel: UILabel!
	@IBOutlet weak var conferenceLabel: UILabel!
	var team: Team?
	
    override func viewDidLoad() {
        super.viewDidLoad()
		navigationItem.title = team?.name
		navigationController?.navigationBar.prefersLargeTitles = true
		
		teamLogo.image = getLogo(of: team)
		cityLabel.text = team?.city
		conferenceLabel.text = team?.conference
    }
}
