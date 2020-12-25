//
//  Encounter.swift
//  XIVLogs
//
//  Created by Jon Corn on 12/23/20.
//

import Foundation

struct Encounter: Decodable {
    let encounterName: String
    let spec: String
    let rank: Int
    let outOf: Int
    let difficulty: Int
    let characterID: Int
    let characterName: String
    let server: String
    let percentile: Double
    let total: Double
    let ilvlKeyOrPatch: Double
}
