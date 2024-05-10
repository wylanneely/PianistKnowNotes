//
//  AchievementAlert.swift
//  KnowNotesPianist
//
//  Created by Wylan L Neely on 5/9/24.
//

import UIKit

class AchievementAlert: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpButtonGradient()
    }

    //MARK: Set up
    init() {
        super.init(nibName: "AchievementAlert", bundle: nil)
        self.modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpButtonGradient(){
        let gradient = CAGradientLayer()
        gradient.frame =  CGRect(origin: .zero, size: okButton.frame.size)
        gradient.colors = [UIColor.systemCyan.cgColor, UIColor.systemPurple.cgColor]
        let shape = CAShapeLayer()
        shape.lineWidth = 2
        shape.path = UIBezierPath(rect: okButton.bounds).cgPath
        shape.strokeColor = UIColor.black.cgColor
        shape.fillColor = UIColor.clear.cgColor
        gradient.mask = shape
        okButton.layer.addSublayer(gradient)
    }
    
    func setUpLabels(withAchievement:Achievements) {
        titleLabel.font =  UIFont(name: "Poppins-ExtraBold", size: 33)
        titleLabel.text = lockedString
        messageLabel.font = UIFont(name: "Poppins-Medium", size: 22)
        okButton.setTitle(okMessage, for: .normal)
        
        switch withAchievement {
        case .club100: messageLabel.text = achievementMessage1
        case .club200: messageLabel.text = achievementMessage2
        case .club300: messageLabel.text = achievementMessage3
        case .virtuosoClub: messageLabel.text = achievementMessageV
        }
        
        
    }
    
    
    //MARK: Localized Strings
    private let achievementMessage1 =  NSLocalizedString("AchievementMessage1",comment: "")
    private let achievementMessage2 =  NSLocalizedString("AchievementMessage2",comment: "")
    private let achievementMessage3 =  NSLocalizedString("AchievementMessage3",comment: "")
    private let achievementMessageV =  NSLocalizedString("AchievementMessageV",comment: "")

    private let lockedString =  NSLocalizedString("Locked",comment: "")
    private let okMessage =  NSLocalizedString("OK",comment: "")

    //MARK: - Show
    
    func appear(sender: UIViewController,achievement:Achievements) {
        sender.present(self,animated: false){
            self.show(achievement: self.achievement)
        }
    }
    
    private func show(achievement:Achievements) {
        setUpLabels(withAchievement: achievement)
        self.achievement = achievement
        UIView.animate(withDuration: 1.5, delay: 0.15) {
            self.backgroundView.alpha = 1
          // self.contentView.alpha = 1
        }
    }
    
    //MARK: - Dismiss
    
    func hide() {
        UIView.animate(withDuration: 1, delay: 0.0, options: .curveEaseOut) {
            self.backgroundView.alpha = 0
           // self.contentView.alpha = 0
        } completion: { _ in
            self.dismiss(animated: false)
            self.removeFromParent()
        }
    }
    
   //MARK: Outlets
    
    var achievement: Achievements = .club100
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    //MARK: Actions
    @IBAction func okButtonTapped(_ sender: Any) {
        self.hide()
    }
    
}


enum Achievements {
    case club100
    case club200
    case club300
    case virtuosoClub
}
