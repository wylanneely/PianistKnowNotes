//
//  InstrumentSelectCell.swift
//  KnowNotesPianist
//
//  Created by Wylan L Neely on 4/1/24.
//

import UIKit

class InstrumentSelectCell: UICollectionViewCell {
    
    var instrumentID: Int = 0
    var delegate: InstrumentSelectDelegate?
    
    var instrumentType: InstrumentType {
        switch instrumentID {
        case 0: return InstrumentType.BasicPiano
        case 1: return InstrumentType.GrandPiano
        case 2: return InstrumentType.AcousticGuitar
        case 3: return InstrumentType.Keyboard
        case 4: return InstrumentType.Violin
        default: return InstrumentType.BasicPiano
        }
    }
    
    //MARK: - Outlets
    
    @IBOutlet weak var instrumentImage: UIImageView!
    @IBOutlet weak var instrumentLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    
    //MARK: - Setup
        
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpVariables()
        setUpHighScoreLabel()
    }
    
    func setUpVariables(){
        let backGroundImage = returnInstrumentImage(id: self.instrumentID)
        instrumentImage.image = backGroundImage
        let labelText = returnLabelText(id: self.instrumentID)
        instrumentLabel.text = labelText
    }
    
    func setUpHighScoreLabel(){
        
        switch instrumentType {
        case .BasicPiano:
            let hs = AchievementesController().getFreePianoHighScore()
            highScoreLabel.text = "High Score \(hs)"
        case .GrandPiano:
            if AchievementesController().isGrandPianoNoviceUnlocked() {
                let hs = AchievementesController().getGrandPianoHighScore()
                highScoreLabel.text = "High Score \(hs)"
            } else {
                highScoreLabel.text = "Locked"
            }
        case .AcousticGuitar:
            if AchievementesController().isAcousticNoviceUnlocked() {
                let hs = AchievementesController().getAcousticHighScore()
                highScoreLabel.text = "High Score \(hs)"
            } else {
                highScoreLabel.text = "Locked"
            }
        case .Keyboard:
            if AchievementesController().isKeyboardNoviceUnlocked() {
                let hs = AchievementesController().getKeyboardHighScore()
                highScoreLabel.text = "High Score \(hs)"
            } else {
                highScoreLabel.text = "Locked"
            }
        case .Violin:
            if AchievementesController().isViolinNoviceUnlocked() {
                let hs = AchievementesController().getViolinHighScore()
                highScoreLabel.text = "High Score \(hs)"
            } else {
                highScoreLabel.text = "Locked"
            }
        }
    }
    
    
    //Images and names to be shown
   private func returnInstrumentImage(id:Int)->UIImage {
        switch id {
        case 0: return UIImage(named: "grandpiano")!
        case 1: return UIImage(named: "grandpiano")!
        case 2: return UIImage(named: "grandpiano")!
        case 3: return UIImage(named: "grandpiano")!
        case 4: return UIImage(named: "grandpiano")!
        default:
            return UIImage(named: "grandpiano")!
        }
    }
    
   private func returnLabelText(id:Int)->String{
        switch id {
        case 0: return InstrumentTypeName.BasicPiano.rawValue
        case 1: return InstrumentTypeName.GrandPiano.rawValue
        case 2: return InstrumentTypeName.AcousticGuitar.rawValue
        case 3: return InstrumentTypeName.Keyboard.rawValue
        case 4: return InstrumentTypeName.Violin.rawValue
        default:
            return "Piano"
        }
    }
    
    //MARK: - Outlet
    @IBAction func cellButtonTapped(_ sender: Any) {
        delegate?.openProgressViewFor(instrument: self.instrumentType)
    }
    

}

protocol InstrumentSelectDelegate {
    func openProgressViewFor(instrument:InstrumentType)
}

