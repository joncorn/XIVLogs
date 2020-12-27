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
    
    //  MARK: - Methods
    func setupUI() {
        // Adds bottom line to textfields
        characterSearchTextField.setPadding()
        characterSearchTextField.setBottomBorderThin()
        serverSearchTextField.setPadding()
        serverSearchTextField.setBottomBorderThin()
        regionSearchTextField.setPadding()
        regionSearchTextField.setBottomBorderThin()
        zoneSearchTextField.setPadding()
        zoneSearchTextField.setBottomBorderThin()
        // See-thru navbar
        transparentNavBar()
        // Character search toolbar
        setupPlayerNameToolbar()
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func setupPickerViews() {
        // Server PickerView
        serverPicker = serverPickerView()
        serverPicker?.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        serverPicker?.backgroundColor = UIColor.XIVLogsAetheryteBlue
        serverPicker?.data = FFLogsController.shared.servers.sorted()
        serverSearchTextField.inputView = serverPicker
        // Region PickerView
        regionPicker = regionPickerView()
        regionPicker?.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        regionPicker?.backgroundColor = UIColor.XIVLogsAetheryteBlue
        regionPicker?.data = FFLogsController.shared.regions.sorted()
        regionSearchTextField.inputView = regionPicker
        // Zone PickerView
        zonePicker = zonePickerView()
        zonePicker?.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        zonePicker?.backgroundColor = UIColor.XIVLogsAetheryteBlue
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
        bar.barTintColor = UIColor.XIVLogsAetheryteBlue
        bar.backgroundColor = UIColor.XIVLogsAetheryteBlue
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
        serverPickerAccessory?.barTintColor = UIColor.XIVLogsAetheryteBlue
        serverPickerAccessory?.backgroundColor = UIColor.XIVLogsAetheryteBlue
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
        regionPickerAccessory?.barTintColor = UIColor.XIVLogsAetheryteBlue
        regionPickerAccessory?.backgroundColor = UIColor.XIVLogsAetheryteBlue
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
        zonePickerAccessory?.barTintColor = UIColor.XIVLogsAetheryteBlue
        zonePickerAccessory?.backgroundColor = UIColor.XIVLogsAetheryteBlue
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
        characterSearchTextField.text = ""
        serverSearchTextField.text = ""
        regionSearchTextField.text = ""
        zoneSearchTextField.text = ""
    }
    
    func transparentNavBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.barStyle = .black
    }
}
