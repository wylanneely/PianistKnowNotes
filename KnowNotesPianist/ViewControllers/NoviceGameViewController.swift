//
//  NoviceGameViewController.swift
//  KnowNotesPianist
//
//  Created by Wylan L Neely on 3/20/24.
//

import UIKit
import AVFoundation

class NoviceGameViewController: UIViewController {
    
    var gameController = GameController(gameType: .Novice)
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
        setupButtons()
        setUpProgressBar()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    //MARK: SetUp
    func setupButtons(){
        AButton.layer.shadowColor = UIColor.black.cgColor
        AButton.layer.shadowOffset = CGSize(width: 1.0, height: 4.0)
        AButton.layer.shadowRadius = 8
        AButton.layer.shadowOpacity = 0.6
        CButton.layer.shadowColor = UIColor.black.cgColor
        CButton.layer.shadowOffset = CGSize(width: 1.0, height: 4.0)
        CButton.layer.shadowRadius = 8
        CButton.layer.shadowOpacity = 0.6
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
    
    //MARK: - Audio
    var soundController: SoundController = SoundController(soundPack: FreePianoPack, gameType: .Novice)
   // var soundPack: SoundPack = FreePianoPack
    var player: AVAudioPlayer!
    
    func playSound(noteAnswerID:Int){
        if let soundURL = soundController.returnSoundPathFrom(noteID: noteAnswerID) {
           player = try! AVAudioPlayer(contentsOf: soundURL)
            player!.play()
        }
    }

    //MARK: - Outlets
    
    @IBOutlet weak var HomeButton: UIButton!
    @IBOutlet weak var AButton: UIButton!
    @IBOutlet weak var CButton: UIButton!
    @IBOutlet weak var GButton: UIButton!
    @IBOutlet weak var PlayButton: UIButton!
    @IBOutlet weak var CircularProgressView: CircularProgressBar!
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
       }
    
        let totalGroupRounds: Double = 12.00
        var currentRound: Double = 1.00
    
    
    //MARK: - Actions
    
    @IBAction func PlayButtonTapped(_ sender: Any) {
        if isNewNote {
            self.currentNoteID = gameController.generateNextNoteID()
            print("play sound \(String(describing: currentNoteID))")

            if let cNoteID = currentNoteID {
                DispatchQueue.main.async{
                    self.playSound(noteAnswerID: cNoteID)
                }
                    self.PlayButton.pulsate()
                    self.mediumImpact.impactOccurred()
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
    @IBAction func CButtonTapped(_ sender: Any) {
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
                    CButton.pulsate()
                    mediumImpact.impactOccurred()
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
                        self.guessedNotesIDs.append(1)
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
            if guessedNotesIDs.contains(2) {
                GButton.pulsateGuessed()
                guessedImpact.impactOccurred()
            } else {
                let result = gameController.updateGameWith(noteAnswerID: 2)
                self.playSound(noteAnswerID: 2)
                if result.isCorrect {
                    GButton.pulsate()
                    mediumImpact.impactOccurred()
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
                        self.guessedNotesIDs.append(2)
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
        updateProgressBar()
        let result = gameController.returnGameStats()
        updateLifeImage(lifes: result.lifes)
        //self.LifeLabel.text = "Life: \(result.lifes)"
      //  self.ScoreLabel.text = "Score: \(result.score)"
    }
    
    
    func updateLifeImage(lifes: Int){
        let image = lifeImageController.returnLifeImage(for: lifes)
        lifeImage.image = image
    }
    
    func endGame(){
        let result = gameController.returnGameStats()
       // self.LifeLabel.text = "Game Over"
       // self.ScoreLabel.text = "Final Score: \(result.score)"
    }
    
    func restartGame(){
        gameController.restartGame()
        updateGameStats()
        self.guessedNotesIDs = []
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
