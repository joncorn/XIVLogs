//
//  EncounterController.swift
//  XIVLogs
//
//  Created by Jon Corn on 12/23/20.
//

import Foundation

class FFLogsController {
    
    //  MARK: - Strings
    // API Key
    fileprivate static let apiKeyQueryName = "api_key"
    fileprivate static let apiKeyQueryValue = "f0c9d89d280c4b67bd3c8af2b5c252be"
    // Query
    fileprivate static let metricQueryName = "metric"
    fileprivate static let metricQueryValue = "rdps"
    fileprivate static let timeFrameQueryName = "timeframe"
    fileprivate static let timeFrameQueryValue = "historical"
    // Zones
    fileprivate static let zoneQueryName = "zone"
    fileprivate static let zoneEdensPromiseQueryValue = "38"
    fileprivate static let zoneTrialsIIIQueryValue = "37"
    fileprivate static let zoneTrialsIIQueryValue = "34"
    fileprivate static let zonePuppetsBunkerQueryValue = "35"
    fileprivate static let zoneCopiedFactoryQueryValue = "31"
    fileprivate static let zoneEdensVerseQueryValue = "33"
    // baseURL
    fileprivate static let baseURL = URL(string: "https://www.fflogs.com:443/v1")
    // Parses
    fileprivate static let parsesPathComponent = "parses"
    fileprivate static let characterPathComponent = "character"
    // Report
    fileprivate static let reportPathComponent = "report"
    fileprivate static let fightsPathComponent = "fights"
    fileprivate static let tablesPathComponent = "tables"
    fileprivate static let summaryPathComponent = "summary"
    
    //  MARK: - Containers
    // Singleton
    static let shared = FFLogsController()
    
    /// Holds encounter objects fetched from api
    var encounters = [Encounter]() {
        didSet {
            
            
            topParsesOfEncounters = []
            cloudOfDarknessEncounters = []
            shadowKeeperEncounters = []
            fateBreakerEncounters = []
            EdensPromiseEncounters = []
            OracleOfDarknessEncounters = []
            
            appendCloudOfDarkness(fromEncounters: encounters)
            appendShadowkeeper(fromEncounters: encounters)
            appendFatebreaker(fromEncounters: encounters)
            appendEdensPromise(fromEncounters: encounters)
            appendOracleOfDarkness(fromEncounters: encounters)
            print(cloudOfDarknessEncounters)
        }
    }
    
    // Eden's Promise (Savage) containers
    var cloudOfDarknessEncounters = [Encounter]()
    var shadowKeeperEncounters = [Encounter]()
    var fateBreakerEncounters = [Encounter]()
    var EdensPromiseEncounters = [Encounter]()
    var OracleOfDarknessEncounters = [Encounter]()
    // Top parses container
    var topParsesOfEncounters = [Encounter]()
    
    // Server List, sorted alphabetically, grouped by datacenter
    let servers = [
        // Aether DC - NA
        "Adamantoise",
        "Cactuar",
        "Faerie",
        "Gilgamesh",
        "Jenova",
        "Midgardsormr",
        "Sargatanas",
        "Siren",
        // Crystal DC - NA
        "Balmung",
        "Brynhildr",
        "Coeurl",
        "Diabolos",
        "Goblin",
        "Malboro",
        "Mateus",
        "Zalera",
        // Primal DC - NA
        "Behemoth",
        "Excalibur",
        "Exodus",
        "Famfrit",
        "Hyperion",
        "Lamia",
        "Leviathan",
        "Ultros",
        // Chaos DC - EU
        "Cerberus",
        "Louisoix",
        "Moogle",
        "Omega",
        "Ragnarok",
        // Light DC - EU
        "Lich",
        "Odin",
        "Phoenix",
        "Shiva",
        "Zodiark",
        // Elemental DC - JP
        "Aegis",
        "Atomos",
        "Carbuncle",
        "Garuda",
        "Gungnir",
        "Kujata",
        "Ramuh",
        "Tonberry",
        "Typhon",
        "Unicorn",
        // Gaia DC - JP
        "Alexander",
        "Bahamut",
        "Durandal",
        "Fenrir",
        "Ifrit",
        "Ridill",
        "Tiamat",
        "Ultima",
        "Valefor",
        "Yojimbo",
        "Zeromus",
        // Mana DC - JP
        "Anima",
        "Asura",
        "Belias",
        "Chocobo",
        "Hades",
        "Ixion",
        "Mandragora",
        "Masamune",
        "Pandemonium",
        "Shinryu",
        "Titan"]
    
    let regions = ["NA",
                   "EU",
                   "JP"]
    
    let zoneStrings = ["Eden's Promise (Savage)",
                 "Eden's Verse (Savage)",
                 "Trials III",
                 "Trials II",
                 "Puppet's Bunker",
                 "Copied Factory"]
    
    let zoneInts = [38,
                    33,
                    37,
                    34,
                    35,
                    31]
    
    //  MARK: - Network Methods
    static func fetchZoneEncounters(name: String, server: String, region: String, zone: String, completion: @escaping (Result<[Encounter], FFLogsError>) -> Void) {
        
        // Build URL with search terms
        guard let baseURL = FFLogsStrings.baseURL else {return completion(.failure(.invalidURL))}
        let parseURL = baseURL.appendingPathComponent(FFLogsStrings.parsesPathComponent)
        let characterURL = parseURL.appendingPathComponent(FFLogsStrings.characterPathComponent)
        let charSearchURL = characterURL.appendingPathComponent(name.lowercased())
        let serverURL = charSearchURL.appendingPathComponent(server.lowercased())
        let regionURL = serverURL.appendingPathComponent(region.lowercased())
        
        // Queries
        var components = URLComponents(url: regionURL, resolvingAgainstBaseURL: true)
        let zoneQuery = URLQueryItem(name: FFLogsStrings.zoneQueryName, value: zone)
        let metricQuery = URLQueryItem(name: FFLogsStrings.metricQueryName, value: FFLogsStrings.metricQueryValue)
        let timeFrameQuery = URLQueryItem(name: FFLogsStrings.timeFrameQueryName, value: FFLogsStrings.timeFrameQueryValue)
        let apiQuery = URLQueryItem(name: FFLogsStrings.apiKeyQueryName, value: FFLogsStrings.apiKeyQueryValue)
        
        // Appends queries to end of url
        components?.queryItems = [zoneQuery, metricQuery, timeFrameQuery, apiQuery]
        guard let finalURL = components?.url else {return completion(.failure(.invalidURL))}
        
        // DataTask
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                print(error, error.localizedDescription)
                return completion(.failure(.thrownError(error)))
            }
            guard let data = data else {return completion(.failure(.noData))}
            do {
                let encounter = try JSONDecoder().decode([Encounter].self, from: data)
                return completion(.success(encounter))
            } catch {
                print(error, error.localizedDescription)
                completion(.failure(.thrownError(error)))
            }
        }.resume()
    }
    
    static func fetchReport(withReportID reportID: String, completion: @escaping (Result<Report, FFLogsError>) -> Void) {
        
        // Build URL with reportID
        guard let baseURL = FFLogsStrings.baseURL else {return completion(.failure(.invalidURL))}
        let reportURL = baseURL.appendingPathComponent(FFLogsStrings.reportPathComponent)
        let fightsURL = reportURL.appendingPathComponent(FFLogsStrings.fightsPathComponent)
        let reportIDURL = fightsURL.appendingPathComponent(reportID)
        
        // Queries
        var components = URLComponents(url: reportIDURL, resolvingAgainstBaseURL: true)
        let apiQuery = URLQueryItem(name: FFLogsStrings.apiKeyQueryName, value: FFLogsStrings.apiKeyQueryValue)
        
        // Appends api key to end of url
        components?.queryItems = [apiQuery]
        guard let finalURL = components?.url else {return completion(.failure(.invalidURL))}
        
        // DataTask
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                print(error, error.localizedDescription)
                return completion(.failure(.thrownError(error)))
            }
            guard let data = data else {return completion(.failure(.noData))}
            do {
                let report = try JSONDecoder().decode(Report.self, from: data)
                completion(.success(report))
            } catch {
                print(error, error.localizedDescription)
                completion(.failure(.thrownError(error)))
            }
        }.resume()
    }
    
    static func fetchLog(withReportID reportID: String, startTime: Int, endTime: Int, completion: @escaping (Result<Log, FFLogsError>) -> Void) {
        
        // startTime and endTime converted into string for URL
        let startString = String(startTime)
        let endString = String(endTime)
        
        // Build URL with reportID, startTime, and endTime
        guard let baseURL = FFLogsStrings.baseURL else {return completion(.failure(.invalidURL))}
        let reportURL = baseURL.appendingPathComponent(FFLogsStrings.reportPathComponent)
        let tablesURL = reportURL.appendingPathComponent(FFLogsStrings.tablesPathComponent)
        let summaryURL = tablesURL.appendingPathComponent(FFLogsStrings.summaryPathComponent)
        let reportIDURL = summaryURL.appendingPathComponent(reportID)
        
        // Queries
        var components = URLComponents(url: reportIDURL, resolvingAgainstBaseURL: true)
        let startQuery = URLQueryItem(name: FFLogsStrings.startQueryName, value: startString)
        let endQuery = URLQueryItem(name: FFLogsStrings.endQueryName, value: endString)
        let apiQuery = URLQueryItem(name: FFLogsStrings.apiKeyQueryName, value: FFLogsStrings.apiKeyQueryValue)
        
        // Appending queries
        components?.queryItems = [startQuery, endQuery, apiQuery]
        guard let finalURL = components?.url else {return completion(.failure(.invalidURL))}
        
        // DataTask
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                print(error, error.localizedDescription)
                return completion(.failure(.thrownError(error)))
            }
            guard let data = data else {return completion(.failure(.noData))}
            do {
                let log = try JSONDecoder().decode(Log.self, from: data)
                completion(.success(log))
            } catch {
                print(error, error.localizedDescription)
                completion(.failure(.thrownError(error)))
            }
        }.resume()
    }
    
    //  MARK: - Methods
    
    
    //  MARK: - Sorting Methods
    
    func appendCloudOfDarkness(fromEncounters encounters: [Encounter]) {
        for e in encounters {
            if e.encounterName == "Cloud of Darkness" && e.difficulty == 101 {
                self.cloudOfDarknessEncounters.append(e)
            }
        }
    }
    
    func appendShadowkeeper(fromEncounters encounter: [Encounter]) {
        for e in encounter {
            if e.encounterName == "Shadowkeeper" && e.difficulty == 101 {
                self.shadowKeeperEncounters.append(e)
            }
        }
    }
    
    func appendFatebreaker(fromEncounters encounter: [Encounter]) {
        for e in encounter {
            if e.encounterName == "Fatebreaker" && e.difficulty == 101 {
                self.fateBreakerEncounters.append(e)
            }
        }
    }
    
    func appendEdensPromise(fromEncounters encounter: [Encounter]) {
        for e in encounter {
            if e.encounterName == "Eden's Promise" && e.difficulty == 101 {
                self.EdensPromiseEncounters.append(e)
            }
        }
    }
    
    func appendOracleOfDarkness(fromEncounters encounter: [Encounter]) {
        for e in encounter {
            if e.encounterName == "Oracle of Darkness" && e.difficulty == 101 {
                self.OracleOfDarknessEncounters.append(e)
            }
        }
    }
}
