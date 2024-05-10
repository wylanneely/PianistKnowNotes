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
        gradient.colors = [UIColor.darkBlue.cgColor, UIColor.systemPurple.cgColor]
        let shape = CAShapeLayer()
        shape.lineWidth = 2
        shape.path = UIBezierPath(rect: okButton.bounds).cgPath
        shape.strokeColor = UIColor.black.cgColor
        shape.fillColor = UIColor.clear.cgColor
        gradient.mask = shape
        okButton.layer.addSublayer(gradient)
    }
    
    func setUpLabels(withAchievement:Achievements) {
        titleLabel.font =  UIFont(name: "Poppins-ExtraBold", size: 30)
        messageLabel.font = UIFont(name: "Poppins-Medium", size: 20)
        okButton.titleLabel?.font = UIFont(name: "Poppins-Bold", size: 22)
        
        
    }
    
    //MARK: - Show
    
    func appear(sender: UIViewController,achievement:Achievements) {
        sender.present(self,animated: false){
            self.show(achievement: self.achievement)
        }
    }
    
    private func show(achievement:Achievements) {
        setUpLabels(withAchievement: achievement)
        self.achievement = achievement
        UIView.animate(withDuration: 1, delay: 0.05) {
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
