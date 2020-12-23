//
//  PlayerController.swift
//  XIVLogs
//
//  Created by Jon Corn on 12/22/20.
//

import Foundation

class PlayerController {
    
    //  MARK: - Methods
    static func fetchPlayer(with searchTerm: String, server: String, region: String, completion: @escaping (Result<[Player], PlayerError>) -> Void) {
        
        // Build URL with search terms
        guard let baseURL = StringHelpers.baseURL else {return completion(.failure(.invalidURL))}
        let parseURL = baseURL.appendingPathComponent(StringHelpers.parsesPathComponent)
        let characterURL = parseURL.appendingPathComponent(StringHelpers.characterPathComponent)
        let charSearchURL = characterURL.appendingPathComponent(searchTerm.lowercased())
        let serverURL = charSearchURL.appendingPathComponent(server.lowercased())
        let regionURL = serverURL.appendingPathComponent(region.lowercased())
        // API key query
        var components = URLComponents(url: regionURL, resolvingAgainstBaseURL: true)
        let apiQuery = URLQueryItem(name: StringHelpers.apiKeyQueryName, value: StringHelpers.apiKeyQueryValue)
        // Appends apikey query to end of url
        components?.queryItems = [apiQuery]
        guard let finalURL = components?.url else {return completion(.failure(.invalidURL))}
        
        // DataTask
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                print(error, error.localizedDescription)
                return completion(.failure(.thrownError(error)))
            }
            guard let data = data else {return completion(.failure(.noData))}
            do {
                let decoder = JSONDecoder()
                let player = try decoder.decode([Player].self, from: data)
                return completion(.success(player))
            } catch {
                print(error, error.localizedDescription)
                return completion(.failure(.thrownError(error)))
            }
        }.resume()
    }
}
