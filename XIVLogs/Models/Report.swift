//
//  Report.swift
//  XIVLogs
//
//  Created by Jon Corn on 12/25/20.
//

import Foundation

struct Report: Decodable {
    let fights: [Fights]
    
    struct Fights: Decodable {
        let startTime: String
        let endTime: String
        
        enum CodingKeys: String, CodingKey {
            case startTime = "start_time"
            case endTime = "end_time"
        }
    }
}
