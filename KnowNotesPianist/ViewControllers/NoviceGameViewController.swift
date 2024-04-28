//
//  NoviceGameViewController.swift
//  KnowNotesPianist
//
//  Created by Wylan L Neely on 3/20/24.
//

import UIKit
import AVFoundation

class NoviceGameViewController: UIViewController, FinishedPopUpDelegate {

    
    var gameController = GameController(gameType: .Novice)
    var lifeImageController = LifeImages()
    var achievementsController = AchievementesController()
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
    private let noviceString =  NSLocalizedString("Novice",comment: "")
    //MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtons()
        setUpProgressBar()
        setUpGradientColorLabel()
        updateGameStats()
        self.presentationController?.delegate = self
        setUpAudio()
        setupLanguageLocalization()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    //MARK: SetUp
    func setupButtons(){
        AButton.layer.shadowColor = UIColor.greenShadow.cgColor
        AButton.layer.shadowOffset = CGSize(width: 1.0, height: 4.0)
        AButton.layer.shadowRadius = 8
        AButton.layer.shadowOpacity = 0.6
        CButton.layer.shadowColor = UIColor.blueShadow.cgColor
        CButton.layer.shadowOffset = CGSize(width: 1.0, height: 4.0)
        CButton.layer.shadowRadius = 8
        CButton.layer.shadowOpacity = 0.6
        GButton.layer.shadowColor = UIColor.pinkShadow.cgColor
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
            ScoreLabel.gradientColors = [UIColor.darkBlue.cgColor, UIColor.systemRed.cgColor]
        case "Spanish":
            ScoreLabel.gradientColors = [UIColor.systemBlue.cgColor, UIColor.systemCyan.cgColor]
        case "Korean":
            ScoreLabel.gradientColors = [UIColor.darkBlue.cgColor, UIColor.systemRed.cgColor]
        case "Japanese":
            ScoreLabel.gradientColors = [UIColor.systemRed.cgColor, UIColor.red.cgColor]
        case "German":
            ScoreLabel.gradientColors = [UIColor.systemYellow.cgColor, UIColor.systemRed.cgColor]
        case "Russian":
            ScoreLabel.gradientColors = [UIColor.darkBlue.cgColor, UIColor.systemRed.cgColor]
        default:
            ScoreLabel.gradientColors = [UIColor.systemBlue.cgColor, UIColor.systemPurple.cgColor]
        }
        
    }
    
    //MARK: - Audio
    var soundController: SoundController = SoundController(soundPack: BasicPianoPack, gameType: .Novice)
   // var soundPack: SoundPack = FreePianoPack
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
    
    func setupLanguageLocalization(){
        noviceLabel.text = noviceString
    }
    
    //MARK: - Outlets
    
    @IBOutlet weak var HomeButton: UIButton!
    @IBOutlet weak var AButton: UIButton!
    @IBOutlet weak var CButton: UIButton!
    @IBOutlet weak var GButton: UIButton!
    @IBOutlet weak var PlayButton: UIButton!
    @IBOutlet weak var CircularProgressView: CircularProgressBar!
    @IBOutlet weak var lifeImage: UIImageView!
    @IBOutlet weak var ScoreLabel: GradientLabel!
    @IBOutlet weak var noviceLabel: UILabel!
    
    //MARK: - Circular Progress Bar
    
    func setUpProgressBar(){
        CircularProgressView.labelSize = 60
        CircularProgressView.safePercent = 100
        CircularProgressView.lineWidth = 20
        CircularProgressView.safePercent = 100
        //CircularProgressView.layer.cornerRadius = CircularProgressView.frame.size.width/2
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
    
        let totalGroupRounds: Double = 12.00
        var currentRound: Double = 1.00
    
    
    //MARK: - Actions
    
    @IBAction func PlayButtonTapped(_ sender: Any) {
        if isNewGame {
            self.isNewGame = false
            self.PlayButton.changeImageAnimated(toImage: self.playButtonImage, fromImage: self.startButtonImage)
            hapticGenerator.notificationOccurred(.success)
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
                }
                    self.PlayButton.pulsate()
                    self.mediumImpact.impactOccurred()
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
                    updateProgressBar()
                    AButton.pulsate()
                    hapticGenerator.notificationOccurred(.success)
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
    @IBAction func CButtonTapped(_ sender: Any) {
        if isNewGame {
            self.playSound(noteAnswerID: 1)
            CButton.pulsateGuessed()
            guessedImpact.impactOccurred()
            return
        }
        if isNewNote {
            CButton.pulsateGuessed()
            guessedImpact.impactOccurred()
            return
        } else {
            if guessedNotesIDs.contains(1) {
                CButton.pulsateGuessed()
                guessedImpact.impactOccurred()
            } else {
                let result = gameController.updateGameWith(noteAnswerID: 1)
                self.playSound(noteAnswerID: 1)
                if result.isCorrect {
                    hapticGenerator.notificationOccurred(.success)
                    CButton.pulsate()
                    self.updateProgressBar()
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
                        self.guessedNotesIDs.append(1)
                        self.updateGameStats()
                    }
                }
            }
        }
    }
    @IBAction func GButtonTapped(_ sender: Any) {
        if isNewGame {
            self.playSound(noteAnswerID: 2)
            GButton.pulsateGuessed()
            guessedImpact.impactOccurred()
            return
        }
        if isNewNote {
            GButton.pulsateGuessed()
            guessedImpact.impactOccurred()
            return
        } else {
            if guessedNotesIDs.contains(2) {
                GButton.pulsateGuessed()
                guessedImpact.impactOccurred()
            } else {
                let result = gameController.updateGameWith(noteAnswerID: 2)
                self.playSound(noteAnswerID: 2)
                if result.isCorrect {
                    self.updateProgressBar()
                    self.updateGameStats()
                    GButton.pulsate()
                    hapticGenerator.notificationOccurred(.success)
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
                        self.guessedNotesIDs.append(2)
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
    
    // MARK: - Navigation
    
    func checkContinueGame(){
        //13
        if currentRound == 13 {
            //unlock gameState using AchievementsController
            achievementsController.unlockFreePianoRegular()
            self.performSegue(withIdentifier: "toContinueRegular", sender: self)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let dVC = segue.destination as? RegularGameViewController else { return }
        //change gametype then send to next VC
        let currentGame = gameController.currentGame
        currentGame.gameType = .Regular
        dVC.gameController.setGame(game: currentGame)
        dVC.instrument = self.instrument
    }
    

}

extension NoviceGameViewController: UIAdaptivePresentationControllerDelegate {
    
    func presentationControllerShouldDismiss(_ presentationController: UIPresentationController) -> Bool {
        //put logic gate here
        return false
    }
}
