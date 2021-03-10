//
//  ApiClient.swift
//  NBPlayers
//
//  Created by JohnO on 10.03.2021.
//

import Foundation

enum ApiError: Error {
	case noData
}

protocol ApiClient {
	func getPlayers(completion: @escaping (Result<[Player], Error>) -> Void)
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
}
