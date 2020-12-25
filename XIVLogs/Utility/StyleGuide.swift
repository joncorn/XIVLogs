//
//  StyleGuide.swift
//  XIVLogs
//
//  Created by Jon Corn on 12/24/20.
//

import Foundation
import UIKit

struct StyleGuide {
    
    // Parse Colors
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
    
    // Rounded corners
    static func roundCorners(_ view: UIView) {
        view.layer.cornerRadius = 5
    }
}
