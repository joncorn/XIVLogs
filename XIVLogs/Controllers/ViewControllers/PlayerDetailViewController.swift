//
//  PlayerDetailViewController.swift
//  XIVLogs
//
//  Created by Jon Corn on 12/26/20.
//

import UIKit

class PlayerDetailViewController: UIViewController {
    
    //  MARK: - Properties
    
    
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
        
        self.topParseListTableView.delegate = self
        self.topParseListTableView.dataSource = self
        
        setupUI()
    }
    
    //  MARK: - Methods
    func setupUI() {
        
    }
}

//  MARK: - TableViewDelegate/DataSource -
extension PlayerDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
    }
    
    
}
