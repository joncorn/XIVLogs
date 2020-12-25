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
    // e9s Views
    @IBOutlet weak var cloudImageView: UIImageView!
    @IBOutlet weak var cloudNameView: UIView!
    @IBOutlet weak var cloudParseView: UIView!
    @IBOutlet weak var cloudSpecImageView: UIImageView!
    @IBOutlet weak var cloudNameLabel: UILabel!
    // e10s Views
    @IBOutlet weak var shadowImageView: UIImageView!
    @IBOutlet weak var shadowNameView: UIView!
    @IBOutlet weak var shadowParseView: UIView!
    @IBOutlet weak var shadowSpecImageView: UIImageView!
    @IBOutlet weak var shadowNameLabel: UILabel!
    // e11s Views
    @IBOutlet weak var fateImageView: UIImageView!
    @IBOutlet weak var fateNameView: UIView!
    @IBOutlet weak var fateParseView: UIView!
    @IBOutlet weak var fateSpecImageView: UIImageView!
    @IBOutlet weak var fateNameLabel: UILabel!
    // e12s Views
    @IBOutlet weak var edenImageView: UIImageView!
    @IBOutlet weak var edenNameView: UIView!
    @IBOutlet weak var edenParseView: UIView!
    @IBOutlet weak var edenSpecImageView: UIImageView!
    @IBOutlet weak var edenNameLabel: UILabel!
    // e12s2 Views
    @IBOutlet weak var oracleImageView: UIImageView!
    @IBOutlet weak var oracleNameView: UIView!
    @IBOutlet weak var oracleParseView: UIView!
    @IBOutlet weak var oracleSpecImageView: UIImageView!
    @IBOutlet weak var oracleNameLabel: UILabel!
    
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
        setupLabels()
    }
    
    func setupViews() {
        StyleGuide.roundCorners(cloudImageView)
        StyleGuide.roundCorners(cloudNameView)
        StyleGuide.roundCorners(cloudParseView)
        
        StyleGuide.roundCorners(shadowImageView)
        StyleGuide.roundCorners(shadowNameView)
        StyleGuide.roundCorners(shadowParseView)
        
        StyleGuide.roundCorners(fateImageView)
        StyleGuide.roundCorners(fateNameView)
        StyleGuide.roundCorners(fateParseView)
        
        StyleGuide.roundCorners(edenImageView)
        StyleGuide.roundCorners(edenNameView)
        StyleGuide.roundCorners(edenParseView)
        
        StyleGuide.roundCorners(oracleImageView)
        StyleGuide.roundCorners(oracleNameView)
        StyleGuide.roundCorners(oracleParseView)
    }
    
    func setupLabels() {
        StyleGuide.encounterColor(cloudNameLabel)
        StyleGuide.encounterColor(shadowNameLabel)
        StyleGuide.encounterColor(fateNameLabel)
        StyleGuide.encounterColor(edenNameLabel)
        StyleGuide.encounterColor(oracleNameLabel)
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
            StyleGuide.grayParse(parseLabel)
        } else if parse <= 49 {
            StyleGuide.greenParse(parseLabel)
        } else if parse <= 74 {
            StyleGuide.blueParse(parseLabel)
        } else if parse <= 94 {
            StyleGuide.purpleParse(parseLabel)
        } else if parse <= 98 {
            StyleGuide.orangeParse(parseLabel)
        } else if parse <= 99 {
            StyleGuide.pinkParse(parseLabel)
        } else if parse <= 100 {
            StyleGuide.goldParse(parseLabel)
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
