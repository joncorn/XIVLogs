//
//  PlayerDetailViewController.swift
//  XIVLogs
//
//  Created by Jon Corn on 12/26/20.
//

import UIKit

class PlayerDetailViewController: UIViewController {
    
    //  MARK: - Properties
    var encounterTier: String?
    var region: String = "Hydaelyn"
//    var playerResults = [PlayerResult]() {
//        didSet {
//            if self.playerResults != [] {
//                XivApiController.fetchAvatar(for: playerResults[0]) { (result) in
//                    DispatchQueue.main.async {
//                        switch result {
//                        case .success(let image):
//                            self.playerAvatarImageView.image = image
//                            print("got image")
//                        case .failure(let error):
//                            print(error, error.localizedDescription)
//                            print("no image")
//                        }
//                    }
//                }
//            }
//        }
//    }
    
    
    //  MARK: - Outlets
    // Avatar
    @IBOutlet weak var playerAvatarImageView: UIImageView!
    // Labels
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var playerServerLabel: UILabel!
    @IBOutlet weak var zoneNameLabel: UILabel!
    // Encounter/Parse Views
    // First
    @IBOutlet weak var firstEncounterView: UIView!
    @IBOutlet weak var firstEncounterImageView: UIImageView!
    @IBOutlet weak var firstEncounterNameLabel: UILabel!
    @IBOutlet weak var firstEncounterDPSLabel: UILabel!
    @IBOutlet weak var firstEncounterArrowImageView: UIImageView!
    @IBOutlet weak var firstParseView: UIView!
    @IBOutlet weak var firstParseLabel: UILabel!
    @IBOutlet weak var firstParseSpecImageView: UIImageView!
    @IBOutlet weak var firstParseRankLabel: UILabel!
    // Second
    @IBOutlet weak var secondEncounterView: UIView!
    @IBOutlet weak var secondEncounterImageView: UIImageView!
    @IBOutlet weak var secondEncounterNameLabel: UILabel!
    @IBOutlet weak var secondEncounterDPSLabel: UILabel!
    @IBOutlet weak var secondEncounterArrowImageView: UIImageView!
    @IBOutlet weak var secondParseView: UIView!
    @IBOutlet weak var secondParseLabel: UILabel!
    @IBOutlet weak var secondParseSpecImageView: UIImageView!
    @IBOutlet weak var secondParseRankLabel: UILabel!
    // Third
    @IBOutlet weak var thirdEncounterView: UIView!
    @IBOutlet weak var thirdEncounterImageView: UIImageView!
    @IBOutlet weak var thirdEncounterNameLabel: UILabel!
    @IBOutlet weak var thirdEncounterDPSLabel: UILabel!
    @IBOutlet weak var thirdEncounterArrowImageView: UIImageView!
    @IBOutlet weak var thirdParseView: UIView!
    @IBOutlet weak var thirdParseLabel: UILabel!
    @IBOutlet weak var thirdParseSpecImageView: UIImageView!
    @IBOutlet weak var thirdParseRankLabel: UILabel!
    // Fourth
    @IBOutlet weak var fourthEncounterView: UIView!
    @IBOutlet weak var fourthEncounterImageView: UIImageView!
    @IBOutlet weak var fourthEncounterNameLabel: UILabel!
    @IBOutlet weak var fourthEncounterDPSLabel: UILabel!
    @IBOutlet weak var fourthEncounterArrowImageView: UIImageView!
    @IBOutlet weak var fourthParseView: UIView!
    @IBOutlet weak var fourthParseLabel: UILabel!
    @IBOutlet weak var fourthParseSpecImageView: UIImageView!
    @IBOutlet weak var fourthParseRankLabel: UILabel!
    // Fifth
    @IBOutlet weak var fifthEncounterView: UIView!
    @IBOutlet weak var fifthEncounterImageView: UIImageView!
    @IBOutlet weak var fifthEncounterNameLabel: UILabel!
    @IBOutlet weak var fifthEncounterDPSLabel: UILabel!
    @IBOutlet weak var fifthEncounterArrowImageView: UIImageView!
    @IBOutlet weak var fifthParseView: UIView!
    @IBOutlet weak var fifthParseLabel: UILabel!
    @IBOutlet weak var fifthParseSpecImageView: UIImageView!
    @IBOutlet weak var fifthParseRankLabel: UILabel!
    
    //  MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setDefaultAvatar()
        self.playerNameLabel.text = FFLogsController.shared.encounters[0].characterName
        self.playerServerLabel.text = "\(FFLogsController.shared.encounters[0].server) (\(region))"
        self.zoneNameLabel.text = encounterTier
        
        XivApiController.shared.delegate = self
        
        setupUI()
        revealSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
//        fetchPlayerResults()
        FFLogsController.shared.cloudTapped = false
        FFLogsController.shared.shadowTapped = false
        FFLogsController.shared.fateTapped = false
        FFLogsController.shared.edenTapped = false
        FFLogsController.shared.oracleTapped = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        print(FFLogsController.shared.cloudOfDarknessEncounters)
    }
    
    //  MARK: - Actions
    @IBAction func firstEncounterTapped(_ sender: Any) {
        
        FFLogsController.shared.cloudTapped = true
        if self.firstEncounterArrowImageView.alpha == 1 {
            performSegue(withIdentifier: "toEncounterDetail", sender: self)
        }
    }
    
    @IBAction func secondEncounterTapped(_ sender: Any) {
        FFLogsController.shared.shadowTapped = true
        if self.secondEncounterArrowImageView.alpha == 1 {
            performSegue(withIdentifier: "toEncounterDetail", sender: self)
        }
    }
    
    @IBAction func thirdEncounterTapped(_ sender: Any) {
        FFLogsController.shared.fateTapped = true
        if self.thirdEncounterArrowImageView.alpha == 1 {
            performSegue(withIdentifier: "toEncounterDetail", sender: self)
        }
    }
    
    @IBAction func fourthEncounterTapped(_ sender: Any) {
        FFLogsController.shared.edenTapped = true
        if self.fourthEncounterArrowImageView.alpha == 1 {
            performSegue(withIdentifier: "toEncounterDetail", sender: self)
        }
    }
    
    @IBAction func fifthEncounterTapped(_ sender: Any) {
        FFLogsController.shared.oracleTapped = true
        if self.fifthEncounterArrowImageView.alpha == 1 {
            performSegue(withIdentifier: "toEncounterDetail", sender: self)
        }
    }
    
    //  MARK: - Methods
    func setupUI() {
        setupNavBar()
        setupViews()
    }
    
    func setupViews() {
        StyleGuide.roundCorners(playerAvatarImageView)
        // Set all five subviews alpha to 0
        setFiveSubviewsAlphaTo(0.0)
        // First
        StyleGuide.roundCorners(firstEncounterView)
        StyleGuide.roundCorners(firstEncounterImageView)
        StyleGuide.roundCorners(firstParseView)
        // Second
        StyleGuide.roundCorners(secondEncounterView)
        StyleGuide.roundCorners(secondEncounterImageView)
        StyleGuide.roundCorners(secondParseView)
        // Third
        StyleGuide.roundCorners(thirdEncounterView)
        StyleGuide.roundCorners(thirdEncounterImageView)
        StyleGuide.roundCorners(thirdParseView)
        // Fourth
        StyleGuide.roundCorners(fourthEncounterView)
        StyleGuide.roundCorners(fourthEncounterImageView)
        StyleGuide.roundCorners(fourthParseView)
        // Fifth
        StyleGuide.roundCorners(fifthEncounterView)
        StyleGuide.roundCorners(fifthEncounterImageView)
        StyleGuide.roundCorners(fifthParseView)
        
    }
    
    func setDefaultAvatar() {

        let spec = FFLogsController.shared.topParsesOfEncounters[0].spec

        if spec == "Bard" {
            self.playerAvatarImageView.image = UIImage(named: "BRD")
        } else if spec == "Dragoon" {
            self.playerAvatarImageView.image = UIImage(named: "DRG")
        } else if spec == "Monk" {
            self.playerAvatarImageView.image = UIImage(named: "MNK")
        } else if spec == "Paladin" {
            self.playerAvatarImageView.image = UIImage(named: "PLD")
        } else if spec == "Warrior" {
            self.playerAvatarImageView.image = UIImage(named: "WAR")
        } else if spec == "Black Mage" {
            self.playerAvatarImageView.image = UIImage(named: "BLM")
        } else if spec == "White Mage" {
            self.playerAvatarImageView.image = UIImage(named: "WHM")
        } else if spec == "Scholar" {
            self.playerAvatarImageView.image = UIImage(named: "SCH")
        } else if spec == "Summoner" {
            self.playerAvatarImageView.image = UIImage(named: "SMN")
        } else if spec == "Ninja" {
            self.playerAvatarImageView.image = UIImage(named: "NIN")
        } else if spec == "Astrologian" {
            self.playerAvatarImageView.image = UIImage(named: "AST")
        } else if spec == "Dark Knight" {
            self.playerAvatarImageView.image = UIImage(named: "DRK")
        } else if spec == "Machinist" {
            self.playerAvatarImageView.image = UIImage(named: "MCH")
        } else if spec == "Red Mage" {
            self.playerAvatarImageView.image = UIImage(named: "RDM")
        } else if spec == "Samurai" {
            self.playerAvatarImageView.image = UIImage(named: "SAM")
        } else if spec == "Blue Mage" {
            self.playerAvatarImageView.image = UIImage(named: "BLU")
        } else if spec == "Gunbreaker" {
            self.playerAvatarImageView.image = UIImage(named: "GNB")
        } else if spec == "Dancer" {
            self.playerAvatarImageView.image = UIImage(named: "DNC")
        }
    }
    
//    func fetchPlayerResults() {
//        let name = FFLogsController.shared.encounters[0].characterName
//        let server = FFLogsController.shared.encounters[0].server
//        XivApiController.searchCharacter(withName: name, withServer: server) { (result) in
//            DispatchQueue.main.async {
//                switch result {
//                case .success(let results):
//                    self.playerResults = results
//                    print("got player info")
//                case .failure(let error):
//                    print(error, error.localizedDescription)
//                    print("didn't get player info")
//                }
//            }
//        }
//    }
    
    //    func fetchAvatar() {
    //        guard let character = self.character else { return }
    //        XivApiController.fetchAvatar(for: character) { (result) in
    //            DispatchQueue.main.async {
    //                switch result {
    //                case .success(let image):
    //                    self.playerAvatarImageView.image = image
    //                    print("image fetched")
    //                case .failure(let error):
    //                    print(error, error.localizedDescription)
    //                    print("image not fetched")
    //                }
    //            }
    //        }
    //    }
    
    //    func fetchCharacter() {
    //        let id = 2493998
    //        XivApiController.fetchCharacter(with: id) { (result) in
    //            DispatchQueue.main.async {
    //                switch result {
    //                case .success(let character):
    //                    self.character = character
    //                    print("character fetched")
    //                case .failure(let error):
    //                    print(error, error.localizedDescription)
    //                    print("Character not fetched")
    //                }
    //            }
    //        }
    //    }
    
    //    func updateAvatar() {
    //        XivApiController.fetchAvatar(for: XivApiController.shared.playerResults[0]) { (result) in
    //            DispatchQueue.main.async {
    //                switch result {
    //                case .success(let image):
    //                    self.playerAvatarImageView.image = image
    //                    print("got image")
    //                case .failure(let error):
    //                    print(error, error.localizedDescription)
    //                    print("no image")
    //                }
    //            }
    //        }
    //    }
    
    func parse(_ parse: [Encounter], index: Int) -> Int {
        return Int(parse[index].percentile)
    }
    
    /// Reveal subviews based on zone selection, and populates views with data from api
    func revealSubviews() {
        let parses = FFLogsController.shared.topParsesOfEncounters
        // Checks which zone we're in
        if encounterTier == "Eden's Promise (Savage)" {
            // Reveals # of view corresponding to zone encounter count
            setFiveSubviewsAlphaTo(1)
            
            // If topParse array contains something, set parse label - else hide arrow
            if parses.indices.contains(0) {
                // Populate first row
                firstEncounterImageView.image = UIImage(named: parses[0].encounterName)
                firstEncounterNameLabel.text = parses[0].encounterName
                firstEncounterNameLabel.textColor = .XIVLogsEncounterNameBlue
                firstEncounterDPSLabel.text = rDPSFormatter(parses[0].total)
                firstEncounterDPSLabel.textColor = .XIVLogsrDPSPurple
                colorParse(parse: parse(parses, index: 0), parseLabel: firstParseLabel)
                firstParseSpecImageView.image = UIImage(named: parses[0].spec)
                
            } else {
                firstEncounterArrowImageView.alpha = 0
            }
            
            if parses.indices.contains(1) {
                // Populated second row
                secondEncounterImageView.image = UIImage(named: parses[1].encounterName)
                secondEncounterNameLabel.text = parses[1].encounterName
                secondEncounterNameLabel.textColor = .XIVLogsEncounterNameBlue
                secondEncounterDPSLabel.text = rDPSFormatter(parses[1].total)
                secondEncounterDPSLabel.textColor = .XIVLogsrDPSPurple
                secondParseSpecImageView.image = UIImage(named: parses[1].spec)
                colorParse(parse: parse(parses, index: 1), parseLabel: secondParseLabel)
            } else {
                secondEncounterArrowImageView.alpha = 0
            }
            
            if parses.indices.contains(2) {
                // Populated third row
                thirdEncounterImageView.image = UIImage(named: parses[2].encounterName)
                thirdEncounterNameLabel.text = parses[2].encounterName
                thirdEncounterNameLabel.textColor = .XIVLogsEncounterNameBlue
                thirdEncounterDPSLabel.text = rDPSFormatter(parses[2].total)
                thirdEncounterDPSLabel.textColor = .XIVLogsrDPSPurple
                thirdParseSpecImageView.image = UIImage(named: parses[2].spec)
                colorParse(parse: parse(parses, index: 2), parseLabel: thirdParseLabel)
            } else {
                thirdEncounterArrowImageView.alpha = 0
            }
            
            if parses.indices.contains(3) {
                // Populate 4th row
                fourthEncounterImageView.image = UIImage(named: parses[3].encounterName)
                fourthEncounterNameLabel.text = parses[3].encounterName
                fourthEncounterNameLabel.textColor = .XIVLogsEncounterNameBlue
                fourthEncounterDPSLabel.text = rDPSFormatter(parses[3].total)
                fourthEncounterDPSLabel.textColor = .XIVLogsrDPSPurple
                fourthParseSpecImageView.image = UIImage(named: parses[3].spec)
                colorParse(parse: parse(parses, index: 3), parseLabel: fourthParseLabel)
            } else {
                fourthEncounterArrowImageView.alpha = 0
            }
            
            if parses.indices.contains(4) {
                // Populate 5th row
                fifthEncounterImageView.image = UIImage(named: parses[4].encounterName)
                fifthEncounterNameLabel.text = parses[4].encounterName
                fifthEncounterNameLabel.textColor = .XIVLogsEncounterNameBlue
                fifthEncounterDPSLabel.text = rDPSFormatter(parses[4].total)
                fifthEncounterDPSLabel.textColor = .XIVLogsrDPSPurple
                fifthParseSpecImageView.image = UIImage(named: parses[4].spec)
                colorParse(parse: parse(parses, index: 4), parseLabel: fifthParseLabel)
            } else {
                fifthEncounterArrowImageView.alpha = 0
            }
            
        } else if encounterTier == "Eden's Verse (Savage)" {
            setFourSubviewsAlphaTo(1)
//            if parses.indices.contains(0) {
//                // Populate first row
//                firstEncounterImageView.image = UIImage(named: parses[0].encounterName)
//                firstEncounterNameLabel.text = parses[0].encounterName
//                firstEncounterNameLabel.textColor = .XIVLogsEncounterNameBlue
//                firstEncounterDPSLabel.text = rDPSFormatter(parses[0].total)
//                firstEncounterDPSLabel.textColor = .XIVLogsrDPSPurple
//                colorParse(parse: parse(parses, index: 0), parseLabel: firstParseLabel)
//                firstParseSpecImageView.image = UIImage(named: parses[0].spec)
//                firstParseRankLabel.text = "\(parses[0].rank) / \(parses[0].outOf)"
//                
//            } else {
//                firstEncounterArrowImageView.alpha = 0
//            }
//            
//            if parses.indices.contains(1) {
//                // Populated second row
//                secondEncounterImageView.image = UIImage(named: parses[1].encounterName)
//                secondEncounterNameLabel.text = parses[1].encounterName
//                secondEncounterNameLabel.textColor = .XIVLogsEncounterNameBlue
//                secondEncounterDPSLabel.text = rDPSFormatter(parses[1].total)
//                secondEncounterDPSLabel.textColor = .XIVLogsrDPSPurple
//                secondParseSpecImageView.image = UIImage(named: parses[1].spec)
//                secondParseRankLabel.text = "\(parses[1].rank) / \(parses[1].outOf)"
//                colorParse(parse: parse(parses, index: 1), parseLabel: secondParseLabel)
//            } else {
//                secondEncounterArrowImageView.alpha = 0
//            }
//            
//            if parses.indices.contains(2) {
//                // Populated third row
//                thirdEncounterImageView.image = UIImage(named: parses[2].encounterName)
//                thirdEncounterNameLabel.text = parses[2].encounterName
//                thirdEncounterNameLabel.textColor = .XIVLogsEncounterNameBlue
//                thirdEncounterDPSLabel.text = rDPSFormatter(parses[2].total)
//                thirdEncounterDPSLabel.textColor = .XIVLogsrDPSPurple
//                thirdParseSpecImageView.image = UIImage(named: parses[2].spec)
//                thirdParseRankLabel.text = "\(parses[2].rank) / \(parses[2].outOf)"
//                colorParse(parse: parse(parses, index: 2), parseLabel: thirdParseLabel)
//            } else {
//                thirdEncounterArrowImageView.alpha = 0
//            }
//            
//            if parses.indices.contains(3) {
//                // Populate 4th row
//                fourthEncounterImageView.image = UIImage(named: parses[3].encounterName)
//                fourthEncounterNameLabel.text = parses[3].encounterName
//                fourthEncounterNameLabel.textColor = .XIVLogsEncounterNameBlue
//                fourthEncounterDPSLabel.text = rDPSFormatter(parses[3].total)
//                fourthEncounterDPSLabel.textColor = .XIVLogsrDPSPurple
//                fourthParseSpecImageView.image = UIImage(named: parses[3].spec)
//                fourthParseRankLabel.text = "\(parses[3].rank) / \(parses[3].outOf)"
//                colorParse(parse: parse(parses, index: 3), parseLabel: fourthParseLabel)
//            } else {
//                fourthEncounterArrowImageView.alpha = 0
//            }
//            
//            if parses.indices.contains(4) {
//                // Populate 5th row
//                fifthEncounterImageView.image = UIImage(named: parses[4].encounterName)
//                fifthEncounterNameLabel.text = parses[4].encounterName
//                fifthEncounterNameLabel.textColor = .XIVLogsEncounterNameBlue
//                fifthEncounterDPSLabel.text = rDPSFormatter(parses[4].total)
//                fifthEncounterDPSLabel.textColor = .XIVLogsrDPSPurple
//                fifthParseSpecImageView.image = UIImage(named: parses[4].spec)
//                fifthParseRankLabel.text = "\(parses[4].rank) / \(parses[4].outOf)"
//                colorParse(parse: parse(parses, index: 4), parseLabel: fifthParseLabel)
//            } else {
//                fifthEncounterArrowImageView.alpha = 0
//            }
        } else if encounterTier == "Trials II" {
            setFourSubviewsAlphaTo(1)
        } else if encounterTier == "Puppet's Bunker" {
            setFourSubviewsAlphaTo(1)
        } else if encounterTier == "Copied Factory" {
            setFourSubviewsAlphaTo(1)
        } else if encounterTier == "Trials III" {
            setTwoSubviewsAlphaTo(1)
        }
        print("past alpha sets")
        // If topParse array contains something, set parse label - else hide arrow
      
    }
    
//    func addDataToSubviews() {
//        if parses.indices.contains(0) {
//            // Populate first row
//            firstEncounterImageView.image = UIImage(named: parses[0].encounterName)
//            firstEncounterNameLabel.text = parses[0].encounterName
//            firstEncounterNameLabel.textColor = .XIVLogsEncounterNameBlue
//            firstEncounterDPSLabel.text = rDPSFormatter(parses[0].total)
//            firstEncounterDPSLabel.textColor = .XIVLogsrDPSPurple
//            colorParse(parse: parse(parses, index: 0), parseLabel: firstParseLabel)
//            firstParseSpecImageView.image = UIImage(named: parses[0].spec)
//            firstParseRankLabel.text = "\(parses[0].rank) / \(parses[0].outOf)"
//
//        } else {
//            firstEncounterArrowImageView.alpha = 0
//        }
//
//        if parses.indices.contains(1) {
//            // Populated second row
//            secondEncounterImageView.image = UIImage(named: parses[1].encounterName)
//            secondEncounterNameLabel.text = parses[1].encounterName
//            secondEncounterNameLabel.textColor = .XIVLogsEncounterNameBlue
//            secondEncounterDPSLabel.text = rDPSFormatter(parses[1].total)
//            secondEncounterDPSLabel.textColor = .XIVLogsrDPSPurple
//            secondParseSpecImageView.image = UIImage(named: parses[1].spec)
//            secondParseRankLabel.text = "\(parses[1].rank) / \(parses[1].outOf)"
//            colorParse(parse: parse(parses, index: 1), parseLabel: secondParseLabel)
//        } else {
//            secondEncounterArrowImageView.alpha = 0
//        }
//
//        if parses.indices.contains(2) {
//            // Populated third row
//            thirdEncounterImageView.image = UIImage(named: parses[2].encounterName)
//            thirdEncounterNameLabel.text = parses[2].encounterName
//            thirdEncounterNameLabel.textColor = .XIVLogsEncounterNameBlue
//            thirdEncounterDPSLabel.text = rDPSFormatter(parses[2].total)
//            thirdEncounterDPSLabel.textColor = .XIVLogsrDPSPurple
//            thirdParseSpecImageView.image = UIImage(named: parses[2].spec)
//            thirdParseRankLabel.text = "\(parses[2].rank) / \(parses[2].outOf)"
//            colorParse(parse: parse(parses, index: 2), parseLabel: thirdParseLabel)
//        } else {
//            thirdEncounterArrowImageView.alpha = 0
//        }
//
//        if parses.indices.contains(3) {
//            // Populate 4th row
//            fourthEncounterImageView.image = UIImage(named: parses[3].encounterName)
//            fourthEncounterNameLabel.text = parses[3].encounterName
//            fourthEncounterNameLabel.textColor = .XIVLogsEncounterNameBlue
//            fourthEncounterDPSLabel.text = rDPSFormatter(parses[3].total)
//            fourthEncounterDPSLabel.textColor = .XIVLogsrDPSPurple
//            fourthParseSpecImageView.image = UIImage(named: parses[3].spec)
//            fourthParseRankLabel.text = "\(parses[3].rank) / \(parses[3].outOf)"
//            colorParse(parse: parse(parses, index: 3), parseLabel: fourthParseLabel)
//        } else {
//            fourthEncounterArrowImageView.alpha = 0
//        }
//
//        if parses.indices.contains(4) {
//            // Populate 5th row
//            fifthEncounterImageView.image = UIImage(named: parses[4].encounterName)
//            fifthEncounterNameLabel.text = parses[4].encounterName
//            fifthEncounterNameLabel.textColor = .XIVLogsEncounterNameBlue
//            fifthEncounterDPSLabel.text = rDPSFormatter(parses[4].total)
//            fifthEncounterDPSLabel.textColor = .XIVLogsrDPSPurple
//            fifthParseSpecImageView.image = UIImage(named: parses[4].spec)
//            fifthParseRankLabel.text = "\(parses[4].rank) / \(parses[4].outOf)"
//            colorParse(parse: parse(parses, index: 4), parseLabel: fifthParseLabel)
//        } else {
//            fifthEncounterArrowImageView.alpha = 0
//        }
//    }
    
    /// Sets 2 subviews' alpha with number
    func setTwoSubviewsAlphaTo(_ alpha: CGFloat) {
        firstEncounterView.alpha = alpha
        firstParseView.alpha = alpha
        secondEncounterView.alpha = alpha
        secondParseView.alpha = alpha
    }
    
    /// Sets 4 subviews' alpha with number
    func setFourSubviewsAlphaTo(_ alpha: CGFloat) {
        firstEncounterView.alpha = alpha
        firstParseView.alpha = alpha
        secondEncounterView.alpha = alpha
        secondParseView.alpha = alpha
        thirdEncounterView.alpha = alpha
        thirdParseView.alpha = alpha
        fourthEncounterView.alpha = alpha
        fourthParseView.alpha = alpha
    }
    
    /// Sets 5 subviews' alpha with number
    func setFiveSubviewsAlphaTo(_ alpha: CGFloat) {
        firstEncounterView.alpha = alpha
        firstParseView.alpha = alpha
        secondEncounterView.alpha = alpha
        secondParseView.alpha = alpha
        thirdEncounterView.alpha = alpha
        thirdParseView.alpha = alpha
        fourthEncounterView.alpha = alpha
        fourthParseView.alpha = alpha
        fifthEncounterView.alpha = alpha
        fifthParseView.alpha = alpha
    }
    
    /// Setup navbar back arrow
    func setupNavBar() {
        let backArrow = UIImage(named: "arrow.left")
        self.navigationController?.navigationBar.backIndicatorImage = backArrow
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backArrow
        self.navigationController?.navigationBar.backItem?.title = ""
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
    
    /// rDPS to correct format
    func rDPSFormatter(_ total: Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        guard let rDPS = numberFormatter.string(from: NSNumber(value: Double(round(10*total)/10))) else { return "" }
        return rDPS
    }
    
    //  MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEncounterDetail" {
            guard let destinationVC = segue.destination as? EncounterLogsViewController else {return}
            
            let name: String?
            
            if FFLogsController.shared.cloudTapped == true {
                name = firstEncounterNameLabel.text
                destinationVC.encounterName = name
            } else if FFLogsController.shared.shadowTapped == true {
                name = secondEncounterNameLabel.text
                destinationVC.encounterName = name
            } else if FFLogsController.shared.fateTapped == true {
                name = thirdEncounterNameLabel.text
                destinationVC.encounterName = name
            } else if FFLogsController.shared.edenTapped == true {
                name = fourthEncounterNameLabel.text
                destinationVC.encounterName = name
            } else if FFLogsController.shared.oracleTapped == true {
                name = fifthEncounterNameLabel.text
                destinationVC.encounterName = name
            }
        }
    }
    
}

//  MARK: - XiVApiControllerDelegate
extension PlayerDetailViewController: XivApiControllerDelegate {
    func setPlayerAvatar(_ sender: XivApiController) {
        self.playerAvatarImageView.image = XivApiController.shared.playerAvatar
    }
}
