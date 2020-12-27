//
//  WelcomeScreenViewController.swift
//  XIVLogs
//
//  Created by Jon Corn on 12/26/20.
//

import UIKit

class WelcomeScreenViewController: UIViewController {
    
    //  MARK: - Properties
    
    
    
    //  MARK: - Outlets
    @IBOutlet weak var characterSearchTextField: UITextField!
    @IBOutlet weak var serverSearchTextField: UITextField!
    @IBOutlet weak var zoneSearchTextField: UITextField!
    
    //  MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    //  MARK: - Methods
    func setupUI() {
        // TextFields
        characterSearchTextField.setPadding()
        characterSearchTextField.setBottomBorderThick()
        serverSearchTextField.setPadding()
        serverSearchTextField.setBottomBorderThin()
        zoneSearchTextField.setPadding()
        zoneSearchTextField.setBottomBorderThin()
        // See-thru navbar
        transparentNavBar()
    }
    
    func transparentNavBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.barStyle = .black
    }
}
