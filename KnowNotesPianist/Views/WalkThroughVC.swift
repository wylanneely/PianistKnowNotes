//
//  WalkThroughVC.swift
//  KnowNotesPianist
//
//  Created by Wylan L Neely on 6/8/24.
//

import UIKit

class WalkThroughVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        beginingStateConfig()
        setLanguageLocalizations()
    }

    init() {
        super.init(nibName: "WalkThroughVC", bundle: nil)
        self.modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func beginingStateConfig(){
        self.view.alpha = 0
    }
    
    func setLanguageLocalizations(){
        okButton.setTitle(okString, for: .normal)
        hint1Label.text = hint1String
        hint2Label.text = hint2String
    }
    
    let hint1String:String =  NSLocalizedString("Hint1",comment: "top hints")
    let hint2String:String =  NSLocalizedString("Hint2",comment: "bottom hints")
    let okString:String =  NSLocalizedString("OK",comment: "bottom hints")
    
    let mediumHaptic = UIImpactFeedbackGenerator(style: .medium)

    //MARK: - Show
    
    func appear(sender: UIViewController) {
        sender.present(self,animated: false){
            self.show()
        }
    }
    
    private func show() {
        UIView.animate(withDuration: 1, delay: 0.05) {
            self.view.alpha = 1
        }
    }
    
    //MARK: - Dismiss
    
    public func hide() {
        UIView.animate(withDuration: 1, delay: 0.0, options: .curveEaseOut) {
            self.view.alpha = 0
        } completion: { _ in
            self.dismiss(animated: false)
            self.removeFromParent()
        }
    }
    
    func saveDismissState(){
        AchievementesController().hintsHaveBeenShown()
    }

    //MARK: Outlets and Actions
    
    @IBOutlet weak var hint1Label: UILabel!
    @IBOutlet weak var hint2Label: UILabel!
    @IBOutlet weak var okButton: UIButton!
    
    @IBAction func okTapped(_ sender: Any) {
        mediumHaptic.impactOccurred()
        saveDismissState()
        self.hide()
    }
    
}
