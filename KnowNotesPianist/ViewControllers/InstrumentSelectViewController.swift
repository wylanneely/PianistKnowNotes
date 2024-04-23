//
//  InstrumentSelectViewController.swift
//  KnowNotesPianist
//
//  Created by Wylan L Neely on 4/1/24.
//

import UIKit
import GameKit

class InstrumentSelectViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, StartGameDelegate, InstrumentSelectDelegate {
    
    //MARK: - Variables
    
    var gameKitController = GameKitController()
    var instrumentType: InstrumentType = .BasicPiano
    
    //MARK: - Overrides

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
        authenticateUser()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        gameKitController.showGKAccessPoint()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        gameKitController.hideGKAcessPoint()
    }
    
//    override var prefersStatusBarHidden: Bool {
//        return true
//    }
    
    //MARK: - Setup
    
    //GameKit
    func authenticateUser() {
      let player = GKLocalPlayer.local
      player.authenticateHandler = { vc, error in
        guard error == nil else {
          print(error?.localizedDescription ?? "")
          return
        }
          if let vc = vc {
              self.present(vc, animated: true, completion: nil)
          }
      }
        gameKitController.showGKAccessPoint()
    }

    
    func setUpCollectionView(){
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: "InstrumentSelectCell", bundle: nil), forCellWithReuseIdentifier: "InstrumentSelectCell")
    }
    
    //MARK: - Start Game Delegate
    
    
    
    func startGame(type:GameType,instrument:InstrumentType) {
        gameKitController.hideGKAcessPoint()
        self.instrumentType = instrument
        //add switch based on game level start point
        switch type {
        case .Novice:
            self.performSegue(withIdentifier: "toStartNovice", sender: self)
        case .Regular:
            self.performSegue(withIdentifier: "toStartRegular", sender: self)
        case .Pianist:
            self.performSegue(withIdentifier: "toStartPianist", sender: self)
        case .Virtuoso:
            self.performSegue(withIdentifier: "toStartVirtuoso", sender: self)
      }
        
    }
    
    func presentedViewDidClose(){
        gameKitController.showGKAccessPoint()
    }

    
    func openProgressViewFor(instrument: InstrumentType) {
        //add logic to launch progress with InstrumentType
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let destinationController = storyboard.instantiateViewController(withIdentifier: "ProgressPageViewController") as? ProgressPageViewController
             else { return }
          
        if let presentationController = destinationController.presentationController as? UISheetPresentationController {
                 presentationController.detents = [.large()]
             }
        destinationController.startDelegate = self
        destinationController.instrumentType = instrument
        gameKitController.hideGKAcessPoint()
        self.present(destinationController, animated: true)
    }
    
    //MARK: - Outlets
    
    @IBOutlet weak var instrumetLabel: UILabel!
    
    //MARK: - CollectionView
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InstrumentSelectCell", for: indexPath) as? InstrumentSelectCell else {
            return UICollectionViewCell()
        }
        cell.delegate = self
        cell.instrumentID = indexPath.row
        cell.awakeFromNib()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let vcWidth = self.view.frame.width
        let vcHeight = self.view.frame.height
        let collectionHeight = (vcHeight * 0.77)
        let collectionWidth = (vcWidth * 0.88)
        return CGSize(width: collectionWidth , height: collectionHeight)
    }
    
    //MARK: - Actions
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let noviceVC = segue.destination as? NoviceGameViewController {
            noviceVC.instrument = self.instrumentType
        }
        if let regularVC = segue.destination as? RegularGameViewController {
            regularVC.instrument = self.instrumentType
        }
        if let pianistVC = segue.destination as? PianistGameViewController {
            pianistVC.instrument = self.instrumentType
        }
        if let virtuosoVC = segue.destination as? VirtuosoGameViewController {
            virtuosoVC.instrument = self.instrumentType
        }
        
    }
    

}
