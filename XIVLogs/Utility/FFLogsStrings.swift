//
//  FFLogsStrings.swift
//  XIVLogs
//
//  Created by Jon Corn on 12/23/20.
//

import Foundation

struct FFLogsStrings {
    // API key query
    static let apiKeyQueryName = "api_key"
    static let apiKeyQueryValue = "f0c9d89d280c4b67bd3c8af2b5c252be"
    // Queries
    static let metricQueryName = "metric"
    static let metricQueryValue = "rdps"
    static let timeFrameQueryName = "timeframe"
    static let timeFrameQueryValue = "historical"
    static let startQueryName = "start"
    static let endQueryName = "end"
    // Zones
    static let zoneQueryName = "zone"
    static let zoneEdensPromiseQueryValue = "38"
    static let zoneTrialsIIIQueryValue = "37"
    static let zoneTrialsIIQueryValue = "34"
    static let zonePuppetsBunkerQueryValue = "35"
    static let zoneCopiedFactoryQueryValue = "31"
    static let zoneEdensVerseQueryValue = "33"
    // baseURL + components
    static let baseURL = URL(string: "https://www.fflogs.com:443/v1")
    static let parsesPathComponent = "parses"
    static let characterPathComponent = "character"
    static let reportPathComponent = "report"
    static let fightsPathComponent = "fights"
    static let viewPathComponent = "view"
    static let tablesPathComponent = "tables"
    static let summaryPathComponent = "summary"
}
