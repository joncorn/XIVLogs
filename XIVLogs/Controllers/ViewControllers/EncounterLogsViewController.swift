//
//  EncounterLogsViewController.swift
//  XIVLogs
//
//  Created by Jon Corn on 1/2/21.
//

import UIKit

class EncounterLogsViewController: UIViewController {
    
    //  MARK: - Properties
    var encounterName: String?
    
    //  MARK: - Outlets
    @IBOutlet weak var encounterNameLabel: UILabel!
    @IBOutlet weak var encountersTableView: UITableView!
    
    //  MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.encountersTableView.delegate = self
        self.encountersTableView.dataSource = self
        
        updateViews()
        
    }
    
    //  MARK: - Methods
    func updateViews() {
        print(encounterName)
        encounterNameLabel.text = encounterName
        encounterNameLabel.textColor = .XIVLogsEncounterNameBlue
    }
    
}

//  MARK: - TableView datasource -
extension EncounterLogsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if FFLogsController.shared.cloudTapped == true {
            print(FFLogsController.shared.cloudOfDarknessEncounters, "cloud encounters")
            return FFLogsController.shared.cloudOfDarknessEncounters.count
        } else if FFLogsController.shared.shadowTapped == true {
            print(FFLogsController.shared.shadowKeeperEncounters, "shadow encounters")
            return FFLogsController.shared.shadowKeeperEncounters.count
        } else if FFLogsController.shared.fateTapped == true {
            print(FFLogsController.shared.fateBreakerEncounters, "fate encounters")
            return FFLogsController.shared.fateBreakerEncounters.count
        } else if FFLogsController.shared.edenTapped == true {
            print(FFLogsController.shared.EdensPromiseEncounters, "eden encounters")
            return FFLogsController.shared.EdensPromiseEncounters.count
        } else if FFLogsController.shared.oracleTapped == true {
            print(FFLogsController.shared.OracleOfDarknessEncounters, "oracle encounters")
            return FFLogsController.shared.OracleOfDarknessEncounters.count
        }
        
        return 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = encountersTableView.dequeueReusableCell(withIdentifier: "encounterCell") as? EncounterTableViewCell else {return UITableViewCell()}
        
        if FFLogsController.shared.cloudTapped == true {
            print(FFLogsController.shared.cloudOfDarknessEncounters, "cloud encounters")
            cell.encounters = FFLogsController.shared.cloudOfDarknessEncounters[indexPath.row]
        } else if FFLogsController.shared.shadowTapped == true {
            print(FFLogsController.shared.shadowKeeperEncounters, "shadow encounters")
            cell.encounters = FFLogsController.shared.shadowKeeperEncounters[indexPath.row]
        } else if FFLogsController.shared.fateTapped == true {
            print(FFLogsController.shared.fateBreakerEncounters, "fate encounters")
            cell.encounters = FFLogsController.shared.fateBreakerEncounters[indexPath.row]
        } else if FFLogsController.shared.edenTapped == true {
            print(FFLogsController.shared.EdensPromiseEncounters, "eden encounters")
            cell.encounters = FFLogsController.shared.EdensPromiseEncounters[indexPath.row]
        } else if FFLogsController.shared.oracleTapped == true {
            print(FFLogsController.shared.OracleOfDarknessEncounters, "oracle encounters")
            cell.encounters = FFLogsController.shared.OracleOfDarknessEncounters[indexPath.row]
        }
        
        return cell
    }
    
    
}