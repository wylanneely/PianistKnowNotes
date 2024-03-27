//
//  VirtuosoGameViewController.swift
//  KnowNotesPianist
//
//  Created by Wylan L Neely on 3/20/24.
//

import UIKit
import AVFoundation

class VirtuosoGameViewController: UIViewController {

    var gameController = GameController(gameType: .Novice)
    
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
        updateGameStats()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    //MARK: - Audio
    var soundController: SoundController = SoundController(soundPack: FreePianoPack, gameType: .Virtuoso)
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
        ASButton.layer.shadowColor = UIColor.black.cgColor
        ASButton.layer.shadowOffset = CGSize(width: 1.3, height: 3.0)
        ASButton.layer.shadowRadius = 8
        ASButton.layer.shadowOpacity = 0.6
        BButton.layer.shadowColor = UIColor.black.cgColor
        BButton.layer.shadowOffset = CGSize(width: 1.0, height: 4.0)
        BButton.layer.shadowRadius = 8
        BButton.layer.shadowOpacity = 0.6
        CButton.layer.shadowColor = UIColor.black.cgColor
        CButton.layer.shadowOffset = CGSize(width: 1.0, height: 4.0)
        CButton.layer.shadowRadius = 8
        CButton.layer.shadowOpacity = 0.6
        CSButton.layer.shadowColor = UIColor.black.cgColor
        CSButton.layer.shadowOffset = CGSize(width: 1.0, height: 4.0)
        CSButton.layer.shadowRadius = 8
        CSButton.layer.shadowOpacity = 0.6
        DButton.layer.shadowColor = UIColor.black.cgColor
        DButton.layer.shadowOffset = CGSize(width: 1.0, height: 4.0)
        DButton.layer.shadowRadius = 8
        DButton.layer.shadowOpacity = 0.6
        DSButton.layer.shadowColor = UIColor.black.cgColor
        DSButton.layer.shadowOffset = CGSize(width: 1.0, height: 4.0)
        DSButton.layer.shadowRadius = 8
        DSButton.layer.shadowOpacity = 0.6
        EButton.layer.shadowColor = UIColor.black.cgColor
        EButton.layer.shadowOffset = CGSize(width: 1.0, height: 4.0)
        EButton.layer.shadowRadius = 8
        EButton.layer.shadowOpacity = 0.6
        FButton.layer.shadowColor = UIColor.black.cgColor
        FButton.layer.shadowOffset = CGSize(width: 1.3, height: 3.0)
        FButton.layer.shadowRadius = 8
        FButton.layer.shadowOpacity = 0.6
        FSButton.layer.shadowColor = UIColor.black.cgColor
        FSButton.layer.shadowOffset = CGSize(width: 1.3, height: 3.0)
        FSButton.layer.shadowRadius = 8
        FSButton.layer.shadowOpacity = 0.6
        GButton.layer.shadowColor = UIColor.black.cgColor
        GButton.layer.shadowOffset = CGSize(width: 1.0, height: 4.0)
        GButton.layer.shadowRadius = 8
        GButton.layer.shadowOpacity = 0.6
        GSButton.layer.shadowColor = UIColor.black.cgColor
        GSButton.layer.shadowOffset = CGSize(width: 1.0, height: 4.0)
        GSButton.layer.shadowRadius = 8
        GSButton.layer.shadowOpacity = 0.6
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
    
    @IBOutlet weak var HomeButton: UIButton!
    @IBOutlet weak var ScoreLabel: UILabel!
    @IBOutlet weak var LifeLabel: UILabel!
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
    @IBAction func ASButtonTapped(_ sender: Any) {
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
                    mediumImpact.impactOccurred()
                    self.updateGameStats()
                    self.isNewNote = true
                    self.guessedNotesIDs = []
                } else {
                    if result.isGameOver {
                        heavyImpact.impactOccurred()
                        ASButton.pulsateWrong()
                        self.endGame()
                    } else {
                        heavyImpact.impactOccurred()
                        ASButton.pulsateWrong()
                        self.guessedNotesIDs.append(1)
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
            if guessedNotesIDs.contains(2) {
                BButton.pulsateGuessed()
                guessedImpact.impactOccurred()
            } else {
                let result = gameController.updateGameWith(noteAnswerID: 2)
                self.playSound(noteAnswerID: 2)
                if result.isCorrect {
                    BButton.pulsate()
                    mediumImpact.impactOccurred()
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
                        self.guessedNotesIDs.append(2)
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
            if guessedNotesIDs.contains(3) {
                CButton.pulsateGuessed()
                guessedImpact.impactOccurred()
            } else {
                let result = gameController.updateGameWith(noteAnswerID: 3)
                self.playSound(noteAnswerID: 3)
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
                        self.guessedNotesIDs.append(3)
                        self.updateGameStats()
                    }
                }
            }
        }
    }
    @IBAction func CSButtonTapped(_ sender: Any) {
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
                    mediumImpact.impactOccurred()
                    self.updateGameStats()
                    self.isNewNote = true
                    self.guessedNotesIDs = []
                } else {
                    if result.isGameOver {
                        heavyImpact.impactOccurred()
                        CSButton.pulsateWrong()
                        self.endGame()
                    } else {
                        heavyImpact.impactOccurred()
                        CSButton.pulsateWrong()
                        self.guessedNotesIDs.append(4)
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
            if guessedNotesIDs.contains(5) {
                DButton.pulsateGuessed()
                guessedImpact.impactOccurred()
            } else {
                let result = gameController.updateGameWith(noteAnswerID: 5)
                self.playSound(noteAnswerID: 5)
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
                        self.guessedNotesIDs.append(5)
                        self.updateGameStats()
                    }
                }
            }
        }
    }
    @IBAction func DSButtonTapped(_ sender: Any) {
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
                    mediumImpact.impactOccurred()
                    self.updateGameStats()
                    self.isNewNote = true
                    self.guessedNotesIDs = []
                } else {
                    if result.isGameOver {
                        heavyImpact.impactOccurred()
                        DSButton.pulsateWrong()
                        self.endGame()
                    } else {
                        heavyImpact.impactOccurred()
                        DSButton.pulsateWrong()
                        self.guessedNotesIDs.append(6)
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
            if guessedNotesIDs.contains(7) {
                EButton.pulsateGuessed()
                guessedImpact.impactOccurred()
            } else {
                let result = gameController.updateGameWith(noteAnswerID: 7)
                self.playSound(noteAnswerID: 7)
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
                        self.guessedNotesIDs.append(7)
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
            if guessedNotesIDs.contains(8) {
                FButton.pulsateGuessed()
                guessedImpact.impactOccurred()
            } else {
                let result = gameController.updateGameWith(noteAnswerID: 8)
                self.playSound(noteAnswerID: 8)
                if result.isCorrect {
                    FButton.pulsate()
                    mediumImpact.impactOccurred()
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
                        self.guessedNotesIDs.append(8)
                        self.updateGameStats()
                    }
                }
            }
        }
    }
    @IBAction func FSButtonTapped(_ sender: Any) {
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
                    mediumImpact.impactOccurred()
                    self.updateGameStats()
                    self.isNewNote = true
                    self.guessedNotesIDs = []
                } else {
                    if result.isGameOver {
                        heavyImpact.impactOccurred()
                        FSButton.pulsateWrong()
                        self.endGame()
                    } else {
                        heavyImpact.impactOccurred()
                        FSButton.pulsateWrong()
                        self.guessedNotesIDs.append(9)
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
            if guessedNotesIDs.contains(10) {
                GButton.pulsateGuessed()
                guessedImpact.impactOccurred()
            } else {
                let result = gameController.updateGameWith(noteAnswerID: 10)
                self.playSound(noteAnswerID: 10)
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
                        self.guessedNotesIDs.append(10)
                        self.updateGameStats()
                    }
                }
            }
        }
    }
    @IBAction func GSButtonTapped(_ sender: Any) {
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
                    mediumImpact.impactOccurred()
                    self.updateGameStats()
                    self.isNewNote = true
                    self.guessedNotesIDs = []
                } else {
                    if result.isGameOver {
                        heavyImpact.impactOccurred()
                        GSButton.pulsateWrong()
                        self.endGame()
                    } else {
                        heavyImpact.impactOccurred()
                        GSButton.pulsateWrong()
                        self.guessedNotesIDs.append(11)
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
