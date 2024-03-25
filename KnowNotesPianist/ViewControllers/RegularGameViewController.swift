//
//  RegularGameViewController.swift
//  KnowNotesPianist
//
//  Created by Wylan L Neely on 3/20/24.
//

import UIKit

class RegularGameViewController: UIViewController {
    
    var gameController = GameController(gameType: .Regular)
    
    var currentNoteID: Int?
    
    var isNewNote: Bool = true
    var guessedNotesIDs = [Int]()
    
    let mediumImpact = UIImpactFeedbackGenerator(style: .medium)
    let heavyImpact = UIImpactFeedbackGenerator(style: .heavy)
    let guessedImpact = UIImpactFeedbackGenerator(style: .soft)

    //MARK: - Override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtons()
        updateGameStats()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    //MARK: - SetUp
    
    func setupButtons(){
        AButton.layer.shadowColor = UIColor.black.cgColor
        AButton.layer.shadowOffset = CGSize(width: 1.0, height: 4.0)
        AButton.layer.shadowRadius = 8
        AButton.layer.shadowOpacity = 0.6
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
    
    //MARK: - Outlets

    @IBOutlet weak var ScoreLabel: UILabel!
    @IBOutlet weak var LifeLabel: UILabel!
    @IBOutlet weak var HomeButton: UIButton!
    @IBOutlet weak var AButton: UIButton!
    @IBOutlet weak var CButton: UIButton!
    @IBOutlet weak var DButton: UIButton!
    @IBOutlet weak var EButton: UIButton!
    @IBOutlet weak var GButton: UIButton!
    @IBOutlet weak var PlayButton: UIButton!
    
    //MARK: - Actions
    
    @IBAction func PlayButtonTapped(_ sender: Any) {
        PlayButton.pulsate()
        mediumImpact.impactOccurred()
        if isNewNote {
            self.currentNoteID = gameController.generateNextNoteID()
            print("play sound \(String(describing: currentNoteID))")
            self.isNewNote = false
        } else {
            print("play sound \(String(describing: currentNoteID))")
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
    @IBAction func DButtonTapped(_ sender: Any) {
        if isNewNote {
            DButton.pulsateGuessed()
            guessedImpact.impactOccurred()
            return
        } else {
            if guessedNotesIDs.contains(2) {
                DButton.pulsateGuessed()
                guessedImpact.impactOccurred()
            } else {
                let result = gameController.updateGameWith(noteAnswerID: 2)
                if result.isCorrect {
                    DButton.pulsate()
                    mediumImpact.impactOccurred()
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
                        self.guessedNotesIDs.append(2)
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
            if guessedNotesIDs.contains(3) {
                EButton.pulsateGuessed()
                guessedImpact.impactOccurred()
            } else {
                let result = gameController.updateGameWith(noteAnswerID: 3)
                if result.isCorrect {
                    EButton.pulsate()
                    mediumImpact.impactOccurred()
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
                        self.guessedNotesIDs.append(3)
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
            if guessedNotesIDs.contains(4) {
                GButton.pulsateGuessed()
                guessedImpact.impactOccurred()
            } else {
                let result = gameController.updateGameWith(noteAnswerID: 4)
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
                        self.guessedNotesIDs.append(4)
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
        self.LifeLabel.text = "Life: \(result.lifes)"
        self.ScoreLabel.text = "Score: \(result.score)"
    }
    
    func endGame(){
        let result = gameController.returnGameStats()
        self.LifeLabel.text = "Game Over"
        self.ScoreLabel.text = "Final Score: \(result.score)"
    }
    
    func restartGame(){
        gameController.restartGame()
        updateGameStats()
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
