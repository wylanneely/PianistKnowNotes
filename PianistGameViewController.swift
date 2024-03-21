//
//  PianistGameViewController.swift
//  KnowNotesPianist
//
//  Created by Wylan L Neely on 3/20/24.
//

import UIKit

class PianistGameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    

    //MARK: - Outlets
    
    @IBOutlet weak var HomeButton: UIButton!
    @IBOutlet weak var AButton: UIButton!
    @IBOutlet weak var BButton: UIButton!
    @IBOutlet weak var CButton: UIButton!
    @IBOutlet weak var DButton: UIButton!
    @IBOutlet weak var EButton: UIButton!
    @IBOutlet weak var FButton: UIButton!
    @IBOutlet weak var GButton: UIButton!
    @IBOutlet weak var PlayButton: UIButton!
    
    //MARK: - Actions
    
    @IBAction func PlayButtonTapped(_ sender: Any) {
    }
    
    @IBAction func AButtonTapped(_ sender: Any) {
    }
    @IBAction func BButtonTapped(_ sender: Any) {
    }
    @IBAction func CButtonTapped(_ sender: Any) {
    }
    @IBAction func DButtonTapped(_ sender: Any) {
    }
    @IBAction func EButtonTapped(_ sender: Any) {
    }
    @IBAction func FButtonTapped(_ sender: Any) {
    }
    @IBAction func GButtonTapped(_ sender: Any) {
    }
    
    @IBAction func HomeButtonTapped(_ sender: Any) {
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
