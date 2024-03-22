//
//  VirtuosoGameViewController.swift
//  KnowNotesPianist
//
//  Created by Wylan L Neely on 3/20/24.
//

import UIKit

class VirtuosoGameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    let mediumImpact = UIImpactFeedbackGenerator(style: .medium)

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
    }
  
    @IBAction func AButtonTapped(_ sender: Any) {
        AButton.pulsate()
        mediumImpact.impactOccurred()
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
