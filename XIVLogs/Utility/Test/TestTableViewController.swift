//
//  TestTableViewController.swift
//  XIVLogs
//
//  Created by Jon Corn on 12/24/20.
//

import UIKit

class TestTableViewController: UITableViewController {
    
    var characterID: Int?
    
    var encounters = [Encounter]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // Cloud of Darkness: Savage encounters
    var cloudOfDarkness: Encounter? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loadButtonTapped(_ sender: Any) {
        fetchData()
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return encounters.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "encounterCell", for: indexPath)

        let encounter = encounters[indexPath.row]
        let parseAsInt = Int(encounter.percentile)
        
        cell.textLabel?.text = encounter.encounterName
        cell.detailTextLabel?.text = String(parseAsInt)
        
        let ep = parseAsInt
        
        if ep <= 24 {
            cell.detailTextLabel?.textColor = .gray
        } else if ep <= 49 {
            cell.detailTextLabel?.textColor = .green
        } else if ep <= 74 {
            cell.detailTextLabel?.textColor = .blue
        } else if ep <= 94 {
            cell.detailTextLabel?.textColor = .purple
        } else if ep <= 98 {
            cell.detailTextLabel?.textColor = .orange
        } else if ep <= 99 {
            cell.detailTextLabel?.textColor = .systemPink
        } else if ep <= 100 {
            cell.detailTextLabel?.textColor = .yellow
        }

        return cell
    }
    
    //  MARK: - Methods
    func fetchData() {
        // resets encounters array to empty before performing fetch
        encounters = []
        
//        FFLogsController.fetchZoneEncounters(with: "kai leonte", server: "faerie", region: "na") { (result) in
//            switch result {
//            case .success(let encounters):
//                // for each object in array, only append highest parse of selected fight
//                for e in encounters {
//                    if e.difficulty == 101 {
////                    if e.difficulty == 101 && e.encounterName == "Cloud of Darkness" && e.percentile >= encounters[0].percentile {
//                        self.encounters.append(e)
//                        self.characterID = e.characterID
//                    }
//                }
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }
}
}
