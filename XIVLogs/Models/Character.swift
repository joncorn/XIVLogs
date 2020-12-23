//
//  Character.swift
//  XIVLogs
//
//  Created by Jon Corn on 12/23/20.
//

import Foundation

struct TopLevelDictionary: Decodable {
    let character: Character
    
    struct Character: Decodable {
        let avatar: URL
        let name: String
        let server: String
        
        enum CodingKeys: String, CodingKey {
            case avatar = "Avatar"
            case name = "Name"
            case server = "Sever"
        }
    }
}