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
    
    var isRegularUnlocked: Bool = false
    var isPianistUnlocked: Bool = false
    var isVirtuosoUnlocked: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setUnlockedLockedLevelDifficulties()
        // Do any additional setup after loading the view.
    }
    
    //MARK: SetUp
    func setUnlockedLockedLevelDifficulties(){
        //eventually ad a switch case for instrument type
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
    }
    
    func setButtonStates(){
        let unlockedImage = UIImage(named: "UnlockedButtonImage")
        let lockedImage = UIImage(named: "LockedButtonImage")
        
        if isRegularUnlocked {
            regularButton.isEnabled = true
            regularButton.setImage(unlockedImage, for: .normal)
        } else {
            regularButton.isEnabled = false
            regularButton.setImage(lockedImage, for: .disabled)
        }
        
        if isPianistUnlocked {
            pianistButton.isEnabled = true
            pianistButton.setImage(unlockedImage, for: .normal)
        } else {
            pianistButton.isEnabled = false
            pianistButton.setImage(lockedImage, for: .disabled)
        }
        
        if isVirtuosoUnlocked {
            virtuosoButton.isEnabled = true
            virtuosoButton.setImage(unlockedImage, for: .normal)
        } else {
            virtuosoButton.isEnabled = false
            virtuosoButton.setImage(lockedImage, for: .disabled)
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
    
  
    
    //MARK: - Actions
    
    @IBAction func noviceButtonTapped(_ sender: Any) {
        startDelegate?.difficultyType(type: .Novice)
    }
    
    @IBAction func regularButtonTapped(_ sender: Any) {
        startDelegate?.difficultyType(type: .Regular)
    }
    
    @IBAction func pianistButtonTapped(_ sender: Any) {
        startDelegate?.difficultyType(type: .Pianist)
    }
    
    @IBAction func virtuosoButtonTapped(_ sender: Any) {
        startDelegate?.difficultyType(type: .Virtuoso)
    }
    
    @IBAction func startButtonTapped(_ sender: Any) {
        startButton.pulsate()
        self.dismiss(animated: true) {
            self.startDelegate?.startGame()
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
    func startGame()
    func difficultyType(type:GameType)
}
