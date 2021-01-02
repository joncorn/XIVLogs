//
//  EncounterLogsTableViewController.swift
//  XIVLogs
//
//  Created by Jon Corn on 12/27/20.
//

import UIKit

class EncounterLogsTableViewController: UITableViewController {

    //  MARK: - View Livecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
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

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "encounterCell", for: indexPath) as? EncounterTableViewCell else {return UITableViewCell()}

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
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
