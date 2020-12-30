//
//  PlayerDetailViewController.swift
//  XIVLogs
//
//  Created by Jon Corn on 12/26/20.
//

import UIKit

class PlayerDetailViewController: UIViewController {
    
    //  MARK: - Properties
    var encounterTier: String?
    var region: String = "Hydaelyn"
    
    //  MARK: - Outlets
    // Avatar
    @IBOutlet weak var playerAvatarImageView: UIImageView!
    // Labels
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var playerServerLabel: UILabel!
    @IBOutlet weak var zoneNameLabel: UILabel!
    // TableView
    @IBOutlet weak var topParseListTableView: UITableView!
    
    //  MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.playerNameLabel.text = FFLogsController.shared.encounters[0].characterName
        self.playerServerLabel.text = "\(FFLogsController.shared.encounters[0].server) (\(region))"
        
        self.zoneNameLabel.text = encounterTier
        
        self.topParseListTableView.delegate = self
        self.topParseListTableView.dataSource = self
        
        setupUI()
    }
    
    //  MARK: - Methods
    func setupUI() {
        setupNavBar()
    }
    
    /// Setup navbar back arrow
    func setupNavBar() {
        let backArrow = UIImage(named: "arrow.left")
        self.navigationController?.navigationBar.backIndicatorImage = backArrow
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backArrow
        self.navigationController?.navigationBar.backItem?.title = ""
    }
    
    /// Color parseLabel depending on number
    func colorParse(parse: Int, parseLabel: UILabel) {
        if parse <= 24 {
            StyleGuide.grayParse(parseLabel)
        } else if parse <= 49 {
            StyleGuide.greenParse(parseLabel)
        } else if parse <= 74 {
            StyleGuide.blueParse(parseLabel)
        } else if parse <= 94 {
            StyleGuide.purpleParse(parseLabel)
        } else if parse <= 98 {
            StyleGuide.orangeParse(parseLabel)
        } else if parse <= 99 {
            StyleGuide.pinkParse(parseLabel)
        } else if parse <= 100 {
            StyleGuide.goldParse(parseLabel)
        }
    }
    
    /// rDPS to correct format
    func rDPSFormatter(_ total: Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        guard let rDPS = numberFormatter.string(from: NSNumber(value: Double(round(10*total)/10))) else { return "" }
        return rDPS
    }
    
}

//  MARK: - TableViewDelegate/DataSource -
extension PlayerDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var counter = 0
        if encounterTier == "Eden's Promise (Savage)" {
            counter = 5
        } else if encounterTier == "Eden's Verse (Savage)" {
            counter = 4
        } else if encounterTier == "Trials II" {
            counter = 4
        } else if encounterTier == "Puppet's Bunker" {
            counter = 4
        } else if encounterTier == "Copied Factory" {
            counter = 4
        } else if encounterTier == "Trials III" {
            counter = 2
        }
        return counter
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.topParseListTableView.dequeueReusableCell(withIdentifier: "topParseCell", for: indexPath) as? topParseTableViewCell else {return UITableViewCell()}
        
        let encounter = FFLogsController.shared.topParsesOfEncounters[indexPath.row]
        
        colorParse(parse: Int(encounter.percentile), parseLabel: cell.parseLabel)
        
        cell.encounterNameLabel.text = encounter.encounterName
        cell.parseLabel.text = String(Int(encounter.percentile))
        cell.rDPSLabel.text = "rDPS: \(rDPSFormatter(encounter.total))"
        cell.parseSpecImageView.image = UIImage(named: encounter.spec)
        cell.rankLabel.text = "\(encounter.rank) / \(encounter.outOf)"
        cell.encounterImageView.image = UIImage(named: encounter.encounterName)
        
        StyleGuide.encounterColor(cell.encounterNameLabel)
        StyleGuide.rDPSColor(cell.rDPSLabel)
        
        StyleGuide.addDropShadowToView(cell.encounterView)
        StyleGuide.addDropShadowToView(cell.parseView)
        
        StyleGuide.roundCorners(cell.encounterView)
        StyleGuide.roundCorners(cell.parseView)
        StyleGuide.roundCorners(cell.encounterImageView)
        
        return cell
    }
    
    
}
