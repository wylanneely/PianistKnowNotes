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
    
    
    //MARK: - Outlets
    
    @IBOutlet weak var instrumentTypeLabel: UILabel!
    
    @IBOutlet weak var noviceLabel: UILabel!
    @IBOutlet weak var regularLabel: UILabel!
    @IBOutlet weak var pianistLabel: UILabel!
    @IBOutlet weak var virtuosoLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    
    @IBAction func startButtonTapped(_ sender: Any) {
        startButton.pulsate()
        startDelegate?.startGame()
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
}
