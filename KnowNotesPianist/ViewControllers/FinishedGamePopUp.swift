//
//  FinishedGamePopUp.swift
//  KnowNotesPianist
//
//  Created by Wylan L Neely on 4/7/24.
//

import UIKit

class FinishedGamePopUp: UIViewController {

    var game: Game?
    var delegate: FinishedPopUpDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setGradientLabel()
    }

    //MARK: - Setup
    
    func setGradientLabel(){
        gradientScoreLabel.gradientColors = [UIColor.systemBlue.cgColor, UIColor.systemPurple.cgColor]
        if let game = game {
            let score = game.score
            gradientScoreLabel.text = "\(score)"
        }
    }
    
    //MARK: - Outlets

    @IBOutlet weak var restartButton: UIButton!
    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var submitScoreButton: UIButton!
    @IBOutlet weak var gradientScoreLabel: GradientLabel!
    
    //MARK: - Actions
    
    @IBAction func shareButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func exitButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func restartButtonTapped(_ sender: Any) {
        delegate?.finishedPopUpRestartedGame()
    }
    
}

protocol FinishedPopUpDelegate {
    func finishedPopUpRestartedGame()
}
