//
//  CharacterController.swift
//  XIVLogs
//
//  Created by Jon Corn on 12/23/20.
//

import Foundation
import UIKit.UIImage

//  MARK: - PlayerDetailProtocol
protocol XivApiControllerDelegate: class {
    func setPlayerAvatar(_ sender: XivApiController)
}

//  MARK: - XivApiController class
class XivApiController {
    
    //  MARK: - Strings
    // API Key
    fileprivate static let apiKeyQueryName = "private_key"
    fileprivate static let apiKeyQueryValue = "d03f42ad6cbe47509e301ff5445b0719b85394a0a11b419689f650cc8ac0e559"
    // URL
    fileprivate static let baseURL = URL(string: "https://xivapi.com")
    fileprivate static let characterPathComponent = "character"
    fileprivate static let searchPathComponent = "search"
    // Queries
    fileprivate static let nameQueryName = "name"
    fileprivate static let serverQueryName = "server"
        
    //  MARK: - Properties
    static let shared = XivApiController()
    weak var delegate: XivApiControllerDelegate?
    
    var playerResults = [PlayerResult]() {
        didSet {
            if playerResults != [] {
                fetchAvatar(for: playerResults[0]) { (result) in
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let image):
                            print("got image")
                            self.playerAvatar = image
                        case .failure(let error):
                            print(error, error.localizedDescription)
                            print("no image")
                        }
                    }
                }
            }
        }
    }
    var playerAvatar: UIImage? {
        didSet {
            delegate?.setPlayerAvatar(self)
        }
    }

    //  MARK: - Methods
    static func searchCharacter(withName name: String, withServer server: String, completion: @escaping (Result<[PlayerResult], CharacterError>) -> Void) {
        guard let baseURL = baseURL else {return completion(.failure(.invalidURL))}
        let characterURL = baseURL.appendingPathComponent(characterPathComponent)
        let searchURL = characterURL.appendingPathComponent(searchPathComponent)
        var components = URLComponents(url: searchURL, resolvingAgainstBaseURL: true)
        let nameQuery = URLQueryItem(name: nameQueryName, value: name)
        let serverQuery = URLQueryItem(name: serverQueryName, value: server)
        components?.queryItems = [nameQuery, serverQuery]
        guard let finalURL = components?.url else {return completion(.failure(.invalidURL))}
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                print(error, error.localizedDescription)
                return completion(.failure(.thrownError(error)))
            }
            guard let data = data else {return completion(.failure(.noData))}
            do {
                let decoder = JSONDecoder()
                let TopLevelDict = try decoder.decode(TopLevelDictionary.self, from: data)
                return completion(.success(TopLevelDict.results))
                
            } catch {
                print(error, error.localizedDescription)
                return completion(.failure(.thrownError(error)))
            }
        }.resume()
    }
    
//    static func fetchCharacter(with characterID: Int, completion: @escaping (Result<Character, CharacterError>) -> Void) {
//        let stringID = String(characterID)
//        guard let baseURL = baseURL else {return completion(.failure(.invalidURL))}
//        let characterURL = baseURL.appendingPathComponent(characterPathComponent)
//        let idURL = characterURL.appendingPathComponent(stringID)
//        var components = URLComponents(url: idURL, resolvingAgainstBaseURL: true)
//        let APIQuery = URLQueryItem(name: apiKeyQueryName, value: apiKeyQueryValue)
//        components?.queryItems = [APIQuery]
//        guard let finalURL = components?.url else {return completion(.failure(.invalidURL))}
//        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
//            if let error = error {
//                print(error, error.localizedDescription)
//                return completion(.failure(.thrownError(error)))
//            }
//            guard let data = data else {return completion(.failure(.noData))}
//            do {
//                let decoder = JSONDecoder()
//                let TopLevelDict = try decoder.decode(TopLevelDictionary.self, from: data)
//                return completion(.success(TopLevelDict.character))
//            } catch {
//                print(error, error.localizedDescription)
//                return completion(.failure(.thrownError(error)))
//            }
//        }.resume()
//    }
    
    func fetchAvatar(for character: PlayerResult, completion: @escaping (Result<UIImage, CharacterError>) -> Void) {
        guard let url = character.avatar else {return completion(.failure(.invalidURL))}
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print(error, error.localizedDescription)
                return completion(.failure(.thrownError(error)))
            }
            guard let data = data else {return completion(.failure(.noData))}
            guard let playerAvatar = UIImage(data: data) else {return completion(.failure(.noData))}
            return completion(.success(playerAvatar))
        }.resume()
    }
}
