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
        let id: Int
        let startTime: Int
        let endTime: Int
        
        enum CodingKeys: String, CodingKey {
            case id
            case startTime = "start_time"
            case endTime = "end_time"
        }
    }
}
