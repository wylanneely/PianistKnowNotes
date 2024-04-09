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
    
    //MARK: Overides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setGradientLabel()
        beginingStateConfig()
    }
    
    init() {
        super.init(nibName: "FinishedGamePopUp", bundle: nil)
        self.modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup
    
    func setGradientLabel(){
        if self.traitCollection.userInterfaceStyle == .dark {
            gradientScoreLabel.gradientColors = [UIColor.white.cgColor, UIColor.systemPurple.cgColor]
        } else {
            gradientScoreLabel.gradientColors = [UIColor.black.cgColor, UIColor.systemPurple.cgColor]
        }

        if let game = game {
            let score = game.score
            gradientScoreLabel.text = "\(score)"
        }
    }
    
    func beginingStateConfig(){
        self.backgroundView.alpha = 0
        self.contentView.alpha = 0
    }
    
    //MARK: - Show
    
    func appear(sender: UIViewController) {
        sender.present(self,animated: false){
            self.show()
        }
    }
    
    private func show() {
        UIView.animate(withDuration: 1, delay: 0.05) {
            self.backgroundView.alpha = 1
            self.contentView.alpha = 1
        }
    }
    
    //MARK: - Outlets

    @IBOutlet weak var contentView: UIView!
    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var restartButton: UIButton!
    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var submitScoreButton: UIButton!
    @IBOutlet weak var gradientScoreLabel: GradientLabel!
    
    //MARK: - Actions
    @IBAction func submitScoreTapped(_ sender: Any) {
        AchievementesController().setFreePiano(highScore: game?.score ?? 0)
    }
    
    @IBAction func shareButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func exitButtonTapped(_ sender: Any) {
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func restartButtonTapped(_ sender: Any) {
        self.dismiss(animated: true) {
            self.delegate?.finishedPopUpRestartedGame()
        }
       // delegate?.finishedPopUpRestartedGame()
    }
    
}

protocol FinishedPopUpDelegate {
    func finishedPopUpRestartedGame()
}
