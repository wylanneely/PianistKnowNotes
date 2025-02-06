//
//  MultiplayerVirtuosoViewController.swift
//  KnowNotesPianist
//
//  Created by Wylan L Neely on 2/5/25.
//

import UIKit
import AVFoundation

class MultiplayerVirtuosoViewController: UIViewController, FinishedPopUpDelegate {
    
    var gameController = GameController(gameType: .Virtuoso)
    var lifeImageController = LifeImages()
    var instrument: InstrumentType = .BasicPiano

    var currentNoteID: Int?
    var isNewGame: Bool = true
    var isNewNote: Bool = true
    var guessedNotesIDs = [Int]()

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
            soundController = SoundController(soundPack: AGuitarMajorPack, gameType: .Virtuoso)
        case .Keyboard:
            soundController = SoundController(soundPack: KeyboardPack, gameType: .Virtuoso)
        case .Violin:
            soundController = SoundController(soundPack: ViolinPack, gameType: .Virtuoso)
        case .AcousticMinor:
            soundController = SoundController(soundPack: AGuitarMinorPack, gameType: .Virtuoso)
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
    
    //MARK: - Haptics
    
    func wrongTapFeedback() {
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
        // Adding a short delay before the second buzz
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            generator.impactOccurred()
        }
     
    }
    
    func clickTapImpact() {
        let clickedImpact = UIImpactFeedbackGenerator(style: .soft)
        clickedImpact.impactOccurred()
    }

    func successfulTapFeedback() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
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
    @IBOutlet weak var correctIncorrectImageV: UIImageView!

    
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
    
    
    //MARK: Correct Incorrect Updates
    
    let correctImage = UIImage(named: "CorrectBackground")
    let incorrectImage = UIImage(named: "IncorrectBackground")
    
    func updateCorrect(){
        correctIncorrectImageV.alpha = 00
        correctIncorrectImageV.image = correctImage
        UIView.animate(withDuration: 0.2,delay: 0,options:[.curveEaseOut] ,animations: {
                   self.correctIncorrectImageV.alpha = 1.0
               }, completion: { _ in
                   // After the image view appears, hide it again after a delay
                   UIView.animate(withDuration: 0.2, delay: 0.22, options: [.curveEaseIn], animations: {
                       self.correctIncorrectImageV.alpha = 0.0
                   }, completion: nil)
               })
    }
    
    func updateIncorrect(){
        correctIncorrectImageV.alpha = 00
        correctIncorrectImageV.image = incorrectImage
        UIView.animate(withDuration: 0.2,delay: 0,options:[.curveEaseOut] ,animations: {
                   self.correctIncorrectImageV.alpha = 1.0
               }, completion: { _ in
                   // After the image view appears, hide it again after a delay
                   UIView.animate(withDuration: 0.2, delay: 0.22, options: [.curveEaseIn], animations: {
                       self.correctIncorrectImageV.alpha = 0.0
                   }, completion: nil)
               })
    }
    
    
    //MARK: - Actions
    
    @IBAction func PlayButtonTapped(_ sender: Any) {
        if isNewGame {
            self.isNewGame = false
            self.PlayButton.changeImageAnimated(toImage: self.playButtonImage, fromImage: self.startButtonImage)
            clickTapImpact()
            return
        }
        if isNewNote {
            self.currentNoteID = gameController.generateNextNoteID()
            print("play sound \(String(describing: currentNoteID))")

            if let cNoteID = currentNoteID {
                DispatchQueue.main.async{
                    self.playSound(noteAnswerID: cNoteID)
                    self.PlayButton.pulsate()
                    self.clickTapImpact()
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
                    self.clickTapImpact()
                }
            }
        }
    }
    
    @IBAction func AButtonTapped(_ sender: Any) {
        if isNewGame {
            self.playSound(noteAnswerID: 0)
            AButton.pulsateGuessed()
            self.clickTapImpact()
            return
        }
        if isNewNote {
            AButton.pulsateGuessed()
            self.clickTapImpact()
            return
        } else {
            if guessedNotesIDs.contains(0) {
                AButton.pulsateGuessed()
                self.clickTapImpact()
                return
            } else {
                let result = gameController.updateGameWith(noteAnswerID: 0)
                DispatchQueue.main.async {
                    self.playSound(noteAnswerID: 0)
                    if result.isCorrect {
                        self.updateCorrect()
                        self.updateProgressBar()
                        self.AButton.pulsate()
                        self.successfulTapFeedback()
                        self.PlayButton.changeImageAnimated(toImage: self.playButtonImage, fromImage: self.repeatButtonImage)
                        self.updateGameStats()
                        self.isNewNote = true
                        self.guessedNotesIDs = []
                    } else {
                        self.updateIncorrect()
                        self.wrongTapFeedback()
                        self.AButton.pulsateWrong()
                        if result.isGameOver {
                            self.endGame()
                        } else {
                            self.guessedNotesIDs.append(0)
                            self.updateGameStats()
                        }
                    }
                }
            }
                
        }
    }
    
    @IBAction func ASButtonTapped(_ sender: Any) {
        if isNewGame {
            self.playSound(noteAnswerID: 1)
            ASButton.pulsateGuessed()
            self.clickTapImpact()
            return
        }
        if isNewNote {
            ASButton.pulsateGuessed()
            self.clickTapImpact()
            return
        } else {
            if guessedNotesIDs.contains(1) {
                ASButton.pulsateGuessed()
                self.clickTapImpact()
                return
            } else {
                let result = gameController.updateGameWith(noteAnswerID: 1)
                DispatchQueue.main.async {
                    self.playSound(noteAnswerID: 1)
                    if result.isCorrect {
                        self.updateCorrect()
                        self.updateProgressBar()
                        self.ASButton.pulsate()
                        self.successfulTapFeedback()
                        self.PlayButton.changeImageAnimated(toImage: self.playButtonImage, fromImage: self.repeatButtonImage)
                        self.updateGameStats()
                        self.isNewNote = true
                        self.guessedNotesIDs = []
                    } else {
                        self.updateIncorrect()
                        self.wrongTapFeedback()
                        self.ASButton.pulsateWrong()
                        if result.isGameOver {
                            self.endGame()
                        } else {
                            self.guessedNotesIDs.append(1)
                            self.updateGameStats()
                        }
                    }
                }
            }
                
        }
    }
    @IBAction func BButtonTapped(_ sender: Any) {
        if isNewGame {
            self.playSound(noteAnswerID: 2)
            BButton.pulsateGuessed()
            clickTapImpact()
            return
        }
        if isNewNote {
            BButton.pulsateGuessed()
            clickTapImpact()
            return
        } else {
            if guessedNotesIDs.contains(2) {
                BButton.pulsateGuessed()
                clickTapImpact()
                return
            } else {
                let result = gameController.updateGameWith(noteAnswerID: 2)
                DispatchQueue.main.async {
                    self.playSound(noteAnswerID: 2)
                    if result.isCorrect {
                        self.updateCorrect()
                        self.successfulTapFeedback()
                        self.BButton.pulsate()
                        self.updateProgressBar()
                        self.updateGameStats()
                        self.isNewNote = true
                        self.guessedNotesIDs = []
                        self.PlayButton.changeImageAnimated(toImage: self.playButtonImage, fromImage: self.repeatButtonImage)
                    } else {
                        self.updateIncorrect()
                        self.wrongTapFeedback()
                        self.BButton.pulsateWrong()
                        if result.isGameOver {
                            self.endGame()
                        } else {
                            self.guessedNotesIDs.append(2)
                            self.updateGameStats()
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func CButtonTapped(_ sender: Any) {
        if isNewGame {
            self.playSound(noteAnswerID: 3)
            CButton.pulsateGuessed()
            clickTapImpact()
            return
        }
        if isNewNote {
            CButton.pulsateGuessed()
            clickTapImpact()
            return
        } else {
            if guessedNotesIDs.contains(3) {
                CButton.pulsateGuessed()
                clickTapImpact()
                return
            } else {
                let result = gameController.updateGameWith(noteAnswerID: 3)
                DispatchQueue.main.async {
                    self.playSound(noteAnswerID: 3)
                    if result.isCorrect {
                        self.updateCorrect()
                        self.successfulTapFeedback()
                        self.CButton.pulsate()
                        self.updateProgressBar()
                        self.updateGameStats()
                        self.isNewNote = true
                        self.guessedNotesIDs = []
                        self.PlayButton.changeImageAnimated(toImage: self.playButtonImage, fromImage: self.repeatButtonImage)
                    } else {
                        self.updateIncorrect()
                        self.wrongTapFeedback()
                        self.CButton.pulsateWrong()
                        if result.isGameOver {
                            self.endGame()
                        } else {
                            self.guessedNotesIDs.append(3)
                            self.updateGameStats()
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func CSButtonTapped(_ sender: Any) {
        if isNewGame {
            self.playSound(noteAnswerID: 4)
            CSButton.pulsateGuessed()
            clickTapImpact()
            return
        }
        if isNewNote {
            CSButton.pulsateGuessed()
            clickTapImpact()
            return
        } else {
            if guessedNotesIDs.contains(4) {
                CSButton.pulsateGuessed()
                clickTapImpact()
                return
            } else {
                let result = gameController.updateGameWith(noteAnswerID: 4)
                DispatchQueue.main.async {
                    self.playSound(noteAnswerID: 4)
                    if result.isCorrect {
                        self.updateCorrect()
                        self.successfulTapFeedback()
                        self.CSButton.pulsate()
                        self.updateProgressBar()
                        self.updateGameStats()
                        self.isNewNote = true
                        self.guessedNotesIDs = []
                        self.PlayButton.changeImageAnimated(toImage: self.playButtonImage, fromImage: self.repeatButtonImage)
                    } else {
                        self.updateIncorrect()
                        self.wrongTapFeedback()
                        self.CSButton.pulsateWrong()
                        if result.isGameOver {
                            self.endGame()
                        } else {
                            self.guessedNotesIDs.append(4)
                            self.updateGameStats()
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func DButtonTapped(_ sender: Any) {
        if isNewGame {
            self.playSound(noteAnswerID: 5)
            DButton.pulsateGuessed()
            clickTapImpact()
            return
        }
        if isNewNote {
            DButton.pulsateGuessed()
            clickTapImpact()
            return
        } else {
            if guessedNotesIDs.contains(5) {
                DButton.pulsateGuessed()
                clickTapImpact()
                return
            } else {
                let result = gameController.updateGameWith(noteAnswerID: 5)
                DispatchQueue.main.async {
                    self.playSound(noteAnswerID: 5)
                    if result.isCorrect {
                        self.updateCorrect()
                        self.successfulTapFeedback()
                        self.updateProgressBar()
                        self.updateGameStats()
                        self.DButton.pulsate()
                        self.isNewNote = true
                        self.guessedNotesIDs = []
                        self.PlayButton.changeImageAnimated(toImage: self.playButtonImage, fromImage: self.repeatButtonImage)
                    } else {
                        self.updateIncorrect()
                        self.wrongTapFeedback()
                        self.DButton.pulsateWrong()
                        if result.isGameOver {
                            self.endGame()
                        } else {
                            self.guessedNotesIDs.append(5)
                            self.updateGameStats()
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func DSButtonTapped(_ sender: Any) {
        if isNewGame {
            self.playSound(noteAnswerID: 6)
            DSButton.pulsateGuessed()
            clickTapImpact()
            return
        }
        if isNewNote {
            DSButton.pulsateGuessed()
            clickTapImpact()
            return
        } else {
            if guessedNotesIDs.contains(6) {
                DSButton.pulsateGuessed()
                clickTapImpact()
                return
            } else {
                let result = gameController.updateGameWith(noteAnswerID: 6)
                DispatchQueue.main.async {
                    self.playSound(noteAnswerID: 6)
                    if result.isCorrect {
                        self.updateCorrect()
                        self.successfulTapFeedback()
                        self.updateProgressBar()
                        self.updateGameStats()
                        self.DSButton.pulsate()
                        self.isNewNote = true
                        self.guessedNotesIDs = []
                        self.PlayButton.changeImageAnimated(toImage: self.playButtonImage, fromImage: self.repeatButtonImage)
                    } else {
                        self.updateIncorrect()
                        self.wrongTapFeedback()
                        self.DSButton.pulsateWrong()
                        if result.isGameOver {
                            self.endGame()
                        } else {
                            self.guessedNotesIDs.append(6)
                            self.updateGameStats()
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func EButtonTapped(_ sender: Any) {
        if isNewGame {
            self.playSound(noteAnswerID: 7)
            EButton.pulsateGuessed()
            clickTapImpact()
            return
        }
        if isNewNote {
            EButton.pulsateGuessed()
            clickTapImpact()
            return
        } else {
            if guessedNotesIDs.contains(7) {
                EButton.pulsateGuessed()
                clickTapImpact()
                return
            } else {
                let result = gameController.updateGameWith(noteAnswerID: 7)
                DispatchQueue.main.async {
                    self.playSound(noteAnswerID: 7)
                    if result.isCorrect {
                        self.updateCorrect()
                        self.successfulTapFeedback()
                        self.updateProgressBar()
                        self.updateGameStats()
                        self.EButton.pulsate()
                        self.isNewNote = true
                        self.guessedNotesIDs = []
                        self.PlayButton.changeImageAnimated(toImage: self.playButtonImage, fromImage: self.repeatButtonImage)
                    } else {
                        self.updateIncorrect()
                        self.wrongTapFeedback()
                        self.EButton.pulsateWrong()
                        if result.isGameOver {
                            self.endGame()
                        } else {
                            self.guessedNotesIDs.append(7)
                            self.updateGameStats()
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func FButtonTapped(_ sender: Any) {
        if isNewGame {
            self.playSound(noteAnswerID: 8)
            FButton.pulsateGuessed()
            clickTapImpact()
            return
        }
        if isNewNote {
            FButton.pulsateGuessed()
            clickTapImpact()
            return
        } else {
            if guessedNotesIDs.contains(8) {
                FButton.pulsateGuessed()
                clickTapImpact()
                return
            } else {
                let result = gameController.updateGameWith(noteAnswerID: 8)
                DispatchQueue.main.async {
                    self.playSound(noteAnswerID: 8)
                    if result.isCorrect {
                        self.updateCorrect()
                        self.successfulTapFeedback()
                        self.updateProgressBar()
                        self.updateGameStats()
                        self.FButton.pulsate()
                        self.isNewNote = true
                        self.guessedNotesIDs = []
                        self.PlayButton.changeImageAnimated(toImage: self.playButtonImage, fromImage: self.repeatButtonImage)
                    } else {
                        self.updateIncorrect()
                        self.wrongTapFeedback()
                        self.FButton.pulsateWrong()
                        if result.isGameOver {
                            self.endGame()
                        } else {
                            self.guessedNotesIDs.append(8)
                            self.updateGameStats()
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func FSButtonTapped(_ sender: Any) {
        if isNewGame {
            self.playSound(noteAnswerID: 9)
            FSButton.pulsateGuessed()
            clickTapImpact()
            return
        }
        if isNewNote {
            FSButton.pulsateGuessed()
            clickTapImpact()
            return
        } else {
            if guessedNotesIDs.contains(9) {
                FSButton.pulsateGuessed()
                clickTapImpact()
                return
            } else {
                let result = gameController.updateGameWith(noteAnswerID: 9)
                DispatchQueue.main.async {
                    self.playSound(noteAnswerID: 9)
                    if result.isCorrect {
                        self.updateCorrect()
                        self.successfulTapFeedback()
                        self.updateProgressBar()
                        self.updateGameStats()
                        self.FSButton.pulsate()
                        self.isNewNote = true
                        self.guessedNotesIDs = []
                        self.PlayButton.changeImageAnimated(toImage: self.playButtonImage, fromImage: self.repeatButtonImage)
                    } else {
                        self.updateIncorrect()
                        self.wrongTapFeedback()
                        self.FSButton.pulsateWrong()
                        if result.isGameOver {
                            self.endGame()
                        } else {
                            self.guessedNotesIDs.append(9)
                            self.updateGameStats()
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func GButtonTapped(_ sender: Any) {
        if isNewGame {
            self.playSound(noteAnswerID: 10)
            GButton.pulsateGuessed()
            clickTapImpact()
            return
        }
        if isNewNote {
            GButton.pulsateGuessed()
            clickTapImpact()
            return
        } else {
            if guessedNotesIDs.contains(10) {
                GButton.pulsateGuessed()
                clickTapImpact()
                return
            } else {
                let result = gameController.updateGameWith(noteAnswerID: 10)
                DispatchQueue.main.async {
                    self.playSound(noteAnswerID: 10)
                    if result.isCorrect {
                        self.updateCorrect()
                        self.successfulTapFeedback()
                        self.updateProgressBar()
                        self.updateGameStats()
                        self.GButton.pulsate()
                        self.isNewNote = true
                        self.guessedNotesIDs = []
                        self.PlayButton.changeImageAnimated(toImage: self.playButtonImage, fromImage: self.repeatButtonImage)
                    } else {
                        self.updateIncorrect()
                        self.wrongTapFeedback()
                        self.GButton.pulsateWrong()
                        if result.isGameOver {
                            self.endGame()
                        } else {
                            self.guessedNotesIDs.append(10)
                            self.updateGameStats()
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func GSButtonTapped(_ sender: Any) {
        if isNewGame {
            self.playSound(noteAnswerID: 11)
            GSButton.pulsateGuessed()
            clickTapImpact()
            return
        }
        if isNewNote {
            GSButton.pulsateGuessed()
            clickTapImpact()
            return
        } else {
            if guessedNotesIDs.contains(11) {
                GSButton.pulsateGuessed()
                clickTapImpact()
                return
            } else {
                let result = gameController.updateGameWith(noteAnswerID: 11)
                DispatchQueue.main.async {
                    self.playSound(noteAnswerID: 11)
                    if result.isCorrect {
                        self.updateCorrect()
                        self.successfulTapFeedback()
                        self.updateProgressBar()
                        self.updateGameStats()
                        self.GSButton.pulsate()
                        self.isNewNote = true
                        self.guessedNotesIDs = []
                        self.PlayButton.changeImageAnimated(toImage: self.playButtonImage, fromImage: self.repeatButtonImage)
                    } else {
                        self.updateIncorrect()
                        self.wrongTapFeedback()
                        self.GSButton.pulsateWrong()
                        if result.isGameOver {
                            self.endGame()
                        } else {
                            self.guessedNotesIDs.append(11)
                            self.updateGameStats()
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func HomeButtonTapped(_ sender: Any) {
        HomeButton.pulsate()
        clickTapImpact()
        showFinishedGamePopup(isPaused: true)
    }
    
    //MARK: - CRUD Functions
    
    func showFinishedGamePopup(isPaused:Bool){
        let popUpView = FinishedGamePopUp()
        popUpView.isPaused = isPaused
        popUpView.delegate = self
        popUpView.game = gameController.currentGame
        popUpView.instrument = self.instrument
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
    
}

extension MultiplayerVirtuosoViewController: UIAdaptivePresentationControllerDelegate {
    
    func presentationControllerShouldDismiss(_ presentationController: UIPresentationController) -> Bool {
        //put logic gate here to check if game is over
        return false
    }
}
