//
//  ProgressPageViewController.swift
//  KnowNotesPianist
//
//  Created by Wylan L Neely on 4/3/24.
//

import UIKit

class ProgressPageViewController: UIViewController {
    
    var startDelegate: StartGameDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: SetUp
    func setUnlockedLockedLevelDifficulties(){
        
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
