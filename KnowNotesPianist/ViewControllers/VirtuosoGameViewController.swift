//
//  VirtuosoGameViewController.swift
//  KnowNotesPianist
//
//  Created by Wylan L Neely on 3/20/24.
//

import UIKit

class VirtuosoGameViewController: UIViewController {

    var gameController = GameController(gameType: .Novice)
    
    var currentNoteID: Int?
    
    var isNewNote: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    let mediumImpact = UIImpactFeedbackGenerator(style: .medium)
    let heavyImpact = UIImpactFeedbackGenerator(style: .heavy)
    let guessedImpact = UIImpactFeedbackGenerator(style: .soft)
    
    //MARK: - Outlets
    
    @IBOutlet weak var HomeButton: UIButton!
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
        PlayButton.pulsate()
        mediumImpact.impactOccurred()
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
  
    var guessedNotesIDs = [Int]()

    
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
    @IBAction func ASButtonTapped(_ sender: Any) {
        ASButton.pulsate()
        mediumImpact.impactOccurred()
    }
    @IBAction func BButtonTapped(_ sender: Any) {
        BButton.pulsate()
        mediumImpact.impactOccurred()
    }
    @IBAction func CButtonTapped(_ sender: Any) {
        CButton.pulsate()
        mediumImpact.impactOccurred()
    }
    @IBAction func CSButtonTapped(_ sender: Any) {
        CSButton.pulsate()
        mediumImpact.impactOccurred()
    }
    @IBAction func DButtonTapped(_ sender: Any) {
        DButton.pulsate()
        mediumImpact.impactOccurred()
    }
    @IBAction func DSButtonTapped(_ sender: Any) {
        DSButton.pulsate()
        mediumImpact.impactOccurred()
    }
    @IBAction func EButtonTapped(_ sender: Any) {
        EButton.pulsate()
        mediumImpact.impactOccurred()
    }
    @IBAction func FButtonTapped(_ sender: Any) {
        FButton.pulsate()
        mediumImpact.impactOccurred()
    }
    @IBAction func FSButtonTapped(_ sender: Any) {
        FSButton.pulsate()
        mediumImpact.impactOccurred()
    }
    @IBAction func GButtonTapped(_ sender: Any) {
        GButton.pulsate()
        mediumImpact.impactOccurred()
    }
    @IBAction func GSButtonTapped(_ sender: Any) {
        GSButton.pulsate()
        mediumImpact.impactOccurred()
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
        //self.LifeLabel.text = "Life: \(result.lifes)"
      //  self.ScoreLabel.text = "Score: \(result.score)"
    }
    
    func endGame(){
        let result = gameController.returnGameStats()
       // self.LifeLabel.text = "Game Over"
       // self.ScoreLabel.text = "Final Score: \(result.score)"
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
