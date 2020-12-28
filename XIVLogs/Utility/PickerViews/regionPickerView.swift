//
//  regionPickerView.swift
//  XIVLogs
//
//  Created by Jon Corn on 12/26/20.
//

import UIKit

class regionPickerView: UIPickerView, UIPickerViewDataSource, UIPickerViewDelegate {
    
    //  MARK: - Properties
    /// Data for the pickerView, can only be strings
    public var data: [String]? {
        didSet {
            super.delegate = self
            super.dataSource = self
            self.reloadAllComponents()
        }
    }
    
    /// Stores the UITextField that is eing edited at the moment
    public var textFieldBeingEdited: UITextField?
    
    /// Get the selected value of the picker
    public var selectedValue: String {
        get {
            if data != nil {
                return data![selectedRow(inComponent: 0)]
            } else {
                return ""
            }
        }
    }
    
    //  MARK: - Functions
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if data != nil {
            return data!.count
        } else {
            return 0
        }
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if data != nil {
            return data![row]
        } else {
            return ""
        }
    }
    
    public func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        /// Change text color of rows in pickerView
        return NSAttributedString(string: FFLogsController.shared.regions[row], attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
}
