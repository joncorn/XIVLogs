//
//  FFLogsStrings.swift
//  XIVLogs
//
//  Created by Jon Corn on 12/23/20.
//

import Foundation

struct FFLogsStrings {
    // Query
    static let apiKeyQueryName = "api_key"
    static let apiKeyQueryValue = "f0c9d89d280c4b67bd3c8af2b5c252be"
    static let metricQueryName = "metric"
    static let metricQueryValue = "rdps"
    static let timeFrameQueryName = "timeframe"
    static let timeFrameQueryValue = "historical"
    static let zoneQueryName = "zone"
    static let zoneEdensPromiseQueryValue = "38"
    static let zoneTrialsIIIQueryValue = "37"
    static let zoneTrialsIIQueryValue = "34"
    static let zonePuppetsBunkerQueryValue = "35"
    static let zoneCopiedFactoryQueryValue = "31"
    static let zoneEdensVerseQueryValue = "33"
    
    // URL
    static let baseURL = URL(string: "https://www.fflogs.com:443/v1")
    static let parsesPathComponent = "parses"
    static let characterPathComponent = "character"
}
