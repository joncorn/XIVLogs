//
//  StyleGuide.swift
//  XIVLogs
//
//  Created by Jon Corn on 12/24/20.
//

import Foundation
import UIKit

struct StyleGuide {
    
    static func goldParse(_ label: UILabel) {
        
    }
    
    static func pinkParse(_ label: UILabel) {
        label.textColor = UIColor(red:0.89, green:0.41, blue:0.66, alpha:1.0)
    }
    
    static func orangeParse(_ label: UILabel) {
        label.textColor = UIColor(red:1.00, green:0.50, blue:0.00, alpha:1.0)
    }
    
    static func purpleParse(_ label: UILabel) {
        
    }
    
    static func blueParse(_ label: UILabel) {
        
    }
    
    static func greenParse(_ label: UILabel) {
        
    }
    
    static func greyParse(_ label: UILabel) {
        
    }
    
    // Rounded corners
    static func roundCorners(_ view: UIView) {
        view.layer.cornerRadius = 5
    }
    
    
}
