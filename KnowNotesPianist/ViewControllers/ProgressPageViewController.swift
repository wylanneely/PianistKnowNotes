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
    var gameType: GameType = .Novice
    
    let hapticGenerator = UINotificationFeedbackGenerator()
    
    private var isNoviceUnlocked: Bool = true
    private var isRegularUnlocked: Bool = false
    private var isPianistUnlocked: Bool = false
    private var isVirtuosoUnlocked: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setUnlockedLockedLevelDifficulties()
        setInstrumentTypeLabel()
        updateViewFor(gameType: .Novice)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        startDelegate?.presentedViewDidClose()
    }
        
    //MARK: SetUp
    
    private func setUnlockedLockedLevelDifficulties(){
        //eventually ad a switch case for instrument type
        
        if let instrumentType {
            switch instrumentType {
            case .BasicPiano:
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
            case .GrandPiano:
                if achievementsController.isGrandPianoNoviceUnlocked() == true {
                    self.isNoviceUnlocked = true
                } else {
                    self.isNoviceUnlocked = false
                }
                if achievementsController.isGrandPianoRegularUnlocked() == true {
                    self.isRegularUnlocked = true
                } else {
                    self.isRegularUnlocked = false
                }
                if achievementsController.isGrandPianoPianistUnlocked() == true {
                    self.isPianistUnlocked = true
                } else {
                    self.isPianistUnlocked = false
                }
                if achievementsController.isGrandPianoVirtuosoUnlocked() == true {
                    self.isVirtuosoUnlocked = true
                } else {
                    self.isVirtuosoUnlocked = false
                }
                setButtonStates()
            case .AcousticGuitar:
                if achievementsController.isAcousticNoviceUnlocked() == true {
                    self.isNoviceUnlocked = true
                } else {
                    self.isNoviceUnlocked = false
                }
                if achievementsController.isAcousticRegularUnlocked() == true {
                    self.isRegularUnlocked = true
                } else {
                    self.isRegularUnlocked = false
                }
                
                if achievementsController.isAcousticPianistUnlocked() == true {
                    self.isPianistUnlocked = true
                } else {
                    self.isPianistUnlocked = false
                }
                
                if achievementsController.isAcousticVirtuosoUnlocked() == true {
                    self.isVirtuosoUnlocked = true
                } else {
                    self.isVirtuosoUnlocked = false
                }
                setButtonStates()
            case .Keyboard:
                if achievementsController.isKeyboardNoviceUnlocked() == true {
                    self.isNoviceUnlocked = true
                } else {
                    self.isNoviceUnlocked = false
                }
                if achievementsController.isKeyboardRegularUnlocked() == true {
                    self.isRegularUnlocked = true
                } else {
                    self.isRegularUnlocked = false
                }
                
                if achievementsController.isKeyboardPianistUnlocked() == true {
                    self.isPianistUnlocked = true
                } else {
                    self.isPianistUnlocked = false
                }
                
                if achievementsController.isKeyboardVirtuosoUnlocked() == true {
                    self.isVirtuosoUnlocked = true
                } else {
                    self.isVirtuosoUnlocked = false
                }
                setButtonStates()
            case .Violin:
                if achievementsController.isViolinNoviceUnlocked() == true {
                    self.isNoviceUnlocked = true
                } else {
                    self.isNoviceUnlocked = false
                }
                if achievementsController.isViolinRegularUnlocked() == true {
                    self.isRegularUnlocked = true
                } else {
                    self.isRegularUnlocked = false
                }
                
                if achievementsController.isViolinPianistUnlocked() == true {
                    self.isPianistUnlocked = true
                } else {
                    self.isPianistUnlocked = false
                }
                
                if achievementsController.isViolinVirtuosoUnlocked() == true {
                    self.isVirtuosoUnlocked = true
                } else {
                    self.isVirtuosoUnlocked = false
                }
                setButtonStates()
            }
        }
    }
    
    private func setButtonStates(){
        let unlockedImage = UIImage(named: "UnlockedButtonImage")
        let lockedImage = UIImage(named: "LockedButtonImage")
        
        if isNoviceUnlocked {
            noviceButton.setImage(unlockedImage, for: .normal)
        } else {
            noviceButton.setImage(lockedImage, for: .normal)
        }
        if isRegularUnlocked {
            regularButton.setImage(unlockedImage, for: .normal)
        } else {
            regularButton.setImage(lockedImage, for: .normal)
        }
        if isPianistUnlocked {
            pianistButton.setImage(unlockedImage, for: .normal)
        } else {
            pianistButton.setImage(lockedImage, for: .normal)
        }
        if isVirtuosoUnlocked {
            virtuosoButton.setImage(unlockedImage, for: .normal)
        } else {
            virtuosoButton.setImage(lockedImage, for: .normal)
        }
        
    }
    
   private func setInstrumentTypeLabel(){
       instrumentTypeLabel.font =  UIFont(name: "Poppins-Bold", size: 34)
       noviceLabel.font =  UIFont(name: "Poppins-Bold", size: 30)
       regularLabel.font =  UIFont(name: "Poppins-Bold", size: 30)
       pianistLabel.font =  UIFont(name: "Poppins-Bold", size: 30)
       virtuosoLabel.font =  UIFont(name: "Poppins-Bold", size: 30)

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
            case .Violin:
                instrumentTypeLabel.text = InstrumentTypeName.Violin.rawValue
            }
        }
    }
    
    //MARK: - Update
    
   private func updateViewFor(gameType: GameType){
        switch gameType {
        case .Novice:
            if isNoviceUnlocked {
                noviceLabel.textColor = .white
                threeLabel.textColor = .white
            } else {
                noviceLabel.textColor = .black
                threeLabel.textColor = .black
            }
            if isRegularUnlocked {
                regularLabel.textColor = .systemGray
                fiveLabel.textColor = .systemGray
            } else {
                regularLabel.textColor = .black
                fiveLabel.textColor = .black
            }
            if isPianistUnlocked {
                pianistLabel.textColor = .systemGray
                sevenLabel.textColor = .systemGray
            } else {
                pianistLabel.textColor = .black
                sevenLabel.textColor = .black
            }
            if isVirtuosoUnlocked {
                virtuosoLabel.textColor = .systemGray
                twelveLabel.textColor = .systemGray
            } else {
                virtuosoLabel.textColor = .black
                twelveLabel.textColor = .black
            }
        case .Regular:
            noviceLabel.textColor = .systemGray
            threeLabel.textColor = .systemGray
            regularLabel.textColor = .white
            fiveLabel.textColor = .white
            if isPianistUnlocked {
                pianistLabel.textColor = .systemGray
                sevenLabel.textColor = .systemGray
            } else {
                pianistLabel.textColor = .black
                sevenLabel.textColor = .black
            }
            if isVirtuosoUnlocked {
                virtuosoLabel.textColor = .systemGray
                twelveLabel.textColor = .systemGray
            } else {
                virtuosoLabel.textColor = .black
                twelveLabel.textColor = .black
            }
        case .Pianist:
            noviceLabel.textColor = .systemGray
            threeLabel.textColor = .systemGray
            regularLabel.textColor = .systemGray
            fiveLabel.textColor = .systemGray
            pianistLabel.textColor = .white
            sevenLabel.textColor = .white
            if isVirtuosoUnlocked {
                virtuosoLabel.textColor = .systemGray
                twelveLabel.textColor = .systemGray
            } else {
                virtuosoLabel.textColor = .black
                twelveLabel.textColor = .black
            }
        case .Virtuoso:
            noviceLabel.textColor = .systemGray
            threeLabel.textColor = .systemGray
            regularLabel.textColor = .systemGray
            fiveLabel.textColor = .systemGray
            pianistLabel.textColor = .systemGray
            sevenLabel.textColor = .systemGray
            virtuosoLabel.textColor = .white
            twelveLabel.textColor = .white
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
    @IBOutlet weak var threeLabel: UILabel!
    @IBOutlet weak var fiveLabel: UILabel!
    @IBOutlet weak var sevenLabel: UILabel!
    @IBOutlet weak var twelveLabel: UILabel!
    
    //MARK: - Actions
    
    @IBAction func noviceButtonTapped(_ sender: Any) {
        if isNoviceUnlocked {
            self.gameType = .Novice
            noviceButton.pulsate()
            updateViewFor(gameType: .Novice)
            hapticGenerator.notificationOccurred(.success)
        } else {
            hapticGenerator.notificationOccurred(.error)
        }
    }
    
    @IBAction func regularButtonTapped(_ sender: Any) {
        if isRegularUnlocked {
            self.gameType = .Regular
            regularButton.pulsate()
            updateViewFor(gameType: .Regular)
            hapticGenerator.notificationOccurred(.success)
        } else {
            hapticGenerator.notificationOccurred(.error)
        }
    }
    
    @IBAction func pianistButtonTapped(_ sender: Any) {
        if isPianistUnlocked {
            self.gameType = .Pianist
            pianistButton.pulsate()
            updateViewFor(gameType: .Pianist)
            hapticGenerator.notificationOccurred(.success)
        } else {
            hapticGenerator.notificationOccurred(.error)
        }
    }
    
    @IBAction func virtuosoButtonTapped(_ sender: Any) {
        if isVirtuosoUnlocked {
            self.gameType = .Virtuoso
            virtuosoButton.pulsate()
            updateViewFor(gameType: .Virtuoso)
            hapticGenerator.notificationOccurred(.success)
        } else {
            hapticGenerator.notificationOccurred(.error)
        }
    }
    
    @IBAction func startButtonTapped(_ sender: Any) {
        if isNoviceUnlocked == false {
            startButton.pulsate()
            hapticGenerator.notificationOccurred(.error)
            return
        } else {
            startButton.pulsate()
            hapticGenerator.notificationOccurred(.success)
            self.dismiss(
                animated: true
            ) {
                if let instrument = self.instrumentType {
                    self.startDelegate?.startGame(
                        type: self.gameType,
                        instrument: instrument
                    )
                }
            }
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
    func startGame(type:GameType,instrument:InstrumentType)
    func presentedViewDidClose()
}
