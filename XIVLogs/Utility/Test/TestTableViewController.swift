//
//  TestTableViewController.swift
//  XIVLogs
//
//  Created by Jon Corn on 12/24/20.
//

import UIKit

class TestTableViewController: UITableViewController {
    
    var encounters = [Encounter]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // Cloud of Darkness: Savage encounters
    var cloudOfDarkness = [Encounter]() {
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
        
        cell.textLabel?.text = encounter.encounterName
        cell.detailTextLabel?.text = String(format: "%.0f", encounter.percentile)

        return cell
    }
    
    //  MARK: - Methods
    func fetchData() {
        EncounterController.fetchEncounter(with: "mr whitekeys", server: TestStrings.server, region: TestStrings.region) { (result) in
            switch result {
            case .success(let encounters):
                // for each object in array, only append savage difficult objects
                for e in encounters {
                    if e.difficulty == 101 && e.encounterName == "Cloud of Darkness" {
                        self.encounters.append(e)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
