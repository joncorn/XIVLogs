//
//  EncounterTableViewCell.swift
//  XIVLogs
//
//  Created by Jon Corn on 1/1/21.
//

import UIKit

class EncounterTableViewCell: UITableViewCell {
    
    //  MARK: - Properties
    // images.sorted(by: { $0.fileID > $1.fileID })
    
    var encounters: Encounter? {
        didSet {
            updateViews()
        }
    }
    
    //  MARK: - Outlets
    @IBOutlet weak var parseNumberLabel: UILabel!
    @IBOutlet weak var parseSpecLabel: UIImageView!
    @IBOutlet weak var rDPSLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //  MARK: - Methods
    func updateViews() {
        guard let encounters = encounters else { return }
        let logDate = Date(timeIntervalSince1970: (encounters.startTime / 1000.0))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy"
        
        let parseInt = Int(encounters.percentile)
        colorParse(parse: parseInt, parseLabel: parseNumberLabel)
        parseSpecLabel.image = UIImage(named: encounters.spec)
        rDPSLabel.text = rDPSFormatter(encounters.total)
        rDPSLabel.textColor = .XIVLogsrDPSPurple
        rankLabel.text = "\(encounters.outOf)"
        dateLabel.text = dateFormatter.string(from: logDate)
    }
    
    /// rDPS to correct format
    func rDPSFormatter(_ total: Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        guard let rDPS = numberFormatter.string(from: NSNumber(value: Double(round(10*total)/10))) else { return "" }
        return rDPS
    }
    
    /// Color parseLabel depending on number
    func colorParse(parse: Int, parseLabel: UILabel) {
        if parse <= 24 {
            parseLabel.text = String(parse)
            StyleGuide.grayParse(parseLabel)
        } else if parse <= 49 {
            parseLabel.text = String(parse)
            StyleGuide.greenParse(parseLabel)
        } else if parse <= 74 {
            parseLabel.text = String(parse)
            StyleGuide.blueParse(parseLabel)
        } else if parse <= 94 {
            parseLabel.text = String(parse)
            StyleGuide.purpleParse(parseLabel)
        } else if parse <= 98 {
            parseLabel.text = String(parse)
            StyleGuide.orangeParse(parseLabel)
        } else if parse <= 99 {
            parseLabel.text = String(parse)
            StyleGuide.pinkParse(parseLabel)
        } else if parse <= 100 {
            parseLabel.text = String(parse)
            StyleGuide.goldParse(parseLabel)
        }
    }
    
}
