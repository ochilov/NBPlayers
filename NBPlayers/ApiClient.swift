//
//  ApiClient.swift
//  NBPlayers
//
//  Created by JohnO on 10.03.2021.
//

import Foundation
import UIKit

enum ApiError: Error {
	case noData
}

protocol ApiClient {
	func getPlayers(completion: @escaping (Result<[Player], Error>) -> Void)
	func getGames(completion: @escaping (Result<[Game], Error>) -> Void)
}

class ApiClienrImpl: ApiClient {
	func getPlayers(completion: @escaping (Result<[Player], Error>) -> Void) {
		let session = URLSession.shared
		let url = URL(string: "https://www.balldontlie.io/api/v1/players")!
		let urlRequest = URLRequest(url: url)
		
		let dataTask = session.dataTask(with: urlRequest, completionHandler: {data, response, error in
			// Get data
			guard let data = data else {
				completion(.failure(ApiError.noData))
				return
			}
			
			// Decode data
			do {
				let decoder = JSONDecoder()
				let response = try decoder.decode(PlayersResponse.self, from: data)
				completion(.success(response.data))
			} catch(let error) {
				print(error)
				completion(.failure(error))
			}
		})
		
		dataTask.resume()
	}
	
	func getGames(completion: @escaping (Result<[Game], Error>) -> Void) {
		let session = URLSession.shared
		let url = URL(string: "https://www.balldontlie.io/api/v1/games")!
		let urlRequest = URLRequest(url: url)
		
		let dataTask = session.dataTask(with: urlRequest, completionHandler: {data, response, error in
			// Get data
			guard let data = data else {
				completion(.failure(ApiError.noData))
				return
			}
			// Decode data
			do {
				let decoder = JSONDecoder()
				
				let formatter = DateFormatter()
				formatter.dateFormat = "YYYY-MM-DD'T'hh:mm:ss.mmm'Z'"
				decoder.dateDecodingStrategy = .formatted(formatter)
				
				let response = try decoder.decode(GamesResponse.self, from: data)
				completion(.success(response.data))
			} catch(let error) {
				print(error)
				completion(.failure(error))
			}
		})
		
		dataTask.resume()
	}
}

func getLogo(of team: Team?) -> UIImage? {
	var logo = UIImage(named: "teamLogo_\(team?.id ?? 0)")
	if logo == nil {
		logo = UIImage(named:"teamLogo_none")
	}
	return logo
}
