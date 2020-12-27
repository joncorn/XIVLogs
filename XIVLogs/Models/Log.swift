//
//  Log.swift
//  XIVLogs
//
//  Created by Jon Corn on 12/25/20.
//

import Foundation

struct Log: Decodable {
    let totalTime: Int
    let damageDone: [damageDone]
    let healingDone: [healingDone]
    let deathEvents: [deathEvents]
    
    struct damageDone: Decodable {
        let name: String
        let type: String
        let total: Int
    }
    
    struct healingDone: Decodable {
        let name: String
        let type: String
        let total: Int
    }
    
    struct deathEvents: Decodable {
        let name: String
    }
}
