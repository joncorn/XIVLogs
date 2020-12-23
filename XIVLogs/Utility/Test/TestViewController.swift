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
    var character: TopLevelDictionary.Character? {
        didSet {
            updateViews()
        }
    }
    
    //  MARK: - Outlets
    @IBOutlet weak var avatarImageView: UIImageView!
    
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
            print(self.encounters[0].characterID)
        }
        CharacterController.fetchCharacter(with: TestStrings.charID) { (result) in
            switch result {
            case .success(let character):
                self.character = character
            case .failure(let error):
                print(error, error.localizedDescription)
            }
        }
    }
    
    //  MARK: - Methods
    func updateViews() {
        guard let character = self.character else { return }
        print(character.name)
        print(character.server)
        CharacterController.fetchAvatar(for: character) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let avatar):
                    self.avatarImageView.image = avatar
                case .failure(let error):
                    print(error, error.localizedDescription)
                }
            }
        }
    }
}
