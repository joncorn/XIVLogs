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
        
        return cell
    }
    
    
}
