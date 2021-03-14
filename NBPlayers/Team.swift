//
//  Team.swift
//  NBPlayers
//
//  Created by JohnO on 09.03.2021.
//

import Foundation

struct Team: Decodable, Equatable {
	let id: Int?
	let name: String
	let city: String
	let conference: String
	let abbreviation: String
	let division: String
	
	var fullName: String {
		city + " " + name
	}
}
