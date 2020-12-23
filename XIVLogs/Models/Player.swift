//
//  Player.swift
//  XIVLogs
//
//  Created by Jon Corn on 12/22/20.
//

import Foundation

struct Player: Decodable {
    let encounterName: String
    let spec: String
    let rank: Int
    let outOf: Int
    let difficulty: Int
    let characterID: Int
    let characterName: String
    let server: String
    let percentile: Int
    let ilvlKeyOrPatch: Double
}
