//
//  CharacterController.swift
//  XIVLogs
//
//  Created by Jon Corn on 12/23/20.
//

import Foundation
import UIKit.UIImage

class CharacterController {
    
    //  MARK: - Strings
    // API Key
    fileprivate static let apiKeyQueryName = "private_key"
    fileprivate static let apiKeyQueryValue = "d03f42ad6cbe47509e301ff5445b0719b85394a0a11b419689f650cc8ac0e559"
    // URL
    fileprivate static let baseURL = URL(string: "https://xivapi.com")
    fileprivate static let characterPathComponent = "character"
    
    //  MARK: - Methods
    static func fetchCharacter(with characterID: Int, completion: @escaping (Result<TopLevelDictionary.Character, CharacterError>) -> Void) {
        let stringID = String(characterID)
        guard let baseURL = baseURL else {return completion(.failure(.invalidURL))}
        let characterURL = baseURL.appendingPathComponent(characterPathComponent)
        let idURL = characterURL.appendingPathComponent(stringID)
        var components = URLComponents(url: idURL, resolvingAgainstBaseURL: true)
        let APIQuery = URLQueryItem(name: apiKeyQueryName, value: apiKeyQueryValue)
        components?.queryItems = [APIQuery]
        guard let finalURL = components?.url else {return completion(.failure(.invalidURL))}
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                print(error, error.localizedDescription)
                return completion(.failure(.thrownError(error)))
            }
            guard let data = data else {return completion(.failure(.noData))}
            do {
                let decoder = JSONDecoder()
                let characters = try decoder.decode(TopLevelDictionary.Character.self, from: data)
                completion(.success(characters))
            } catch {
                print(error, error.localizedDescription)
                return completion(.failure(.thrownError(error)))
            }
        }.resume()
    }
    
    static func fetchAvatar(for character: TopLevelDictionary.Character, completion: @escaping (Result<UIImage, CharacterError>) -> Void) {
        let url = character.avatar
        print(url)
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print(error, error.localizedDescription)
                return completion(.failure(.thrownError(error)))
            }
            guard let data = data else {return completion(.failure(.noData))}
            guard let avatar = UIImage(data: data) else {return completion(.failure(.unableToDecode))}
            completion(.success(avatar))
        }.resume()
    }
}
