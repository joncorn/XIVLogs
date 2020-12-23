//
//  TestViewController.swift
//  XIVLogs
//
//  Created by Jon Corn on 12/23/20.
//

import UIKit

class TestViewController: UIViewController {
    
    //  MARK: - Properties
    var encounters = [Encounter]()
    
    //  MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //  MARK: - Actions
    @IBAction func searchButtonTapped(_ sender: Any) {
        EncounterController.fetchEncounter(with: TestStrings.name, server: TestStrings.server, region: TestStrings.region) { (result) in
            switch result {
            case .success(let encounters):
                self.encounters = encounters
            case .failure(let error):
                print(error, error.localizedDescription)
            }
            print(self.encounters.count)
            print(self.encounters[0].characterID)
        }
    }
}
