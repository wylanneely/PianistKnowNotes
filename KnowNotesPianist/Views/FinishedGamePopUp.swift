//
//  FinishedGamePopUp.swift
//  KnowNotesPianist
//
//  Created by Wylan L Neely on 4/7/24.
//

import UIKit

class FinishedGamePopUp: UIViewController {
    
    var gameKitController = GameKitController()

    var game: Game?
    var delegate: FinishedPopUpDelegate?
    var shareImage: UIImage?
    var isPaused: Bool = true
    var instrument: InstrumentType = .GrandPiano
    
    let mediumImpact = UIImpactFeedbackGenerator(style: .medium)
    let heavyImpact = UIImpactFeedbackGenerator(style: .heavy)
    let lightImpact = UIImpactFeedbackGenerator(style: .soft)
    
    //MARK: Overides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setGradientLabel()
        beginingStateConfig()
        checkSetPausedState()
        setupLanguageLocalizaions()
        //shareImage = contentView.asImage()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        shareImage = contentView.asImage()
    }
    
    init() {
        super.init(nibName: "FinishedGamePopUp", bundle: nil)
        self.modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup
    
    func setupLanguageLocalizaions(){
        exitButton.setTitle(exitString, for: .normal)
        restartButton.setTitle(restartString, for: .normal)
        submitScoreButton.setTitle(submitString, for: .normal)
    }
    
    func setGradientLabel(){
        switch language {
        case "Chinese":
            gradientScoreLabel.gradientColors = [
                UIColor.systemRed.cgColor,
                UIColor.systemYellow.cgColor
            ]
        if let game = game {
            let score = game.score.returnIntAsChinese()
            gradientScoreLabel.text = "\(score)"
        }
            return
        case "Potruguese":
            gradientScoreLabel.gradientColors = [UIColor.systemGreen.cgColor, UIColor.systemYellow.cgColor]
        case "French":
            gradientScoreLabel.gradientColors = [UIColor.systemRed.cgColor, UIColor.darkBlue.cgColor]
        case "Spanish":
            gradientScoreLabel.gradientColors = [UIColor.systemBlue.cgColor, UIColor.systemCyan.cgColor]
        case "Korean":
            gradientScoreLabel.gradientColors = [UIColor.systemRed.cgColor, UIColor.darkBlue.cgColor]
        case "Japanese":
            gradientScoreLabel.gradientColors = [UIColor.systemRed.cgColor, UIColor.red.cgColor]
        case "German":
            gradientScoreLabel.gradientColors = [UIColor.systemYellow.cgColor, UIColor.systemRed.cgColor]
        case "Russian":
            gradientScoreLabel.gradientColors = [UIColor.systemRed.cgColor, UIColor.darkBlue.cgColor]
        case "Italian":
            gradientScoreLabel.gradientColors = [UIColor.systemRed.cgColor, UIColor.systemGreen.cgColor]
        default:
            if self.traitCollection.userInterfaceStyle == .dark {
                gradientScoreLabel.gradientColors = [
                    UIColor.systemCyan.cgColor,
                    UIColor.systemPurple.cgColor
                ]
            } else {
                gradientScoreLabel.gradientColors = [
                    UIColor.systemPurple.cgColor,
                    UIColor.systemCyan.cgColor
                ]
            }
        }
            
            if let game = game {
                let score = game.score
                gradientScoreLabel.text = "\(score)"
            }
    
    }
    
    func checkSetPausedState(){
        if isPaused {
            dismissButton.isHidden = false
        } else {
            dismissButton.isHidden = true
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
    
    //MARK: - Dismiss
    
    func hide() {
        UIView.animate(withDuration: 1, delay: 0.0, options: .curveEaseOut) {
            self.backgroundView.alpha = 0
            self.contentView.alpha = 0
        } completion: { _ in
            self.dismiss(animated: false)
            self.removeFromParent()
        }
    }
    
    //MARK: - Outlets

    @IBOutlet weak var contentView: UIView!
    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var restartButton: UIButton!
    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var submitScoreButton: UIButton!
    @IBOutlet weak var gradientScoreLabel: GradientLabel!
    @IBOutlet weak var dismissButton: UIButton!
    
    let exitString:String =  NSLocalizedString("Exit",comment: "exit home")
    let restartString:String = NSLocalizedString("Restart",comment: "restart game")
    let submitString:String = NSLocalizedString("Submit",comment: "submit score")
    private var language: String = NSLocalizedString("AppLanguage", comment: "to help adjust certain views/settings")

    //MARK: - Actions
    @IBAction func submitScoreTapped(_ sender: Any) {
        submitScoreButton.pulsate()
        mediumImpact.impactOccurred()
       // AchievementesController().setFreePiano(highScore: game?.score ?? 0)
        gameKitController.submitLeaderboard(score: game?.score ?? 0, instrument: self.instrument)
        GameKitController().showGKAccessPoint()
    }
    
    @IBAction func shareButtonTapped(_ sender: Any) {
        lightImpact.impactOccurred()
        presentShareSheet()
    }

    @objc private func presentShareSheet() {
        //in future replace link with link to game
        guard let image = self.shareImage else {
        // let url = URL(string: "https://apps.apple.com/us/app/sober-today/id6478566365") else {
            print("error")
            return
        }
        let shareSheetVC = UIActivityViewController(activityItems: [image],
                                                    applicationActivities: nil)
        present(shareSheetVC, animated: true)
    }
    
    @IBAction func dismissButtonTapped(_ sender: Any) {
        self.hide()
        GameKitController().hideGKAcessPoint()
    }
    
    @IBAction func exitButtonTapped(_ sender: Any) {
        exitButton.pulsate()
        heavyImpact.impactOccurred()
        self.view.window?.rootViewController?.dismiss(animated: true, completion: {
            GameKitController().showGKAccessPoint()
        })
    }
    
    @IBAction func restartButtonTapped(_ sender: Any) {
        GameKitController().hideGKAcessPoint()
        restartButton.pulsate()
        heavyImpact.impactOccurred()
        self.dismiss(animated: true) {
            self.delegate?.finishedPopUpRestartedGame()
        }
       // delegate?.finishedPopUpRestartedGame()
    }
    
}

protocol FinishedPopUpDelegate {
    func finishedPopUpRestartedGame()
}
