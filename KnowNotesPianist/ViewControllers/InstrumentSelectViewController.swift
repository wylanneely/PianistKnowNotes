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
    var achievementsController = AchievementesController()
    var instrumentType: InstrumentType = .BasicPiano
    
    let hapticGenerator = UINotificationFeedbackGenerator()
    
    //Achievments
    
    var is100ClubUnlocked: Bool {
        achievementsController.is100ClubUnlocked
    }
    var is200ClubUnlocked: Bool {
        achievementsController.is200ClubUnlocked
    }
    var is300ClubUnlocked: Bool {
        achievementsController.is300ClubUnlocked
    }
    var isVirtuosoAchiUnlocked: Bool {
        achievementsController.isVirtuosoAchiUnlocked
    }
    
    
 //   let localizationLanguage = NSLocalizedString("AppLanguage", comment: "Preffered Language of localization")

    
    //MARK: - Overrides

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
        authenticateUser()
        setInstrumentLabel()
        setAchievementsButtons()
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
    private let instrumentsString =  NSLocalizedString("Instruments",comment: "")

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

    func setInstrumentLabel(){
        instrumetLabel.text = instrumentsString
    }
    
    func setUpCollectionView(){
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: "InstrumentSelectCell", bundle: nil), forCellWithReuseIdentifier: "InstrumentSelectCell")
    }
    
    func setAchievementsButtons(){
        
        if is100ClubUnlocked {
            hundredClubButton.setImage(
                UIImage(
                    named: "100ClubAchievementDisplay"
                ),
                for: .normal
            )
        } else {
            hundredClubButton.setImage(
                UIImage(
                    named: "LockedAchievement"
                ),
                for: .normal
            )
        }
        
        if is200ClubUnlocked {
            twohundredClubButton.setImage(
                UIImage(
                    named: "200ClubAchievementDisplay"
                ),
                for: .normal
            )
        } else {
            twohundredClubButton.setImage(
                UIImage(
                    named: "LockedAchievement"
                ),
                for: .normal
            )
        }
        
        if is300ClubUnlocked {
            threeHundredClubButton.setImage(
                UIImage(
                    named: "300ClubAchievementDisplay"
                ),
                for: .normal
            )
        } else {
            threeHundredClubButton.setImage(
                UIImage(
                    named: "LockedAchievement"
                ),
                for: .normal
            )
        }
        
        if isVirtuosoAchiUnlocked {
            virtuosoCompleteButton.setImage(
                UIImage(
                    named: "VirtuosoAchievementDisplay"
                ),
                for: .normal
            )
        } else {
            virtuosoCompleteButton.setImage(
                UIImage(
                    named: "LockedAchievement"
                ),
                for: .normal
            )
        }
        
    }
    
//    func setLanguageLocalization(){
//        if localizationLanguage
//    }
    
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
    @IBOutlet weak var hundredClubButton: UIButton!
    @IBOutlet weak var twohundredClubButton: UIButton!
    @IBOutlet weak var threeHundredClubButton: UIButton!
    @IBOutlet weak var virtuosoCompleteButton: UIButton!
    
    //MARK: - Actions
    @IBAction func hundredTapped(_ sender: Any) {
        if is100ClubUnlocked {
            hapticGenerator.notificationOccurred(.success)
        } else {
            hapticGenerator.notificationOccurred(.success)
            let alert = AchievementAlert()
            alert.appear(sender: self,achievement: .club100)
        }
    }
    @IBAction func twoHundredTapped(_ sender: Any) {
        if is200ClubUnlocked {
            //add notification here explaining how to unlock, make sure to localize
            hapticGenerator.notificationOccurred(.success)
        } else {
            hapticGenerator.notificationOccurred(.success)
            let alert = AchievementAlert()
            alert.appear(sender: self,achievement: .club200)
        }
    }
    @IBAction func threeHundredTapped(_ sender: Any) {
        if is300ClubUnlocked {
            //add notification here explaining how to unlock, make sure to localize
            hapticGenerator.notificationOccurred(.success)
        } else {
            hapticGenerator.notificationOccurred(.warning)
            let alert = AchievementAlert()
            alert.appear(sender: self,achievement: .club300)
        }
    }
    @IBAction func virtuosoAchievmentTapped(_ sender: Any) {
        if isVirtuosoAchiUnlocked {
            //add notification here explaining how to unlock, make sure to localize
            hapticGenerator.notificationOccurred(.success)
        } else {
            hapticGenerator.notificationOccurred(.success)
            let alert = AchievementAlert()
            alert.appear(sender: self,achievement: .virtuosoClub)
        }
    }
    
    
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
        let collectionHeight = (vcHeight * 0.7)
        let collectionWidth = (vcWidth * 0.88)
        return CGSize(width: collectionWidth , height: collectionHeight)
    }
    
   
    
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
