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
    var character: TopLevelDictionary.Character?
    
    //  MARK: - Outlets
    // Labels
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var specLabel: UILabel!
    @IBOutlet weak var percentileLabel: UILabel!
    @IBOutlet weak var encounterLabel: UILabel!
    // Text Fields
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var serverTextField: UITextField!
    @IBOutlet weak var regionTextField: UITextField!
    // TableViews
    @IBOutlet weak var parseTableView: UITableView!
    
    //  MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        parseTableView.delegate = self
    }
    
    //  MARK: - Actions
    @IBAction func searchButtonTapped(_ sender: Any) {
        
        guard let name = nameTextField.text, !name.isEmpty,
              let server = serverTextField.text, !server.isEmpty,
              let region = regionTextField.text, !region.isEmpty else { return }
        
        // Fetching array of encounter objects
//        FFLogsController.fetchZoneEncounters(with: name, server: server, region: region) { (result) in
//            DispatchQueue.main.async {
//                switch result {
//                case .success(let encounters):
//                    self.encounters = encounters
//                case .failure(let error):
//                    print(error, error.localizedDescription)
//                }
//                self.updateViews(with: self.encounters[0].characterName, spec: self.encounters[0].spec, percentile: self.encounters[0].percentile, encounter: self.encounters[0].encounterName)
//                
//                self.parseTableView.reloadData()
//            }
//        }
        
        
        // Fetching character data
//        CharacterController.fetchCharacter(with: TestStrings.charID) { (result) in
//            DispatchQueue.main.async {
//                switch result {
//                case .success(let character):
//                    self.character = character
//                case .failure(let error):
//                    print(error, error.localizedDescription)
//                }
//            }
//        }
    }
    
    //  MARK: - Methods
    func updateViews(with name: String, spec: String, percentile: Double, encounter: String) {
        nameLabel.text = name
        specLabel.text = spec
        percentileLabel.text = String(format: "%.0f", percentile)
        encounterLabel.text = encounter
        
    }
    
    // Fetching character avatar
//    func updateAvatar() {
//        guard let character = self.character else { return }
//        print(character.name)
//        print(character.server)
//        CharacterController.fetchAvatar(for: character) { (result) in
//            DispatchQueue.main.async {
//                switch result {
//                case .success(let avatar):
//                    self.avatarImageView.image = avatar
//                case .failure(let error):
//                    print(error, error.localizedDescription)
//                }
//            }
//        }
//    }
}

//  MARK: - Tableview data source -
extension TestViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return encounters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "parseCell", for: indexPath) as? ParseTableViewCell else {return UITableViewCell()}
        
        let encounter = encounters[indexPath.row]
        cell.encounter = encounter
        
        return cell
    }
}
