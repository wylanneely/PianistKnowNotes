//
//  PianistGameViewController.swift
//  KnowNotesPianist
//
//  Created by Wylan L Neely on 3/20/24.
//

import UIKit
import AVFoundation

class PianistGameViewController: UIViewController {
    
    var gameController = GameController(gameType: .Pianist)
    var lifeImageController = LifeImages()
    
    var currentNoteID: Int?
    
    var isNewNote: Bool = true
    var guessedNotesIDs = [Int]()
    
    let mediumImpact = UIImpactFeedbackGenerator(style: .medium)
    let heavyImpact = UIImpactFeedbackGenerator(style: .heavy)
    let guessedImpact = UIImpactFeedbackGenerator(style: .soft)

    //MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpButtons()
        //updateGameStats()
        setUpProgressBar()
        setUpGradientColorLabel()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    //MARK: - Audio
    var soundController: SoundController = SoundController(soundPack: FreePianoPack, gameType: .Pianist)
   // var soundPack: SoundPack = FreePianoPack
    var player: AVAudioPlayer!
    
    func playSound(noteAnswerID:Int){
        if let soundURL = soundController.returnSoundPathFrom(noteID: noteAnswerID) {
           player = try! AVAudioPlayer(contentsOf: soundURL)
            player!.play()
        }
    }
    
    //MARK: - SetUP
    
    func setUpButtons(){
        AButton.layer.shadowColor = UIColor.black.cgColor
        AButton.layer.shadowOffset = CGSize(width: 1.3, height: 3.0)
        AButton.layer.shadowRadius = 8
        AButton.layer.shadowOpacity = 0.6
        BButton.layer.shadowColor = UIColor.black.cgColor
        BButton.layer.shadowOffset = CGSize(width: 1.0, height: 4.0)
        BButton.layer.shadowRadius = 8
        BButton.layer.shadowOpacity = 0.6
        CButton.layer.shadowColor = UIColor.black.cgColor
        CButton.layer.shadowOffset = CGSize(width: 1.0, height: 4.0)
        CButton.layer.shadowRadius = 8
        CButton.layer.shadowOpacity = 0.6
        DButton.layer.shadowColor = UIColor.black.cgColor
        DButton.layer.shadowOffset = CGSize(width: 1.0, height: 4.0)
        DButton.layer.shadowRadius = 8
        DButton.layer.shadowOpacity = 0.6
        EButton.layer.shadowColor = UIColor.black.cgColor
        EButton.layer.shadowOffset = CGSize(width: 1.0, height: 4.0)
        EButton.layer.shadowRadius = 8
        EButton.layer.shadowOpacity = 0.6
        FButton.layer.shadowColor = UIColor.black.cgColor
        FButton.layer.shadowOffset = CGSize(width: 1.3, height: 3.0)
        FButton.layer.shadowRadius = 8
        FButton.layer.shadowOpacity = 0.6
        GButton.layer.shadowColor = UIColor.black.cgColor
        GButton.layer.shadowOffset = CGSize(width: 1.0, height: 4.0)
        GButton.layer.shadowRadius = 8
        GButton.layer.shadowOpacity = 0.6
        PlayButton.layer.shadowColor = UIColor.black.cgColor
        PlayButton.layer.shadowOffset = CGSize(width: 1.0, height: 4.0)
        PlayButton.layer.shadowRadius = 8
        PlayButton.layer.shadowOpacity = 0.6
        HomeButton.layer.shadowColor = UIColor.black.cgColor
        HomeButton.layer.shadowOffset = CGSize(width: 1.0, height: 4.0)
        HomeButton.layer.shadowRadius = 8
        HomeButton.layer.shadowOpacity = 0.6
    }
    
    func setUpGradientColorLabel(){
        ScoreLabel.gradientColors = [UIColor.systemBlue.cgColor, UIColor.systemPurple.cgColor]
    }

    //MARK: - Outlets
    
    @IBOutlet weak var HomeButton: UIButton!
    @IBOutlet weak var AButton: UIButton!
    @IBOutlet weak var BButton: UIButton!
    @IBOutlet weak var CButton: UIButton!
    @IBOutlet weak var DButton: UIButton!
    @IBOutlet weak var EButton: UIButton!
    @IBOutlet weak var FButton: UIButton!
    @IBOutlet weak var GButton: UIButton!
    @IBOutlet weak var PlayButton: UIButton!
    @IBOutlet weak var CircularProgressView: CircularProgressBar!
    @IBOutlet weak var ScoreLabel: GradientLabel!
    @IBOutlet weak var lifeImage: UIImageView!
    
    //MARK: - Circular Progress Bar
    
    func setUpProgressBar(){
           CircularProgressView.labelSize = 60
        CircularProgressView.safePercent = 100
        CircularProgressView.lineWidth = 20
        CircularProgressView.safePercent = 100
        CircularProgressView.layer.cornerRadius = CircularProgressView.frame.size.width/2
        CircularProgressView.clipsToBounds = true
       }
    func updateProgressBar(){
           let progress = currentRound/totalGroupRounds
           CircularProgressView.setProgress(to: progress , withAnimation: false)
           self.currentRound = currentRound + 1.0
        checkContinueGame()
       }
    
        let totalGroupRounds: Double = 28.00
        var currentRound: Double = 1.00
    
    
    //MARK: - Actions
    
    @IBAction func PlayButtonTapped(_ sender: Any) {
        if isNewNote {
            self.currentNoteID = gameController.generateNextNoteID()
            print("play sound \(String(describing: currentNoteID))")
            if let cNoteID = currentNoteID {
                DispatchQueue.main.async{
                    self.playSound(noteAnswerID: cNoteID)
                    self.PlayButton.pulsate()
                    self.mediumImpact.impactOccurred()
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
                    mediumImpact.impactOccurred()
                    updateProgressBar()
                    self.updateGameStats()
                    self.isNewNote = true
                    self.guessedNotesIDs = []
                } else {
                    if result.isGameOver {
                        heavyImpact.impactOccurred()
                        AButton.pulsateWrong()
                        self.endGame()
                    } else {
                        heavyImpact.impactOccurred()
                        AButton.pulsateWrong()
                        self.guessedNotesIDs.append(0)
                        self.updateGameStats()
                    }
                }
            }
        }
    }
    
    @IBAction func BButtonTapped(_ sender: Any) {
        if isNewNote {
            BButton.pulsateGuessed()
            guessedImpact.impactOccurred()
            return
        } else {
            if guessedNotesIDs.contains(1) {
                BButton.pulsateGuessed()
                guessedImpact.impactOccurred()
            } else {
                let result = gameController.updateGameWith(noteAnswerID: 1)
                self.playSound(noteAnswerID: 1)
                if result.isCorrect {
                    BButton.pulsate()
                    mediumImpact.impactOccurred()
                    updateProgressBar()
                    self.updateGameStats()
                    self.isNewNote = true
                    self.guessedNotesIDs = []
                } else {
                    if result.isGameOver {
                        heavyImpact.impactOccurred()
                        BButton.pulsateWrong()
                        self.endGame()
                    } else {
                        heavyImpact.impactOccurred()
                        BButton.pulsateWrong()
                        self.guessedNotesIDs.append(1)
                        self.updateGameStats()
                    }
                }
            }
        }

    }
    @IBAction func CButtonTapped(_ sender: Any) {
        if isNewNote {
            CButton.pulsateGuessed()
            guessedImpact.impactOccurred()
            return
        } else {
            if guessedNotesIDs.contains(2) {
                CButton.pulsateGuessed()
                guessedImpact.impactOccurred()
            } else {
                let result = gameController.updateGameWith(noteAnswerID: 2)
                self.playSound(noteAnswerID: 2)
                if result.isCorrect {
                    CButton.pulsate()
                    mediumImpact.impactOccurred()
                    updateProgressBar()
                    self.updateGameStats()
                    self.isNewNote = true
                    self.guessedNotesIDs = []
                } else {
                    if result.isGameOver {
                        heavyImpact.impactOccurred()
                        CButton.pulsateWrong()
                        self.endGame()
                    } else {
                        heavyImpact.impactOccurred()
                        CButton.pulsateWrong()
                        self.guessedNotesIDs.append(2)
                        self.updateGameStats()
                    }
                }
            }
        }
    }
    @IBAction func DButtonTapped(_ sender: Any) {
        if isNewNote {
            DButton.pulsateGuessed()
            guessedImpact.impactOccurred()
            return
        } else {
            if guessedNotesIDs.contains(3) {
                DButton.pulsateGuessed()
                guessedImpact.impactOccurred()
            } else {
                let result = gameController.updateGameWith(noteAnswerID: 3)
                self.playSound(noteAnswerID: 3)
                if result.isCorrect {
                    DButton.pulsate()
                    mediumImpact.impactOccurred()
                    updateProgressBar()
                    self.updateGameStats()
                    self.isNewNote = true
                    self.guessedNotesIDs = []
                } else {
                    if result.isGameOver {
                        heavyImpact.impactOccurred()
                        DButton.pulsateWrong()
                        self.endGame()
                    } else {
                        heavyImpact.impactOccurred()
                        DButton.pulsateWrong()
                        self.guessedNotesIDs.append(3)
                        self.updateGameStats()
                    }
                }
            }
        }
    }
    @IBAction func EButtonTapped(_ sender: Any) {
        if isNewNote {
            EButton.pulsateGuessed()
            guessedImpact.impactOccurred()
            return
        } else {
            if guessedNotesIDs.contains(4) {
                EButton.pulsateGuessed()
                guessedImpact.impactOccurred()
            } else {
                let result = gameController.updateGameWith(noteAnswerID: 4)
                self.playSound(noteAnswerID: 4)
                if result.isCorrect {
                    EButton.pulsate()
                    mediumImpact.impactOccurred()
                    updateProgressBar()
                    self.updateGameStats()
                    self.isNewNote = true
                    self.guessedNotesIDs = []
                } else {
                    if result.isGameOver {
                        heavyImpact.impactOccurred()
                        EButton.pulsateWrong()
                        self.endGame()
                    } else {
                        heavyImpact.impactOccurred()
                        EButton.pulsateWrong()
                        self.guessedNotesIDs.append(4)
                        self.updateGameStats()
                    }
                }
            }
        }
    }
    @IBAction func FButtonTapped(_ sender: Any) {
        if isNewNote {
            FButton.pulsateGuessed()
            guessedImpact.impactOccurred()
            return
        } else {
            if guessedNotesIDs.contains(5) {
                FButton.pulsateGuessed()
                guessedImpact.impactOccurred()
            } else {
                let result = gameController.updateGameWith(noteAnswerID: 5)
                self.playSound(noteAnswerID: 5)
                if result.isCorrect {
                    FButton.pulsate()
                    mediumImpact.impactOccurred()
                    updateProgressBar()
                    self.updateGameStats()
                    self.isNewNote = true
                    self.guessedNotesIDs = []
                } else {
                    if result.isGameOver {
                        heavyImpact.impactOccurred()
                        FButton.pulsateWrong()
                        self.endGame()
                    } else {
                        heavyImpact.impactOccurred()
                        FButton.pulsateWrong()
                        self.guessedNotesIDs.append(5)
                        self.updateGameStats()
                    }
                }
            }
        }
    }
    @IBAction func GButtonTapped(_ sender: Any) {
        if isNewNote {
            GButton.pulsateGuessed()
            guessedImpact.impactOccurred()
            return
        } else {
            if guessedNotesIDs.contains(6) {
                GButton.pulsateGuessed()
                guessedImpact.impactOccurred()
            } else {
                let result = gameController.updateGameWith(noteAnswerID: 6)
                self.playSound(noteAnswerID: 6)
                if result.isCorrect {
                    GButton.pulsate()
                    mediumImpact.impactOccurred()
                    updateProgressBar()
                    self.updateGameStats()
                    self.isNewNote = true
                    self.guessedNotesIDs = []
                } else {
                    if result.isGameOver {
                        heavyImpact.impactOccurred()
                        GButton.pulsateWrong()
                        self.endGame()
                    } else {
                        heavyImpact.impactOccurred()
                        GButton.pulsateWrong()
                        self.guessedNotesIDs.append(6)
                        self.updateGameStats()
                    }
                }
            }
        }
    }
    
    @IBAction func HomeButtonTapped(_ sender: Any) {
        restartGame()
        HomeButton.pulsate()
        mediumImpact.impactOccurred()
        updateGameStats()
    }
    
    //MARK: - CRUD Functions
    
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
        let result = gameController.returnGameStats()
       
    }
    
    func restartGame(){
        gameController.restartGame()
        updateGameStats()
        self.guessedNotesIDs = []

    }
    
    
    // MARK: - Navigation
     func checkContinueGame(){
         //29
         if currentRound == 29 {
             self.performSegue(withIdentifier: "toContinueVirtuoso", sender: self)
         }
     }

    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         guard let dVC = segue.destination as? VirtuosoGameViewController else { return }
         //change gametype then send to next VC
         let currentGame = gameController.currentGame
         currentGame.gameType = .Virtuoso
         dVC.gameController.setGame(game: currentGame)
     }

}
