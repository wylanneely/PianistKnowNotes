//
//  VirtuosoGameViewController.swift
//  KnowNotesPianist
//
//  Created by Wylan L Neely on 3/20/24.
//

import UIKit
import AVFoundation

class VirtuosoGameViewController: UIViewController, FinishedPopUpDelegate {

    var gameController = GameController(gameType: .Virtuoso)
    var lifeImageController = LifeImages()
    var instrument: InstrumentType = .BasicPiano

    var currentNoteID: Int?
    var isNewGame: Bool = true
    var isNewNote: Bool = true
    var guessedNotesIDs = [Int]()

    let hapticGenerator = UINotificationFeedbackGenerator()
    let mediumImpact = UIImpactFeedbackGenerator(style: .medium)
    let heavyImpact = UIImpactFeedbackGenerator(style: .heavy)
    let guessedImpact = UIImpactFeedbackGenerator(style: .soft)
    
    // variables to help transition last Image for button
    let startButtonImage = UIImage(named: "StartGameButton")
    let playButtonImage = UIImage(named: "PlayButton")
    let repeatButtonImage = UIImage(named: "RepeatButton")
    
    //language localization
    private var language: String = NSLocalizedString("AppLanguage", comment: "to help adjust certain views/settings")
    private let virtuosoString =  NSLocalizedString("Virtuoso",comment: "")
    
    
    //MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpButtons()
        updateGameStats()
        setUpProgressBar()
        setUpGradientColorLabel()
        self.presentationController?.delegate = self
        setSoundPack()
        setUpAudio()
        setUpLanguageLocalization()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    //MARK: - Audio
    var soundController: SoundController = SoundController(soundPack: BasicPianoPack, gameType: .Virtuoso)

    func setSoundPack(){
        switch instrument {
        case .BasicPiano:
            soundController = SoundController(soundPack: BasicPianoPack, gameType: .Virtuoso)
        case .GrandPiano:
           soundController = SoundController(soundPack: GrandPianoPack, gameType: .Virtuoso)
        case .AcousticGuitar:
            return
        case .Keyboard:
            return
        case .Violin:
            soundController = SoundController(soundPack: ViolinPack, gameType: .Virtuoso)
        }
    }

    var player: AVAudioPlayer!
    
   private func playSound(noteAnswerID:Int){
        if let soundURL = soundController.returnSoundPathFrom(noteID: noteAnswerID) {
           player = try! AVAudioPlayer(contentsOf: soundURL)
            player!.play()
        }
    }
    
   private func setUpAudio(){
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
        } catch(let error) {
            print(error.localizedDescription)
        }
    }
    
    
    //MARK: - SetUP
    
   private func setUpButtons(){
        AButton.layer.shadowColor = UIColor.regularShadow.cgColor
        AButton.layer.shadowOffset = CGSize(width: 1.3, height: 3.0)
        AButton.layer.shadowRadius = 8
        AButton.layer.shadowOpacity = 0.6 
        ASButton.layer.shadowColor = UIColor.regularShadow.cgColor
        ASButton.layer.shadowOffset = CGSize(width: 1.3, height: 3.0)
        ASButton.layer.shadowRadius = 8
        ASButton.layer.shadowOpacity = 0.6
        BButton.layer.shadowColor = UIColor.regularShadow.cgColor
        BButton.layer.shadowOffset = CGSize(width: 1.0, height: 4.0)
        BButton.layer.shadowRadius = 8
        BButton.layer.shadowOpacity = 0.6
        CButton.layer.shadowColor = UIColor.regularShadow.cgColor
        CButton.layer.shadowOffset = CGSize(width: 1.0, height: 4.0)
        CButton.layer.shadowRadius = 8
        CButton.layer.shadowOpacity = 0.6
        CSButton.layer.shadowColor = UIColor.regularShadow.cgColor
        CSButton.layer.shadowOffset = CGSize(width: 1.0, height: 4.0)
        CSButton.layer.shadowRadius = 8
        CSButton.layer.shadowOpacity = 0.6
        DButton.layer.shadowColor = UIColor.regularShadow.cgColor
        DButton.layer.shadowOffset = CGSize(width: 1.0, height: 4.0)
        DButton.layer.shadowRadius = 8
        DButton.layer.shadowOpacity = 0.6
        DSButton.layer.shadowColor = UIColor.regularShadow.cgColor
        DSButton.layer.shadowOffset = CGSize(width: 1.0, height: 4.0)
        DSButton.layer.shadowRadius = 8
        DSButton.layer.shadowOpacity = 0.6
        EButton.layer.shadowColor = UIColor.regularShadow.cgColor
        EButton.layer.shadowOffset = CGSize(width: 1.0, height: 4.0)
        EButton.layer.shadowRadius = 8
        EButton.layer.shadowOpacity = 0.6
        FButton.layer.shadowColor = UIColor.regularShadow.cgColor
        FButton.layer.shadowOffset = CGSize(width: 1.3, height: 3.0)
        FButton.layer.shadowRadius = 8
        FButton.layer.shadowOpacity = 0.6
        FSButton.layer.shadowColor = UIColor.regularShadow.cgColor
        FSButton.layer.shadowOffset = CGSize(width: 1.3, height: 3.0)
        FSButton.layer.shadowRadius = 8
        FSButton.layer.shadowOpacity = 0.6
        GButton.layer.shadowColor = UIColor.regularShadow.cgColor
        GButton.layer.shadowOffset = CGSize(width: 1.0, height: 4.0)
        GButton.layer.shadowRadius = 8
        GButton.layer.shadowOpacity = 0.6
        GSButton.layer.shadowColor = UIColor.regularShadow.cgColor
        GSButton.layer.shadowOffset = CGSize(width: 1.0, height: 4.0)
        GSButton.layer.shadowRadius = 8
        GSButton.layer.shadowOpacity = 0.6
        PlayButton.layer.shadowColor = UIColor.regularShadow.cgColor
        PlayButton.layer.shadowOffset = CGSize(width: 1.0, height: 3.0)
        PlayButton.layer.shadowRadius = 6
        PlayButton.layer.shadowOpacity = 0.6
        HomeButton.layer.shadowColor = UIColor.regularShadow.cgColor
        HomeButton.layer.shadowOffset = CGSize(width: 1.0, height: 3.0)
        HomeButton.layer.shadowRadius = 6
        HomeButton.layer.shadowOpacity = 0.6
    }
    
    private func setUpGradientColorLabel(){
        switch language {
        case "Chinese":
            ScoreLabel.gradientColors = [UIColor.systemRed.cgColor, UIColor.systemYellow.cgColor]
        case "Potruguese":
            ScoreLabel.gradientColors = [UIColor.systemGreen.cgColor, UIColor.systemYellow.cgColor]
        case "French":
            ScoreLabel.gradientColors = [UIColor.systemRed.cgColor, UIColor.darkBlue.cgColor]
        case "Spanish":
            ScoreLabel.gradientColors = [UIColor.systemBlue.cgColor, UIColor.systemCyan.cgColor]
        case "Korean":
            ScoreLabel.gradientColors = [UIColor.systemRed.cgColor, UIColor.darkBlue.cgColor]
        case "Japanese":
            ScoreLabel.gradientColors = [UIColor.systemRed.cgColor, UIColor.red.cgColor]
        case "German":
            ScoreLabel.gradientColors = [UIColor.systemYellow.cgColor, UIColor.systemRed.cgColor]
        case "Russian":
            ScoreLabel.gradientColors = [UIColor.systemRed.cgColor, UIColor.darkBlue.cgColor]
        case "Italian":
            ScoreLabel.gradientColors = [UIColor.systemRed.cgColor, UIColor.systemGreen.cgColor]
        case "Thai":
            ScoreLabel.gradientColors = [UIColor.systemBlue.cgColor, UIColor.systemGreen.cgColor]
        default:
            ScoreLabel.gradientColors = [UIColor.systemBlue.cgColor, UIColor.systemPurple.cgColor]
        }
    }
    
    private func setUpLanguageLocalization(){
        virtuosoLabel.text = virtuosoString
    }
    
    //MARK: - Outlets
    
    @IBOutlet weak var HomeButton: UIButton!
    @IBOutlet weak var ScoreLabel: GradientLabel!
    @IBOutlet weak var LifeImage: UIImageView!
    @IBOutlet weak var AButton: UIButton!
    @IBOutlet weak var ASButton: UIButton!
    @IBOutlet weak var BButton: UIButton!
    @IBOutlet weak var CButton: UIButton!
    @IBOutlet weak var CSButton: UIButton!
    @IBOutlet weak var DButton: UIButton!
    @IBOutlet weak var DSButton: UIButton!
    @IBOutlet weak var EButton: UIButton!
    @IBOutlet weak var FButton: UIButton!
    @IBOutlet weak var FSButton: UIButton!
    @IBOutlet weak var GButton: UIButton!
    @IBOutlet weak var GSButton: UIButton!
    @IBOutlet weak var PlayButton: UIButton!
    @IBOutlet weak var CircularProgressView: CircularProgressBar!
    @IBOutlet weak var virtuosoLabel: UILabel!
    
    //MARK: - Circular Progress Bar
    
    func setUpProgressBar(){
        CircularProgressView.labelSize = 60
        CircularProgressView.safePercent = 100
        CircularProgressView.lineWidth = 20
        CircularProgressView.safePercent = 100
       // CircularProgressView.layer.cornerRadius = CircularProgressView.frame.size.width/2
        CircularProgressView.clipsToBounds = true
        CircularProgressView.layer.shadowColor = UIColor.regularShadow.cgColor
        CircularProgressView.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
        CircularProgressView.layer.shadowRadius = 8
        CircularProgressView.layer.shadowOpacity = 0.6
        
    }
    func updateProgressBar(){
        //function to add a single life each 50 points correct
        //once hit 100 points high score or 100 rounds on Virtuoso, unlock new sound
        let progress = currentRound/totalGroupRounds
        CircularProgressView.setProgress(to: progress , withAnimation: false)
        self.currentRound = currentRound + 1.0
    }
    
    func restartProgressBar(){
        self.currentRound = 0
        CircularProgressView.setProgress(to: currentRound, withAnimation: false)
    }
    
    
        let totalGroupRounds: Double = 49.00
        var currentRound: Double = 1.00
    
    //MARK: - Actions
    
    @IBAction func PlayButtonTapped(_ sender: Any) {
        if isNewGame {
            self.isNewGame = false
            hapticGenerator.notificationOccurred(.success)
            self.PlayButton.changeImageAnimated(toImage: self.playButtonImage, fromImage: self.startButtonImage)
            return
        }
        if isNewNote {
            self.currentNoteID = gameController.generateNextNoteID()
            print("play sound \(String(describing: currentNoteID))")
            if let cNoteID = currentNoteID {
                DispatchQueue.main.async{
                    self.playSound(noteAnswerID: cNoteID)
                    self.PlayButton.pulsate()
                    self.mediumImpact.impactOccurred()
                    self.PlayButton.changeImageAnimated(toImage: self.repeatButtonImage, fromImage: self.playButtonImage)
                }
            }
            self.isNewNote = false
        } else {
            print("play sound \(String(describing: currentNoteID))")
            if let cNoteID = currentNoteID {
                DispatchQueue.main.async{
                    self.playSound(noteAnswerID: cNoteID)
                    self.PlayButton.pulsate()
                    self.mediumImpact.impactOccurred()
                }
            }
        }
    }
    
    @IBAction func AButtonTapped(_ sender: Any) {
        if isNewGame {
            self.playSound(noteAnswerID: 0)
            AButton.pulsateGuessed()
            guessedImpact.impactOccurred()
            return
        }
        
        if isNewNote {
            AButton.pulsateGuessed()
            guessedImpact.impactOccurred()
            return
        } else {
            if guessedNotesIDs.contains(0) {
                AButton.pulsateGuessed()
                guessedImpact.impactOccurred()
            } else {
                let result = gameController.updateGameWith(noteAnswerID: 0)
                self.playSound(noteAnswerID: 0)
                if result.isCorrect {
                    AButton.pulsate()
                    hapticGenerator.notificationOccurred(.success)
                    updateProgressBar()
                    self.updateGameStats()
                    self.isNewNote = true
                    self.guessedNotesIDs = []
                    self.PlayButton.changeImageAnimated(toImage: self.playButtonImage, fromImage: self.repeatButtonImage)
                } else {
                    if result.isGameOver {
                        hapticGenerator.notificationOccurred(.error)
                        AButton.pulsateWrong()
                        self.endGame()
                    } else {
                        hapticGenerator.notificationOccurred(.error)
                        AButton.pulsateWrong()
                        self.guessedNotesIDs.append(0)
                        self.updateGameStats()
                    }
                }
            }
        }

    }
    @IBAction func ASButtonTapped(_ sender: Any) {
        if isNewGame {
            self.playSound(noteAnswerID: 1)
            ASButton.pulsateGuessed()
            guessedImpact.impactOccurred()
            return
        }
        
        if isNewNote {
            ASButton.pulsateGuessed()
            guessedImpact.impactOccurred()
            return
        } else {
            if guessedNotesIDs.contains(1) {
                ASButton.pulsateGuessed()
                guessedImpact.impactOccurred()
            } else {
                let result = gameController.updateGameWith(noteAnswerID: 1)
                self.playSound(noteAnswerID: 1)
                if result.isCorrect {
                    ASButton.pulsate()
                    hapticGenerator.notificationOccurred(.success)
                    updateProgressBar()
                    self.updateGameStats()
                    self.isNewNote = true
                    self.guessedNotesIDs = []
                    self.PlayButton.changeImageAnimated(toImage: self.playButtonImage, fromImage: self.repeatButtonImage)
                } else {
                    if result.isGameOver {
                        hapticGenerator.notificationOccurred(.error)
                        ASButton.pulsateWrong()
                        self.endGame()
                    } else {
                        hapticGenerator.notificationOccurred(.error)
                        ASButton.pulsateWrong()
                        self.guessedNotesIDs.append(1)
                        self.updateGameStats()
                    }
                }
            }
        }
    }
    @IBAction func BButtonTapped(_ sender: Any) {
        if isNewGame {
            self.playSound(noteAnswerID: 2)
            BButton.pulsateGuessed()
            guessedImpact.impactOccurred()
            return
        }
        
        if isNewNote {
            BButton.pulsateGuessed()
            guessedImpact.impactOccurred()
            return
        } else {
            if guessedNotesIDs.contains(2) {
                BButton.pulsateGuessed()
                guessedImpact.impactOccurred()
            } else {
                let result = gameController.updateGameWith(noteAnswerID: 2)
                self.playSound(noteAnswerID: 2)
                if result.isCorrect {
                    BButton.pulsate()
                    hapticGenerator.notificationOccurred(.success)
                    updateProgressBar()
                    self.updateGameStats()
                    self.isNewNote = true
                    self.guessedNotesIDs = []
                    self.PlayButton.changeImageAnimated(toImage: self.playButtonImage, fromImage: self.repeatButtonImage)
                } else {
                    if result.isGameOver {
                        hapticGenerator.notificationOccurred(.error)
                        BButton.pulsateWrong()
                        self.endGame()
                    } else {
                        hapticGenerator.notificationOccurred(.error)
                        BButton.pulsateWrong()
                        self.guessedNotesIDs.append(2)
                        self.updateGameStats()
                    }
                }
            }
        }

    }
    @IBAction func CButtonTapped(_ sender: Any) {
        if isNewGame {
            self.playSound(noteAnswerID: 3)
            CButton.pulsateGuessed()
            guessedImpact.impactOccurred()
            return
        }
        
        if isNewNote {
            CButton.pulsateGuessed()
            guessedImpact.impactOccurred()
            return
        } else {
            if guessedNotesIDs.contains(3) {
                CButton.pulsateGuessed()
                guessedImpact.impactOccurred()
            } else {
                let result = gameController.updateGameWith(noteAnswerID: 3)
                self.playSound(noteAnswerID: 3)
                if result.isCorrect {
                    CButton.pulsate()
                    hapticGenerator.notificationOccurred(.success)
                    updateProgressBar()
                    self.updateGameStats()
                    self.isNewNote = true
                    self.guessedNotesIDs = []
                    self.PlayButton.changeImageAnimated(toImage: self.playButtonImage, fromImage: self.repeatButtonImage)
                } else {
                    if result.isGameOver {
                        hapticGenerator.notificationOccurred(.error)
                        CButton.pulsateWrong()
                        self.endGame()
                    } else {
                        hapticGenerator.notificationOccurred(.error)
                        CButton.pulsateWrong()
                        self.guessedNotesIDs.append(3)
                        self.updateGameStats()
                    }
                }
            }
        }
    }
    @IBAction func CSButtonTapped(_ sender: Any) {
        if isNewGame {
            self.playSound(noteAnswerID: 4)
            CSButton.pulsateGuessed()
            guessedImpact.impactOccurred()
            return
        }
        
        if isNewNote {
            CSButton.pulsateGuessed()
            guessedImpact.impactOccurred()
            return
        } else {
            if guessedNotesIDs.contains(4) {
                CSButton.pulsateGuessed()
                guessedImpact.impactOccurred()
            } else {
                let result = gameController.updateGameWith(noteAnswerID: 4)
                self.playSound(noteAnswerID: 4)
                if result.isCorrect {
                    CSButton.pulsate()
                    hapticGenerator.notificationOccurred(.success)
                    updateProgressBar()
                    self.updateGameStats()
                    self.isNewNote = true
                    self.guessedNotesIDs = []
                    self.PlayButton.changeImageAnimated(toImage: self.playButtonImage, fromImage: self.repeatButtonImage)
                } else {
                    if result.isGameOver {
                        hapticGenerator.notificationOccurred(.error)
                        CSButton.pulsateWrong()
                        self.endGame()
                    } else {
                        hapticGenerator.notificationOccurred(.error)
                        CSButton.pulsateWrong()
                        self.guessedNotesIDs.append(4)
                        self.updateGameStats()
                    }
                }
            }
        }
    }
    @IBAction func DButtonTapped(_ sender: Any) {
        if isNewGame {
            self.playSound(noteAnswerID: 5)
            DButton.pulsateGuessed()
            guessedImpact.impactOccurred()
            return
        }
        
        if isNewNote {
            DButton.pulsateGuessed()
            guessedImpact.impactOccurred()
            return
        } else {
            if guessedNotesIDs.contains(5) {
                DButton.pulsateGuessed()
                guessedImpact.impactOccurred()
            } else {
                let result = gameController.updateGameWith(noteAnswerID: 5)
                self.playSound(noteAnswerID: 5)
                if result.isCorrect {
                    DButton.pulsate()
                    hapticGenerator.notificationOccurred(.success)
                    updateProgressBar()
                    self.updateGameStats()
                    self.isNewNote = true
                    self.guessedNotesIDs = []
                    self.PlayButton.changeImageAnimated(toImage: self.playButtonImage, fromImage: self.repeatButtonImage)
                } else {
                    if result.isGameOver {
                        hapticGenerator.notificationOccurred(.error)
                        DButton.pulsateWrong()
                        self.endGame()
                    } else {
                        hapticGenerator.notificationOccurred(.error)
                        DButton.pulsateWrong()
                        self.guessedNotesIDs.append(5)
                        self.updateGameStats()
                    }
                }
            }
        }
    }
    @IBAction func DSButtonTapped(_ sender: Any) {
        if isNewGame {
            self.playSound(noteAnswerID: 6)
            DSButton.pulsateGuessed()
            guessedImpact.impactOccurred()
            return
        }
        
        if isNewNote {
            DSButton.pulsateGuessed()
            guessedImpact.impactOccurred()
            return
        } else {
            if guessedNotesIDs.contains(6) {
                DSButton.pulsateGuessed()
                guessedImpact.impactOccurred()
            } else {
                let result = gameController.updateGameWith(noteAnswerID: 6)
                self.playSound(noteAnswerID: 6)
                if result.isCorrect {
                    DSButton.pulsate()
                    hapticGenerator.notificationOccurred(.success)
                    updateProgressBar()
                    self.updateGameStats()
                    self.isNewNote = true
                    self.guessedNotesIDs = []
                    self.PlayButton.changeImageAnimated(toImage: self.playButtonImage, fromImage: self.repeatButtonImage)
                } else {
                    if result.isGameOver {
                        hapticGenerator.notificationOccurred(.error)
                        DSButton.pulsateWrong()
                        self.endGame()
                    } else {
                        hapticGenerator.notificationOccurred(.error)
                        DSButton.pulsateWrong()
                        self.guessedNotesIDs.append(6)
                        self.updateGameStats()
                    }
                }
            }
        }
    }
    @IBAction func EButtonTapped(_ sender: Any) {
        if isNewGame {
            self.playSound(noteAnswerID: 7)
            EButton.pulsateGuessed()
            guessedImpact.impactOccurred()
            return
        }
        
        if isNewNote {
            EButton.pulsateGuessed()
            guessedImpact.impactOccurred()
            return
        } else {
            if guessedNotesIDs.contains(7) {
                EButton.pulsateGuessed()
                guessedImpact.impactOccurred()
            } else {
                let result = gameController.updateGameWith(noteAnswerID: 7)
                self.playSound(noteAnswerID: 7)
                if result.isCorrect {
                    EButton.pulsate()
                    hapticGenerator.notificationOccurred(.success)
                    updateProgressBar()
                    self.updateGameStats()
                    self.isNewNote = true
                    self.guessedNotesIDs = []
                    self.PlayButton.changeImageAnimated(toImage: self.playButtonImage, fromImage: self.repeatButtonImage)
                } else {
                    if result.isGameOver {
                        hapticGenerator.notificationOccurred(.error)
                        EButton.pulsateWrong()
                        self.endGame()
                    } else {
                        hapticGenerator.notificationOccurred(.error)
                        EButton.pulsateWrong()
                        self.guessedNotesIDs.append(7)
                        self.updateGameStats()
                    }
                }
            }
        }
    }
    @IBAction func FButtonTapped(_ sender: Any) {
        if isNewGame {
            self.playSound(noteAnswerID: 8)
            FButton.pulsateGuessed()
            guessedImpact.impactOccurred()
            return
        }
        
        if isNewNote {
            FButton.pulsateGuessed()
            guessedImpact.impactOccurred()
            return
        } else {
            if guessedNotesIDs.contains(8) {
                FButton.pulsateGuessed()
                guessedImpact.impactOccurred()
            } else {
                let result = gameController.updateGameWith(noteAnswerID: 8)
                self.playSound(noteAnswerID: 8)
                if result.isCorrect {
                    FButton.pulsate()
                    hapticGenerator.notificationOccurred(.success)
                    updateProgressBar()
                    self.updateGameStats()
                    self.isNewNote = true
                    self.guessedNotesIDs = []
                    self.PlayButton.changeImageAnimated(toImage: self.playButtonImage, fromImage: self.repeatButtonImage)
                } else {
                    if result.isGameOver {
                        hapticGenerator.notificationOccurred(.error)
                        FButton.pulsateWrong()
                        self.endGame()
                    } else {
                        hapticGenerator.notificationOccurred(.error)
                        FButton.pulsateWrong()
                        self.guessedNotesIDs.append(8)
                        self.updateGameStats()
                    }
                }
            }
        }
    }
    @IBAction func FSButtonTapped(_ sender: Any) {
        if isNewGame {
            self.playSound(noteAnswerID: 9)
            FSButton.pulsateGuessed()
            guessedImpact.impactOccurred()
            return
        }
        
        if isNewNote {
            FSButton.pulsateGuessed()
            guessedImpact.impactOccurred()
            return
        } else {
            if guessedNotesIDs.contains(9) {
                FSButton.pulsateGuessed()
                guessedImpact.impactOccurred()
            } else {
                let result = gameController.updateGameWith(noteAnswerID: 9)
                self.playSound(noteAnswerID: 9)
                if result.isCorrect {
                    FSButton.pulsate()
                    hapticGenerator.notificationOccurred(.success)
                    updateProgressBar()
                    self.updateGameStats()
                    self.isNewNote = true
                    self.guessedNotesIDs = []
                    self.PlayButton.changeImageAnimated(toImage: self.playButtonImage, fromImage: self.repeatButtonImage)
                } else {
                    if result.isGameOver {
                        hapticGenerator.notificationOccurred(.error)
                        FSButton.pulsateWrong()
                        self.endGame()
                    } else {
                        hapticGenerator.notificationOccurred(.error)
                        FSButton.pulsateWrong()
                        self.guessedNotesIDs.append(9)
                        self.updateGameStats()
                    }
                }
            }
        }
    }
    @IBAction func GButtonTapped(_ sender: Any) {
        if isNewGame {
            self.playSound(noteAnswerID: 10)
            GButton.pulsateGuessed()
            guessedImpact.impactOccurred()
            return
        }
        
        if isNewNote {
            GButton.pulsateGuessed()
            guessedImpact.impactOccurred()
            return
        } else {
            if guessedNotesIDs.contains(10) {
                GButton.pulsateGuessed()
                guessedImpact.impactOccurred()
            } else {
                let result = gameController.updateGameWith(noteAnswerID: 10)
                self.playSound(noteAnswerID: 10)
                if result.isCorrect {
                    GButton.pulsate()
                    hapticGenerator.notificationOccurred(.success)
                    updateProgressBar()
                    self.updateGameStats()
                    self.isNewNote = true
                    self.guessedNotesIDs = []
                    self.PlayButton.changeImageAnimated(toImage: self.playButtonImage, fromImage: self.repeatButtonImage)
                } else {
                    if result.isGameOver {
                        hapticGenerator.notificationOccurred(.error)
                        GButton.pulsateWrong()
                        self.endGame()
                    } else {
                        hapticGenerator.notificationOccurred(.error)
                        GButton.pulsateWrong()
                        self.guessedNotesIDs.append(10)
                        self.updateGameStats()
                    }
                }
            }
        }
    }
    @IBAction func GSButtonTapped(_ sender: Any) {
        if isNewGame {
            self.playSound(noteAnswerID: 11)
            GSButton.pulsateGuessed()
            guessedImpact.impactOccurred()
            return
        }
        
        if isNewNote {
            GSButton.pulsateGuessed()
            guessedImpact.impactOccurred()
            return
        } else {
            if guessedNotesIDs.contains(11) {
                GSButton.pulsateGuessed()
                guessedImpact.impactOccurred()
            } else {
                let result = gameController.updateGameWith(noteAnswerID: 11)
                self.playSound(noteAnswerID: 11)
                if result.isCorrect {
                    GSButton.pulsate()
                    hapticGenerator.notificationOccurred(.success)
                    updateProgressBar()
                    self.updateGameStats()
                    self.isNewNote = true
                    self.guessedNotesIDs = []
                    self.PlayButton.changeImageAnimated(toImage: self.playButtonImage, fromImage: self.repeatButtonImage)
                } else {
                    if result.isGameOver {
                        hapticGenerator.notificationOccurred(.error)
                        GSButton.pulsateWrong()
                        self.endGame()
                    } else {
                        hapticGenerator.notificationOccurred(.error)
                        GSButton.pulsateWrong()
                        self.guessedNotesIDs.append(11)
                        self.updateGameStats()
                    }
                }
            }
        }
    }
    
    @IBAction func HomeButtonTapped(_ sender: Any) {
        HomeButton.pulsate()
        mediumImpact.impactOccurred()
        showFinishedGamePopup(isPaused: true)
    }
    
    //MARK: - CRUD Functions
    
    func showFinishedGamePopup(isPaused:Bool){
        let popUpView = FinishedGamePopUp()
        popUpView.isPaused = isPaused
        popUpView.delegate = self
        popUpView.game = gameController.currentGame
        popUpView.appear(sender: self)
    }
    
    func updateGameStats(){
        let result = gameController.returnGameStats()
        updateLifeImage(lifes: result.lifes)
        ScoreLabel.text = "\(result.score)"
    }
    
    func updateLifeImage(lifes: Int){
        let image = lifeImageController.returnLifeImage(for: lifes)
        LifeImage.image = image
    }
    
    func endGame(){
        updateGameStats()
        showFinishedGamePopup(isPaused: false)
    }
    
    func restartGame(){
        restartProgressBar()
        gameController.restartGame()
        updateGameStats()
        self.guessedNotesIDs = []
        self.isNewGame = true
        self.isNewNote = true
        let currentImage = self.PlayButton.imageView?.image
        self.PlayButton.changeImageAnimated(toImage: startButtonImage, fromImage: currentImage)
    }
    
    //MARK: - Delegates
    
    func finishedPopUpRestartedGame() {
        restartGame()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension VirtuosoGameViewController: UIAdaptivePresentationControllerDelegate {
    
    func presentationControllerShouldDismiss(_ presentationController: UIPresentationController) -> Bool {
        //put logic gate here to check if game is over
        return false
    }
}
