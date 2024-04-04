//
//  InstrumentSelectViewController.swift
//  KnowNotesPianist
//
//  Created by Wylan L Neely on 4/1/24.
//

import UIKit

class InstrumentSelectViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
    
    //MARK: - Overrides

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    //MARK: - Setup
    func setUpCollectionView(){
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: "InstrumentSelectCell", bundle: nil), forCellWithReuseIdentifier: "InstrumentSelectCell")
    }
    
    //MARK: - Outlets
    
    @IBAction func testButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
             guard let destinationController = storyboard.instantiateViewController(withIdentifier: "ProgressPageViewController") as? ProgressPageViewController
             else { return }
          
             if let presentationController = destinationController.presentationController as? UISheetPresentationController {
                 presentationController.detents = [.medium(),.large()]
             }
             self.present(destinationController, animated: true)
             
    }
    
    //MARK: - CollectionView
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InstrumentSelectCell", for: indexPath) as? InstrumentSelectCell else {
            return UICollectionViewCell()
        }
        cell.instrumentID = indexPath.row
        cell.awakeFromNib()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let vcWidth = self.view.frame.width
        let vcHeight = self.view.frame.height
        let collectionHeight = (vcHeight * 0.35)
        let collectionWidth = (vcWidth * 0.71)
        return CGSize(width: collectionWidth , height: collectionHeight)
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
