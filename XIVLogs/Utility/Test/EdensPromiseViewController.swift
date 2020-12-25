//
//  EdensPromiseViewController.swift
//  XIVLogs
//
//  Created by Jon Corn on 12/24/20.
//

import UIKit

class EdensPromiseViewController: UIViewController {
    
    //  MARK: - Properties
    var encounters = [Encounter]() {
        didSet {
            updateViews()
        }
    }
    
    //  MARK: - Outlets
    // Character name and server labels
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var serverLabel: UILabel!
    // Parse Labels
    @IBOutlet weak var e9sParse: UILabel!
    @IBOutlet weak var e10sParse: UILabel!
    @IBOutlet weak var e11sParse: UILabel!
    @IBOutlet weak var e12sParse: UILabel!
    @IBOutlet weak var e12s2Parse: UILabel!
    // TextFields
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var serverTextField: UITextField!
    @IBOutlet weak var regionTextField: UITextField!
    // Views
    // e9s
    @IBOutlet weak var cloudImageView: UIImageView!
    @IBOutlet weak var cloudNameView: UIView!
    @IBOutlet weak var cloudParseView: UIView!
    
    //  MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //  MARK: - Actions
    @IBAction func searchButtonTapped(_ sender: Any) {
        nameLabel.text = ""
        serverLabel.text = ""
        e9sParse.text = ""
        e10sParse.text = ""
        e11sParse.text = ""
        e12sParse.text = ""
        e12s2Parse.text = ""
        fetchData()
    }
    
    //  MARK: - Methods
    func setupUI() {
        setupViews()
    }
    
    func setupViews() {
        StyleGuide.roundCorners(cloudImageView)
        StyleGuide.roundCorners(cloudNameView)
        StyleGuide.roundCorners(cloudParseView)
    }
    
    func fetchCloudOfDarkness() {
        var cloudEncounters = [Encounter]()
        for e in encounters {
            if e.difficulty == 101 && e.encounterName == "Cloud of Darkness" {
                cloudEncounters.append(e)
                let parseAsInt = Int(cloudEncounters[0].percentile)
                colorParse(parse: parseAsInt, parseLabel: self.e9sParse)
                e9sParse.text = String(parseAsInt)
            }
        }
    }
    
    func fetchShadowkeeper() {
        var shadowEncounters = [Encounter]()
        for e in encounters {
            if e.difficulty == 101 && e.encounterName == "Shadowkeeper" {
                shadowEncounters.append(e)
                let parseAsInt = Int(shadowEncounters[0].percentile)
                colorParse(parse: parseAsInt, parseLabel: self.e10sParse)
                e10sParse.text = String(parseAsInt)
            }
        }
    }
    
    func fetchFatebreaker() {
        var fateEncounters = [Encounter]()
        for e in encounters {
            if e.difficulty == 101 && e.encounterName == "Fatebreaker" {
                fateEncounters.append(e)
                let parseAsInt = Int(fateEncounters[0].percentile)
                colorParse(parse: parseAsInt, parseLabel: self.e11sParse)
                e11sParse.text = String(parseAsInt)
            }
        }
    }
    
    func fetchEdensPromise() {
        var edensEncounters = [Encounter]()
        for e in encounters {
            if e.difficulty == 101 && e.encounterName == "Eden's Promise" {
                edensEncounters.append(e)
                let parseAsInt = Int(edensEncounters[0].percentile)
                colorParse(parse: parseAsInt, parseLabel: self.e12sParse)
                e12sParse.text = String(parseAsInt)
            }
        }
    }
    
    func fetchOracleOfDarkness() {
        var oracleEncounters = [Encounter]()
        for e in encounters {
            if e.difficulty == 101 && e.encounterName == "Oracle of Darkness" {
                oracleEncounters.append(e)
                let parseAsInt = Int(oracleEncounters[0].percentile)
                colorParse(parse: parseAsInt, parseLabel: self.e12s2Parse)
                self.e12s2Parse.text = String(parseAsInt)
            }
        }
    }
    
    func updateNameLabel() {
        nameLabel.text = encounters[0].characterName
    }
    
    func updateServerLabel() {
        serverLabel.text = encounters[0].server
    }
    
    func updateViews() {
        updateNameLabel()
        updateServerLabel()
        fetchCloudOfDarkness()
        fetchShadowkeeper()
        fetchFatebreaker()
        fetchEdensPromise()
        fetchOracleOfDarkness()
    }
    
    func colorParse(parse: Int, parseLabel: UILabel) {
        if parse <= 24 {
            parseLabel.textColor = .gray
        } else if parse <= 49 {
            parseLabel.textColor = .green
        } else if parse <= 74 {
            parseLabel.textColor = .blue
        } else if parse <= 94 {
            parseLabel.textColor = .purple
        } else if parse <= 98 {
            parseLabel.textColor = .orange
        } else if parse <= 99 {
            StyleGuide.pinkParse(parseLabel)
        } else if parse <= 100 {
            parseLabel.textColor = .yellow
        }
    }
    
    func fetchData() {
        guard let name = nameTextField.text, !name.isEmpty,
              let server = serverTextField.text, !server.isEmpty,
              let region = regionTextField.text, !region.isEmpty else { return }
        EncounterController.fetchEncounter(with: name, server: server, region: region) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let encounters):
                    self.encounters = encounters
                case .failure(let error):
                    print(error, error.localizedDescription)
                }
            }
        }
    }
}
