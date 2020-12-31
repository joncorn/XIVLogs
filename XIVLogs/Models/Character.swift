//
//  Character.swift
//  XIVLogs
//
//  Created by Jon Corn on 12/23/20.
//

import Foundation

struct TopLevelDictionary: Decodable {
    let results: [PlayerResult]
    
    enum CodingKeys: String, CodingKey {
        case results = "Results"
    }
    
}

struct PlayerResult: Decodable {
    let avatar: URL?
    
    enum CodingKeys: String, CodingKey {
        case avatar = "Avatar"
    }
}

extension PlayerResult: Equatable {
    static func == (lhs: PlayerResult, rhs: PlayerResult) -> Bool {
        lhs.avatar == rhs.avatar
    }
}
