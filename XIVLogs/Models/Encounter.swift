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
    let reportID: String
    let fightID: Int
    let server: String
    let percentile: Double
    let total: Double
    let ilvlKeyOrPatch: Double
}

extension Encounter: Equatable {
    static func == (lhs: Encounter, rhs: Encounter) -> Bool {
        lhs.encounterName == rhs.encounterName && lhs.reportID == rhs.reportID && lhs.fightID == rhs.fightID && lhs.total == rhs.total && lhs.percentile == rhs.percentile
    }
}
