//
//  UITextFieldExtension.swift
//  XIVLogs
//
//  Created by Jon Corn on 12/26/20.
//

import UIKit

extension UITextField {
    
    func setPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func setBottomBorderThick() {
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0
    }
    
    func setBottomBorderThin() {
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0
    }
}
