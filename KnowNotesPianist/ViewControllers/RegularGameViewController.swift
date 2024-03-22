//
//  RegularGameViewController.swift
//  KnowNotesPianist
//
//  Created by Wylan L Neely on 3/20/24.
//

import UIKit

class RegularGameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtons()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    let mediumImpact = UIImpactFeedbackGenerator(style: .medium)
    
    //MARK: - SetUp
    
    func setupButtons(){
        AButton.layer.shadowColor = UIColor.black.cgColor
        AButton.layer.shadowOffset = CGSize(width: 1.0, height: 4.0)
        AButton.layer.shadowRadius = 8
        AButton.layer.shadowOpacity = 0.6
        CButton.layer.shadowColor = UIColor.black.cgColor
        CButton.layer.shadowOffset = CGSize(width: 1.0, height: 4.0)
        CButton.layer.shadowRadius = 8
        CButton.layer.shadowOpacity = 0.6
        DButton.layer.shadowColor = UIColor.black.cgColor
        DButton.layer.shadowOffset = CGSize(width: 1.0, height: 4.0)
        DButton.layer.shadowRadius = 8
        DButton.layer.shadowOpacity = 0.6
        EButton.layer.shadowColor = UIColor.black.cgColor
        EButton.layer.shadowOffset = CGSize(width: 1.0, height: 4.0)
        EButton.layer.shadowRadius = 8
        EButton.layer.shadowOpacity = 0.6
        GButton.layer.shadowColor = UIColor.black.cgColor
        GButton.layer.shadowOffset = CGSize(width: 1.0, height: 4.0)
        GButton.layer.shadowRadius = 8
        GButton.layer.shadowOpacity = 0.6
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
    @IBOutlet weak var AButton: UIButton!
    @IBOutlet weak var CButton: UIButton!
    @IBOutlet weak var DButton: UIButton!
    @IBOutlet weak var EButton: UIButton!
    @IBOutlet weak var GButton: UIButton!
    @IBOutlet weak var PlayButton: UIButton!
    
    //MARK: - Actions
    
    @IBAction func PlayButtonTapped(_ sender: Any) {
        PlayButton.pulsate()
        mediumImpact.impactOccurred()
    }
    
    @IBAction func AButtonTapped(_ sender: Any) {
        AButton.pulsate()
        mediumImpact.impactOccurred()
    }
    @IBAction func CButtonTapped(_ sender: Any) {
        CButton.pulsate()
        mediumImpact.impactOccurred()

    }
    @IBAction func DButtonTapped(_ sender: Any) {
        DButton.pulsate()
        mediumImpact.impactOccurred()

    }
    @IBAction func EButtonTapped(_ sender: Any) {
        EButton.pulsate()
        mediumImpact.impactOccurred()

    }
    @IBAction func GButtonTapped(_ sender: Any) {
        GButton.pulsate()
        mediumImpact.impactOccurred()

    }
    
    @IBAction func HomeButtonTapped(_ sender: Any) {
        HomeButton.pulsate()
        mediumImpact.impactOccurred()
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
