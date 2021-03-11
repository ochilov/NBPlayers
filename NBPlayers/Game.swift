//
//  Game.swift
//  NBPlayers
//
//  Created by JohnO on 11.03.2021.
//

import Foundation

// MARK: - GamesResponse
struct GamesResponse: Decodable {
	let data: [Game]
}


// MARK: - Game
struct Game: Decodable {
	let date: Date
	let season: Int?
	let period: Int?
	let postseason: Bool?
	let status: String
	let time: String
	
	let homeTeam: Team
	let visitorTeam: Team
	let homeTeamScore: Int?
	let visitorTeamScore: Int?
	
	var winnerTeam: Team? {
		guard let homeScore = homeTeamScore, let visitorScore = visitorTeamScore else {
			return nil
		}
		if homeScore == visitorScore {
			return nil
		}
		return homeScore > visitorScore ? homeTeam : visitorTeam
	}
	
	enum CodingKeys: String, CodingKey {
		case date = "date"
		case season = "season"
		case period = "period"
		case postseason = "postseason"
		case status = "status"
		case time = "time"
		case homeTeam = "home_team"
		case visitorTeam = "visitor_team"
		case homeTeamScore = "home_team_score"
		case visitorTeamScore = "visitor_team_score"
	}
}
