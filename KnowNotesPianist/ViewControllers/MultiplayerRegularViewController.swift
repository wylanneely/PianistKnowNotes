//
//  MultiplayerRegularViewController.swift
//  KnowNotesPianist
//
//  Created by Wylan L Neely on 2/5/25.
//

import UIKit
import AVFoundation

class MultiplayerRegularViewController:UIViewController, FinishedPopUpDelegate {
    
    var gameController = GameController(gameType: .Regular)
    var lifeImageController = LifeImages()
    var achievementsController = AchievementesController()
    var instrument: InstrumentType = .BasicPiano


    var currentNoteID: Int?
    var isNewGame: Bool = true
    var isNewNote: Bool = true
    var guessedNotesIDs = [Int]()

    // variables to help transition last Image for button
    let startButtonImage = UIImage(named: "StartGameButton")
    let playButtonImage = UIImage(named: "PlayButton")
    let repeatButtonImage = UIImage(named: "RepeatButton")
    
    //Language localization
    private var language: String = NSLocalizedString("AppLanguage", comment: "to help adjust certain views/settings")
    private let regularString =  NSLocalizedString("Regular",comment: "")


    //MARK: - Override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtons()
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
    var soundController: SoundController = SoundController(soundPack: BasicPianoPack, gameType: .Regular)
    
    func setSoundPack(){
        switch instrument {
        case .BasicPiano:
            soundController = SoundController(soundPack: BasicPianoPack, gameType: .Regular)
        case .GrandPiano:
           soundController = SoundController(soundPack: GrandPianoPack, gameType: .Regular)
        case .AcousticGuitar:
            soundController = SoundController(soundPack: AGuitarMajorPack, gameType: .Regular)
        case .Keyboard:
            soundController = SoundController(soundPack: KeyboardPack, gameType: .Regular)
        case .Violin:
            soundController = SoundController(soundPack: ViolinPack, gameType: .Regular)
        case .AcousticMinor:
            soundController = SoundController(soundPack: AGuitarMinorPack, gameType: .Regular)
        }
    }
    
    var player: AVAudioPlayer!
    
    func setUpAudio(){
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
        } catch(let error) {
            print(error.localizedDescription)
        }
    }
    
    func playSound(noteAnswerID:Int){
        if let soundURL = soundController.returnSoundPathFrom(noteID: noteAnswerID) {
           player = try! AVAudioPlayer(contentsOf: soundURL)
            player!.play()
        }
    }
    
    //MARK: - SetUp
    
    func setupButtons(){
        AButton.layer.shadowColor = UIColor.regularShadow.cgColor
        AButton.layer.shadowOffset = CGSize(width: 1.0, height: 4.0)
        AButton.layer.shadowRadius = 8
        AButton.layer.shadowOpacity = 0.6
        CButton.layer.shadowColor = UIColor.regularShadow.cgColor
        CButton.layer.shadowOffset = CGSize(width: 1.0, height: 4.0)
        CButton.layer.shadowRadius = 8
        CButton.layer.shadowOpacity = 0.6
        DButton.layer.shadowColor = UIColor.regularShadow.cgColor
        DButton.layer.shadowOffset = CGSize(width: 1.0, height: 4.0)
        DButton.layer.shadowRadius = 8
        DButton.layer.shadowOpacity = 0.6
        EButton.layer.shadowColor = UIColor.regularShadow.cgColor
        EButton.layer.shadowOffset = CGSize(width: 1.0, height: 4.0)
        EButton.layer.shadowRadius = 8
        EButton.layer.shadowOpacity = 0.6
        GButton.layer.shadowColor = UIColor.regularShadow.cgColor
        GButton.layer.shadowOffset = CGSize(width: 1.0, height: 4.0)
        GButton.layer.shadowRadius = 8
        GButton.layer.shadowOpacity = 0.6
        PlayButton.layer.shadowColor = UIColor.regularShadow.cgColor
        PlayButton.layer.shadowOffset = CGSize(width: 1.0, height: 3.0)
        PlayButton.layer.shadowRadius = 6
        PlayButton.layer.shadowOpacity = 0.6
        HomeButton.layer.shadowColor = UIColor.regularShadow.cgColor
        HomeButton.layer.shadowOffset = CGSize(width: 1.0, height: 3.0)
        HomeButton.layer.shadowRadius = 6
        HomeButton.layer.shadowOpacity = 0.6
    }
    
    func setUpGradientColorLabel(){
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
    
    func setUpLanguageLocalization(){
        regularLabel.text = regularString
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
    @IBOutlet weak var AButton: UIButton!
    @IBOutlet weak var CButton: UIButton!
    @IBOutlet weak var DButton: UIButton!
    @IBOutlet weak var EButton: UIButton!
    @IBOutlet weak var GButton: UIButton!
    @IBOutlet weak var PlayButton: UIButton!
    @IBOutlet weak var lifeImage: UIImageView!
    @IBOutlet weak var CircularProgressView: CircularProgressBar!
    @IBOutlet weak var ScoreLabel: GradientLabel!
    @IBOutlet weak var regularLabel: UILabel!
    @IBOutlet weak var correctIncorrectImageV: UIImageView!

    
    //MARK: - Circular Progress Bar
    
    func setUpProgressBar(){
        CircularProgressView.labelSize = 60
        CircularProgressView.safePercent = 100
        CircularProgressView.lineWidth = 20
        CircularProgressView.safePercent = 100
      //  CircularProgressView.layer.cornerRadius = CircularProgressView.frame.size.width/2
        CircularProgressView.clipsToBounds = true
        CircularProgressView.layer.shadowColor = UIColor.regularShadow.cgColor
        CircularProgressView.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
        CircularProgressView.layer.shadowRadius = 8
        CircularProgressView.layer.shadowOpacity = 0.6
    }
    
    func updateProgressBar(){
        let progress = currentRound/totalGroupRounds
        CircularProgressView.setProgress(to: progress , withAnimation: false)
        self.currentRound = currentRound + 1.0
        checkContinueGame()
    }
    
    func restartProgressBar(){
        self.currentRound = 0
        CircularProgressView.setProgress(to: currentRound, withAnimation: false)
        checkContinueGame()
    }
    
        let totalGroupRounds: Double = 20.00
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
    @IBAction func CButtonTapped(_ sender: Any) {
        if isNewGame {
            self.playSound(noteAnswerID: 1)
            CButton.pulsateGuessed()
            clickTapImpact()
            return
        }
        if isNewNote {
            CButton.pulsateGuessed()
            clickTapImpact()
            return
        } else {
            if guessedNotesIDs.contains(1) {
                CButton.pulsateGuessed()
                clickTapImpact()
                return
            } else {
                let result = gameController.updateGameWith(noteAnswerID: 1)
                DispatchQueue.main.async {
                    self.playSound(noteAnswerID: 1)
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
                            self.guessedNotesIDs.append(1)
                            self.updateGameStats()
                        }
                    }
                }
            }
        }
    }
    @IBAction func DButtonTapped(_ sender: Any) {
        if isNewGame {
            self.playSound(noteAnswerID: 2)
            DButton.pulsateGuessed()
            clickTapImpact()
            return
        }
        if isNewNote {
            DButton.pulsateGuessed()
            clickTapImpact()
            return
        } else {
            if guessedNotesIDs.contains(2) {
                DButton.pulsateGuessed()
                clickTapImpact()
                return
            } else {
                let result = gameController.updateGameWith(noteAnswerID: 2)
                DispatchQueue.main.async {
                    self.playSound(noteAnswerID: 2)
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
                            self.guessedNotesIDs.append(2)
                            self.updateGameStats()
                        }
                    }
                }
            }
        }
    }
    @IBAction func EButtonTapped(_ sender: Any) {
        if isNewGame {
            self.playSound(noteAnswerID: 3)
            EButton.pulsateGuessed()
            clickTapImpact()
            return
        }
        if isNewNote {
            EButton.pulsateGuessed()
            clickTapImpact()
            return
        } else {
            if guessedNotesIDs.contains(3) {
                EButton.pulsateGuessed()
                clickTapImpact()
                return
            } else {
                let result = gameController.updateGameWith(noteAnswerID: 3)
                DispatchQueue.main.async {
                    self.playSound(noteAnswerID: 3)
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
                            self.guessedNotesIDs.append(3)
                            self.updateGameStats()
                        }
                    }
                }
            }
        }
    }
    @IBAction func GButtonTapped(_ sender: Any) {
        if isNewGame {
            self.playSound(noteAnswerID: 4)
            GButton.pulsateGuessed()
            clickTapImpact()
            return
        }
        if isNewNote {
            GButton.pulsateGuessed()
            clickTapImpact()
            return
        } else {
            if guessedNotesIDs.contains(4) {
                GButton.pulsateGuessed()
                clickTapImpact()
                return
            } else {
                let result = gameController.updateGameWith(noteAnswerID: 4)
                DispatchQueue.main.async {
                    self.playSound(noteAnswerID: 4)
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
                            self.guessedNotesIDs.append(4)
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
        popUpView.instrument = self.instrument
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
        lifeImage.image = image
    }
    
    func endGame(){
        updateGameStats()
        showFinishedGamePopup(isPaused: false)
    }
    
    func restartGame(){
        restartProgressBar()
        gameController.restartGame()
        self.guessedNotesIDs = []
        updateGameStats()
        self.isNewGame = true
        self.isNewNote = true
        let currentImage = self.PlayButton.imageView?.image
        self.PlayButton.changeImageAnimated(toImage: startButtonImage, fromImage: currentImage)
    }
    
    //MARK: - Delegates
    
    func finishedPopUpRestartedGame() {
        restartGame()
    }
    
    // MARK: - Navigation
     
    func checkContinueGame(){
        //21
        if currentRound == 21 {
            switch instrument {
            case .BasicPiano:
                achievementsController.unlockFreePianoPianist()
            case .GrandPiano:
                achievementsController.unlockGrandPianoPianist()
            case .AcousticGuitar:
                achievementsController.unlockAcousticPianist()
            case .Keyboard:
                achievementsController.unlockKeyboardPianist()
            case .Violin:
                achievementsController.unlockViolinPianist()
            case .AcousticMinor:
                achievementsController.unlockAcousticMinPianist()
            }
            self.performSegue(withIdentifier: "toContinuePianist", sender: self)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let dVC = segue.destination as? PianistGameViewController else { return }
        //change gametype then send to next VC
        let currentGame = gameController.currentGame
        currentGame.gameType = .Pianist
        dVC.gameController.setGame(game: currentGame)
        dVC.instrument = self.instrument
    }
    

}

extension MultiplayerRegularViewController: UIAdaptivePresentationControllerDelegate {
    
    func presentationControllerShouldDismiss(_ presentationController: UIPresentationController) -> Bool {
        //put logic gate here
        return false
    }
}
