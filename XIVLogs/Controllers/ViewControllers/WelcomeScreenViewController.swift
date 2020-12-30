//
//  WelcomeScreenViewController.swift
//  XIVLogs
//
//  Created by Jon Corn on 12/26/20.
//

import UIKit

class WelcomeScreenViewController: UIViewController {
    
    //  MARK: - Properties
    
    /// PickerView to present as keyboard
    var serverPicker: serverPickerView?
    var regionPicker: regionPickerView?
    var zonePicker: zonePickerView?
    
    /// A toolbar to add to the keyboard when the `picker` is presented.
    var serverPickerAccessory: UIToolbar?
    var regionPickerAccessory: UIToolbar?
    var zonePickerAccessory: UIToolbar?
    
    //  MARK: - Outlets
    // Logo image
    @IBOutlet weak var logoImageView: UIImageView!
    // Labels
    @IBOutlet weak var welcomeTextTable: UILabel!
    @IBOutlet weak var descriptionTextLabel: UILabel!
    // Search text fields
    @IBOutlet weak var characterSearchTextField: UITextField!
    @IBOutlet weak var serverSearchTextField: UITextField!
    @IBOutlet weak var regionSearchTextField: UITextField!
    @IBOutlet weak var zoneSearchTextField: UITextField!
    // Magnifying glass image
    @IBOutlet weak var searchIconImageView: UIImageView!
    // Search button
    @IBOutlet weak var searchButton: UIButton!
    
    //  MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupPickerViews()
        /// Tap gesture to dismiss keyboard
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        clearTextFields()
    }
    
    //  MARK: - Actions
    @IBAction func searchButtonTapped(_ sender: Any) {
        // Present alert controller if fields are empty
        if characterSearchTextField.text == "" {
            presentNoEntryAlert()
        } else if serverSearchTextField.text == "" {
            presentNoEntryAlert()
        } else if regionSearchTextField.text == "" {
            presentNoEntryAlert()
        } else if zoneSearchTextField.text == "" {
            presentNoEntryAlert()
        }
        // Fetch encounters from api
        fetchEncounters()
    }
    
    //  MARK: - Methods
    func setupUI() {
        // Adds bottom line to textfields
        characterSearchTextField.setPadding()
        characterSearchTextField.setBottomBorderThick()
        serverSearchTextField.setPadding()
        serverSearchTextField.setBottomBorderThick()
        regionSearchTextField.setPadding()
        regionSearchTextField.setBottomBorderThick()
        zoneSearchTextField.setPadding()
        zoneSearchTextField.setBottomBorderThick()
        // See-thru navbar
        setupNavBar()
        // Character search toolbar
        setupPlayerNameToolbar()
        // Search button
        searchButton.layer.cornerRadius = searchButton.bounds.height / 2
        searchButton.layer.backgroundColor = UIColor.XIVLogsAetheryteDarkBlue.cgColor
        searchButton.clipsToBounds = true
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    /// Presents alert controller if search fields are empty
    func presentNoEntryAlert() {
        let alert = UIAlertController(title: "Please fill in all search fields", message: "Player name, server, region, and zone", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    /// Presents alert controller if no player is found with player name
    func presentNoPlayerAlert() {
        let alert = UIAlertController(title: "Player not found!", message: "verify search criteria", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    /// Presents alert controller if player exists but no records come back from server
    func presentNoRecordsAlert() {
        let alert = UIAlertController(title: "No logs returned!", message: "User may have logs set to private, or data is unable to be retrieved from the server at this time", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    func setupPickerViews() {
        // Server PickerView
        serverPicker = serverPickerView()
        serverPicker?.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        serverPicker?.backgroundColor = UIColor.XIVLogsAetheryteDarkBlue
        serverPicker?.data = FFLogsController.shared.servers
        serverSearchTextField.inputView = serverPicker
        // Region PickerView
        regionPicker = regionPickerView()
        regionPicker?.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        regionPicker?.backgroundColor = UIColor.XIVLogsAetheryteDarkBlue
        regionPicker?.data = FFLogsController.shared.regions
        regionSearchTextField.inputView = regionPicker
        // Zone PickerView
        zonePicker = zonePickerView()
        zonePicker?.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        zonePicker?.backgroundColor = UIColor.XIVLogsAetheryteDarkBlue
        zonePicker?.data = FFLogsController.shared.zoneStrings
        zoneSearchTextField.inputView = zonePicker
        // PickerView Toolbars
        setupServerPickerToolbar()
        setupRegionPickerToolbar()
        setupZonePickerToolbar()
    }
    
    func setupPlayerNameToolbar() {
        let bar = UIToolbar()
        bar.autoresizingMask = .flexibleHeight
        bar.barStyle = .default
        bar.barTintColor = UIColor.XIVLogsAetheryteDarkBlue
        bar.backgroundColor = UIColor.XIVLogsAetheryteDarkBlue
        bar.isTranslucent = false
        var frame = bar.frame
        frame.size.height = 44.0
        bar.frame = frame
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(playerCancelButtonTapped(_:)))
        cancelButton.tintColor = UIColor.white
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(playerDoneButtonTapped(_:)))
        doneButton.tintColor = UIColor.white
        bar.items = [cancelButton, flexSpace, doneButton]
        characterSearchTextField.inputAccessoryView = bar
    }
    
    /// Setup of the uiPicker toolbar, including a done and cancel button
    func setupServerPickerToolbar() {
        // Toolbar customization
        serverPickerAccessory = UIToolbar()
        serverPickerAccessory?.autoresizingMask = .flexibleHeight
        serverPickerAccessory?.barStyle = .default
        serverPickerAccessory?.barTintColor = UIColor.XIVLogsAetheryteDarkBlue
        serverPickerAccessory?.backgroundColor = UIColor.XIVLogsAetheryteDarkBlue
        serverPickerAccessory?.isTranslucent = false
        var frame = serverPickerAccessory?.frame
        frame?.size.height = 44.0
        serverPickerAccessory?.frame = frame!
        // Done and cancel buttons
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(serverCancelButtonTapped(_:)))
        cancelButton.tintColor = UIColor.white
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(serverDoneButtonTapped(_:)))
        doneButton.tintColor = UIColor.white
        // Add items to toolbar
        serverPickerAccessory?.items = [cancelButton, flexSpace, doneButton]
        // Adding toolbar to textField
        serverSearchTextField.inputAccessoryView = serverPickerAccessory
    }
    
    /// Setup of the uiPicker toolbar, including a done and cancel button
    func setupRegionPickerToolbar() {
        // Toolbar customization
        regionPickerAccessory = UIToolbar()
        regionPickerAccessory?.autoresizingMask = .flexibleHeight
        regionPickerAccessory?.barStyle = .default
        regionPickerAccessory?.barTintColor = UIColor.XIVLogsAetheryteDarkBlue
        regionPickerAccessory?.backgroundColor = UIColor.XIVLogsAetheryteDarkBlue
        regionPickerAccessory?.isTranslucent = false
        var frame = regionPickerAccessory?.frame
        frame?.size.height = 44.0
        regionPickerAccessory?.frame = frame!
        // Done and cancel buttons
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(regionCancelButtonTapped(_:)))
        cancelButton.tintColor = UIColor.white
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(regionDoneButtonTapped(_:)))
        doneButton.tintColor = UIColor.white
        // Add items to toolbar
        regionPickerAccessory?.items = [cancelButton, flexSpace, doneButton]
        // Adding toolbar to textField
        regionSearchTextField.inputAccessoryView = regionPickerAccessory
    }
    
    /// Setup of the uiPicker toolbar, including a done and cancel button
    func setupZonePickerToolbar() {
        // Toolbar customization
        zonePickerAccessory = UIToolbar()
        zonePickerAccessory?.autoresizingMask = .flexibleHeight
        zonePickerAccessory?.barStyle = .default
        zonePickerAccessory?.barTintColor = UIColor.XIVLogsAetheryteDarkBlue
        zonePickerAccessory?.backgroundColor = UIColor.XIVLogsAetheryteDarkBlue
        zonePickerAccessory?.isTranslucent = false
        var frame = zonePickerAccessory?.frame
        frame?.size.height = 44.0
        zonePickerAccessory?.frame = frame!
        // Done and cancel buttons
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(zoneCancelButtonTapped(_:)))
        cancelButton.tintColor = UIColor.white
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(zoneDoneButtonTapped(_:)))
        doneButton.tintColor = UIColor.white
        // Add items to toolbar
        zonePickerAccessory?.items = [cancelButton, flexSpace, doneButton]
        // Adding toolbar to textField
        zoneSearchTextField.inputAccessoryView = zonePickerAccessory
    }
    
    @objc func playerCancelButtonTapped(_ button: UIBarButtonItem?) {
        characterSearchTextField.resignFirstResponder()
    }
    
    @objc func playerDoneButtonTapped(_ button: UIBarButtonItem?) {
        characterSearchTextField.resignFirstResponder()
    }
    
    /// Called when the cancel button of the `pickerAccessory` was clicked. Dismisses the picker
    @objc func serverCancelButtonTapped(_ button: UIBarButtonItem?) {
        serverSearchTextField.resignFirstResponder()
    }
    
    /// Called when the done button of the `pickerAccessory` was clicked. Dismisses the picker and puts the selected value into the textField
    @objc func serverDoneButtonTapped(_ button: UIBarButtonItem?) {
        serverSearchTextField.resignFirstResponder()
        serverSearchTextField.text = serverPicker?.selectedValue
        
    }
    
    /// Called when the cancel button of the `pickerAccessory` was clicked. Dismisses the picker
    @objc func regionCancelButtonTapped(_ button: UIBarButtonItem?) {
        regionSearchTextField.resignFirstResponder()
    }
    
    /// Called when the done button of the `pickerAccessory` was clicked. Dismisses the picker and puts the selected value into the textField
    @objc func regionDoneButtonTapped(_ button: UIBarButtonItem?) {
        regionSearchTextField.resignFirstResponder()
        regionSearchTextField.text = regionPicker?.selectedValue
        
    }
    
    /// Called when the cancel button of the `pickerAccessory` was clicked. Dismisses the picker
    @objc func zoneCancelButtonTapped(_ button: UIBarButtonItem?) {
        zoneSearchTextField.resignFirstResponder()
    }
    
    /// Called when the done button of the `pickerAccessory` was clicked. Dismisses the picker and puts the selected value into the textField
    @objc func zoneDoneButtonTapped(_ button: UIBarButtonItem?) {
        zoneSearchTextField.resignFirstResponder()
        zoneSearchTextField.text = zonePicker?.selectedValue
        
    }
    
    func clearTextFields() {
        zoneSearchTextField.text = ""
    }
    
    func setupNavBar() {
        /// Transparent NavBar
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.barStyle = .black
        /// Changes NavBar tint
        self.navigationController?.navigationBar.tintColor = UIColor.XIVLogsAetheryteDarkBlue
    }
    
    /// Fetch encounters with text field data
    func fetchEncounters() {
        // Make sure text fields have values
        guard let name = characterSearchTextField.text, !name.isEmpty,
              let server = serverSearchTextField.text, !server.isEmpty,
              let region = regionSearchTextField.text, !region.isEmpty,
              let zone = zoneSearchTextField.text, !zone.isEmpty else { return }
        
        // Associate zone string with corresponding int
        var zoneIDString: String = "38"
        if zone == "Eden's Promise (Savage)" {
            zoneIDString = FFLogsStrings.zoneEdensPromiseQueryValue
        } else if zone == "Eden's Verse (Savage)" {
            zoneIDString = FFLogsStrings.zoneEdensVerseQueryValue
        } else if zone == "Trials III" {
            zoneIDString = FFLogsStrings.zoneTrialsIIIQueryValue
        } else if zone == "Trials II" {
            zoneIDString = FFLogsStrings.zoneTrialsIIQueryValue
        } else if zone == "Puppet's Bunker" {
            zoneIDString = FFLogsStrings.zonePuppetsBunkerQueryValue
        } else if zone == "Copied Factory" {
            zoneIDString = FFLogsStrings.zoneCopiedFactoryQueryValue
        }
        
        // Clear encounter array
        FFLogsController.shared.encounters = []
        // Network call to get zone encounters
        FFLogsController.fetchZoneEncounters(name: name, server: server, region: region, zone: zoneIDString) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let encounters):
                    
                    // Add encounters to singleton array
                    FFLogsController.shared.encounters = encounters
                    
                    // If zone is eden's promise, makes sure individual encounter arrays have data
                    // then append first in array to topparsesofencounters array
                    if self.zoneSearchTextField.text == "Eden's Promise (Savage)" {
                        if FFLogsController.shared.cloudOfDarknessEncounters != [] {
                            FFLogsController.shared.topParsesOfEncounters.append(FFLogsController.shared.cloudOfDarknessEncounters[0])
                        }
                        
                        if FFLogsController.shared.shadowKeeperEncounters != [] {
                            FFLogsController.shared.topParsesOfEncounters.append(FFLogsController.shared.shadowKeeperEncounters[0])
                        }
                        
                        if FFLogsController.shared.fateBreakerEncounters != [] {
                            FFLogsController.shared.topParsesOfEncounters.append(FFLogsController.shared.fateBreakerEncounters[0])
                        }
                        
                        if FFLogsController.shared.EdensPromiseEncounters != [] {
                            FFLogsController.shared.topParsesOfEncounters.append(FFLogsController.shared.EdensPromiseEncounters[0])
                        }
                        
                        if FFLogsController.shared.OracleOfDarknessEncounters != [] {
                            FFLogsController.shared.topParsesOfEncounters.append(FFLogsController.shared.OracleOfDarknessEncounters[0])
                        }
                    }
                    
                    print(FFLogsController.shared.topParsesOfEncounters)
                    // Perform segue
                    if FFLogsController.shared.encounters != [] {
                        self.performSegue(withIdentifier: "toPlayerDetail", sender: self)
                    } else {
                        self.presentNoRecordsAlert()
                    }
                case .failure(let error):
                    print(error, error.localizedDescription)
                    // Present action sheet
                    self.presentNoPlayerAlert()
                }
            }
        }
    }
    
    //  MARK: - Prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is PlayerDetailViewController {
            guard let zone = zoneSearchTextField.text, !zone.isEmpty,
                  let region = regionSearchTextField.text, !region.isEmpty,
                  let server = serverSearchTextField.text, !server.isEmpty else { return }
            let vc = segue.destination as? PlayerDetailViewController
            // this is where you send data, 'destinationvc.entrylanding = entry'
            //vc.property = value
            vc?.encounterTier = zone
            vc?.region = region
        }
    }
}
