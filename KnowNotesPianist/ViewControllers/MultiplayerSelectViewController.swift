//
//  MultiplayerSelectViewController.swift
//  KnowNotesPianist
//
//  Created by Wylan L Neely on 2/6/25.
//

import UIKit
import GameKit

class MultiplayerSelectViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
   
    
    
    var isRandomPlayer: Bool = false
    var invitedPlayer: GKInviteeResponse?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: Outlets
    
    @IBOutlet weak var randomPlayerButton: UIButton!
    @IBOutlet weak var inviteOpponentButton: UIButton!
    
    //MARK: Actions
    @IBAction func invitePlayerButtonTapped(_ sender: Any) {
        
    }
    @IBAction func inviteRandomPlayerTapped(_ sender: Any) {
        
    }
    

    //MARK: Instrument Select Collection View
    
    @IBOutlet weak var instumentSelectCollectionView: UICollectionView!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
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
