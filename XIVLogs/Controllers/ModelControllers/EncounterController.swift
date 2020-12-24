//
//  EncounterController.swift
//  XIVLogs
//
//  Created by Jon Corn on 12/23/20.
//

import Foundation

class EncounterController {
    
    //  MARK: - Strings
    // API Key
    fileprivate static let apiKeyQueryName = "api_key"
    fileprivate static let apiKeyQueryValue = "f0c9d89d280c4b67bd3c8af2b5c252be"
    // Query
    fileprivate static let metricQueryName = "metric"
    fileprivate static let metricQueryValue = "rdps"
    fileprivate static let timeFrameQueryName = "timeframe"
    fileprivate static let timeFrameQueryValue = "historical"
    fileprivate static let zoneQueryName = "zone"
    fileprivate static let zoneEdensPromiseQueryValue = "38"
    fileprivate static let zoneTrialsIIIQueryValue = "37"
    fileprivate static let zoneTrialsIIQueryValue = "34"
    fileprivate static let zonePuppetsBunkerQueryValue = "35"
    fileprivate static let zoneCopiedFactoryQueryValue = "31"
    fileprivate static let zoneEdensVerseQueryValue = "33"
    // URL
    fileprivate static let baseURL = URL(string: "https://www.fflogs.com:443/v1")
    fileprivate static let parsesPathComponent = "parses"
    fileprivate static let characterPathComponent = "character"
    
    //  MARK: - Methods
    static func fetchEncounter(with name: String, server: String, region: String, completion: @escaping (Result<[Encounter], EncounterError>) -> Void) {
        
        // Build URL with search terms
        guard let baseURL = FFLogsStrings.baseURL else {return completion(.failure(.invalidURL))}
        let parseURL = baseURL.appendingPathComponent(FFLogsStrings.parsesPathComponent)
        let characterURL = parseURL.appendingPathComponent(FFLogsStrings.characterPathComponent)
        let charSearchURL = characterURL.appendingPathComponent(name.lowercased())
        let serverURL = charSearchURL.appendingPathComponent(server.lowercased())
        let regionURL = serverURL.appendingPathComponent(region.lowercased())
        
        // API key query
        var components = URLComponents(url: regionURL, resolvingAgainstBaseURL: true)
        let zoneQuery = URLQueryItem(name: FFLogsStrings.zoneQueryName, value: FFLogsStrings.zoneEdensPromiseQueryValue)
        let metricQuery = URLQueryItem(name: FFLogsStrings.metricQueryName, value: FFLogsStrings.metricQueryValue)
        let timeFrameQuery = URLQueryItem(name: FFLogsStrings.timeFrameQueryName, value: FFLogsStrings.timeFrameQueryValue)
        let apiQuery = URLQueryItem(name: FFLogsStrings.apiKeyQueryName, value: FFLogsStrings.apiKeyQueryValue)
        
        // Appends apikey query to end of url
        components?.queryItems = [zoneQuery, metricQuery, timeFrameQuery, apiQuery]
        guard let finalURL = components?.url else {return completion(.failure(.invalidURL))}
        
        // DataTask
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                print(error, error.localizedDescription)
                return completion(.failure(.thrownError(error)))
            }
            guard let data = data else {return completion(.failure(.noData))}
            do {
                let encounter = try JSONDecoder().decode([Encounter].self, from: data)
                return completion(.success(encounter))
            } catch {
                print(error, error.localizedDescription)
                completion(.failure(.thrownError(error)))
            }
        }.resume()
    }
}
