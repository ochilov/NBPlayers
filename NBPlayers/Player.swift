//
//  Player.swift
//  NBPlayers
//
//  Created by JohnO on 09.03.2021.
//

import Foundation

struct Player {
	let firstName: String
	let lastName: String
	
	let position: String
	
	let height: String
	
	var team: Team?
	
	var fullName: String {
		firstName + " " + lastName
	}
	
	var teamName: String {
		team?.fullName ?? ""
	}
}
