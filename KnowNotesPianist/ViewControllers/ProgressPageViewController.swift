//
//  ProgressPageViewController.swift
//  KnowNotesPianist
//
//  Created by Wylan L Neely on 4/3/24.
//

import UIKit

class ProgressPageViewController: UIViewController {
    
    // add instrumentType eventually
    var startDelegate: StartGameDelegate?
    var achievementsController = AchievementesController()
    var instrumentType: InstrumentType?
    
    let hapticGenerator = UINotificationFeedbackGenerator()
    
    private var isRegularUnlocked: Bool = false
    private var isPianistUnlocked: Bool = false
    private var isVirtuosoUnlocked: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setUnlockedLockedLevelDifficulties()
        setInstrumentTypeLabel()
        startDelegate?.difficultyType(type: .Novice)
        updateViewFor(gameType: .Novice)
    }
    
    //MARK: SetUp
    private func setUnlockedLockedLevelDifficulties(){
        //eventually ad a switch case for instrument type
        if achievementsController.isFreePianoRegularUnlocked() == true {
            self.isRegularUnlocked = true
        } else {
            self.isRegularUnlocked = false
        }
        
        if achievementsController.isFreePianoPianistUnlocked() == true {
            self.isPianistUnlocked = true
        } else {
            self.isPianistUnlocked = false
        }
        
        if achievementsController.isFreePianoVirtuosoUnlocked() == true {
            self.isVirtuosoUnlocked = true
        } else {
            self.isVirtuosoUnlocked = false
        }
        setButtonStates()
    }
    
    private func setButtonStates(){
        let unlockedImage = UIImage(named: "UnlockedButtonImage")
        let lockedImage = UIImage(named: "LockedButtonImage")
        
        if isRegularUnlocked {
           // regularButton.isEnabled = true
            regularButton.setImage(unlockedImage, for: .normal)
        } else {
           // regularButton.isEnabled = false
            regularButton.setImage(lockedImage, for: .disabled)
        }
        
        if isPianistUnlocked {
           // pianistButton.isEnabled = true
            pianistButton.setImage(unlockedImage, for: .normal)
        } else {
           // pianistButton.isEnabled = false
            pianistButton.setImage(lockedImage, for: .disabled)
        }
        
        if isVirtuosoUnlocked {
           // virtuosoButton.isEnabled = true
            virtuosoButton.setImage(unlockedImage, for: .normal)
        } else {
           // virtuosoButton.isEnabled = false
            virtuosoButton.setImage(lockedImage, for: .disabled)
        }
        
    }
    
   private func setInstrumentTypeLabel(){
        if let instrumentType {
            switch instrumentType {
            case .BasicPiano:
                instrumentTypeLabel.text = InstrumentTypeName.BasicPiano.rawValue
            case .GrandPiano:
                instrumentTypeLabel.text = InstrumentTypeName.GrandPiano.rawValue
            case .AcousticGuitar:
                instrumentTypeLabel.text = InstrumentTypeName.AcousticGuitar.rawValue
            case .Keyboard:
                instrumentTypeLabel.text = InstrumentTypeName.Keyboard.rawValue
            }
        }
    }
    
    //MARK: - Update
    
   private func updateViewFor(gameType: GameType){
        switch gameType {
        case .Novice:
            noviceLabel.textColor = .white
            if isRegularUnlocked {
                regularLabel.textColor = .lightGray
            } else {
                regularLabel.textColor = .black
            }
            if isPianistUnlocked {
                pianistLabel.textColor = .lightGray
            } else {
                pianistLabel.textColor = .black
            }
            if isVirtuosoUnlocked {
                virtuosoLabel.textColor = .lightGray
            } else {
                virtuosoLabel.textColor = .black
            }
        case .Regular:
            noviceLabel.textColor = .lightGray
            regularLabel.textColor = .white
            if isPianistUnlocked {
                pianistLabel.textColor = .lightGray
            } else {
                pianistLabel.textColor = .black
            }
            if isVirtuosoUnlocked {
                virtuosoLabel.textColor = .lightGray
            } else {
                virtuosoLabel.textColor = .black
            }
        case .Pianist:
            noviceLabel.textColor = .lightGray
            regularLabel.textColor = .lightGray
            pianistLabel.textColor = .white
            if isVirtuosoUnlocked {
                virtuosoLabel.textColor = .lightGray
            } else {
                virtuosoLabel.textColor = .black
            }
        case .Virtuoso:
            noviceLabel.textColor = .lightGray
            regularLabel.textColor = .lightGray
            pianistLabel.textColor = .lightGray
            virtuosoLabel.textColor = .white
        }
    }
    
    
    //MARK: - Outlets
    
    @IBOutlet weak var instrumentTypeLabel: UILabel!
    @IBOutlet weak var noviceLabel: UILabel!
    @IBOutlet weak var regularLabel: UILabel!
    @IBOutlet weak var pianistLabel: UILabel!
    @IBOutlet weak var virtuosoLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var noviceButton: UIButton!
    @IBOutlet weak var regularButton: UIButton!
    @IBOutlet weak var pianistButton: UIButton!
    @IBOutlet weak var virtuosoButton: UIButton!
    
    //MARK: - Actions
    
    @IBAction func noviceButtonTapped(_ sender: Any) {
        noviceButton.pulsate()
        startDelegate?.difficultyType(type: .Novice)
        updateViewFor(gameType: .Novice)
        hapticGenerator.notificationOccurred(.success)
    }
    
    @IBAction func regularButtonTapped(_ sender: Any) {
        if isRegularUnlocked {
            regularButton.pulsate()
            startDelegate?.difficultyType(type: .Regular)
            updateViewFor(gameType: .Regular)
            hapticGenerator.notificationOccurred(.success)
        } else {
            hapticGenerator.notificationOccurred(.error)
        }
    }
    
    @IBAction func pianistButtonTapped(_ sender: Any) {
        if isPianistUnlocked {
            pianistButton.pulsate()
            startDelegate?.difficultyType(type: .Pianist)
            updateViewFor(gameType: .Pianist)
            hapticGenerator.notificationOccurred(.success)
        } else {
            hapticGenerator.notificationOccurred(.error)
        }
    }
    
    @IBAction func virtuosoButtonTapped(_ sender: Any) {
        if isVirtuosoUnlocked {
            virtuosoButton.pulsate()
            startDelegate?.difficultyType(type: .Virtuoso)
            updateViewFor(gameType: .Virtuoso)
            hapticGenerator.notificationOccurred(.success)
        } else {
            hapticGenerator.notificationOccurred(.error)
        }
    }
    
    @IBAction func startButtonTapped(_ sender: Any) {
        startButton.pulsate()
        hapticGenerator.notificationOccurred(.success)
        self.dismiss(animated: true) {
            self.startDelegate?.startGame()
        }
    }
    
    //MARK: - Actions
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

protocol StartGameDelegate {
    func startGame()
    func difficultyType(type:GameType)
}
