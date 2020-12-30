//
//  StyleGuide.swift
//  XIVLogs
//
//  Created by Jon Corn on 12/24/20.
//

import Foundation
import UIKit

struct StyleGuide {
    
    //  MARK: - Encounter Color
    static func encounterColor(_ label: UILabel) {
        label.textColor = UIColor(red:0.71, green:0.74, blue:1.00, alpha:1.0)
    }
    
    //  MARK: - rDPS Color
    static func rDPSColor(_ label: UILabel) {
        label.textColor = UIColor(red:0.82, green:0.60, blue:0.98, alpha:1.0)
    }
    
    //  MARK: - Parse Colors
    static func goldParse(_ label: UILabel) {
        label.textColor = UIColor(red:0.90, green:0.80, blue:0.50, alpha:1.0)
    }
    
    static func pinkParse(_ label: UILabel) {
        label.textColor = UIColor(red:0.89, green:0.41, blue:0.66, alpha:1.0)
    }
    
    static func orangeParse(_ label: UILabel) {
        label.textColor = UIColor(red:1.00, green:0.50, blue:0.00, alpha:1.0)
    }
    
    static func purpleParse(_ label: UILabel) {
        label.textColor = UIColor(red:0.64, green:0.21, blue:0.93, alpha:1.0)
    }
    
    static func blueParse(_ label: UILabel) {
        label.textColor = UIColor(red:0.00, green:0.44, blue:1.00, alpha:1.0)
    }
    
    static func greenParse(_ label: UILabel) {
        label.textColor = UIColor(red:0.12, green:1.00, blue:0.00, alpha:1.0)
    }
    
    static func grayParse(_ label: UILabel) {
        label.textColor = UIColor(red:0.40, green:0.40, blue:0.40, alpha:1.0)
    }
    
    //  MARK: - Rounded Corners
    static func roundCorners(_ view: UIView) {
        view.layer.cornerRadius = 3
    }
    
    //  MARK: - Drop Shadow
    static func addDropShadowToView(_ view: UIView) {
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 2
        view.layer.shadowPath = UIBezierPath(rect: view.bounds).cgPath
        view.layer.shouldRasterize = true
    }
}
