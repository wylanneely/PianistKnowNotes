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
        setUpLabels()
    }
    
    func setUpVariables(){
        let backGroundImage = returnInstrumentImage(id: self.instrumentID)
        instrumentImage.image = backGroundImage
        let labelText = returnLabelText(id: self.instrumentID)
        instrumentLabel.text = labelText
        self.layer.borderWidth = 4
    }
    
    func setUpLabels(){
        
        switch instrumentType {
        case .BasicPiano:
            let hs = AchievementesController().getFreePianoHighScore()
            highScoreLabel.text = "High Score \(hs)"
            highScoreLabel.textColor =  UIColor.instrumentLabel
            instrumentLabel.textColor = UIColor.instrumentLabel
            self.layer.borderColor = UIColor.instrumentLabel.cgColor
        case .GrandPiano:
            if AchievementesController().isGrandPianoNoviceUnlocked() {
                let hs = AchievementesController().getGrandPianoHighScore()
                highScoreLabel.text = "High Score \(hs)"
                highScoreLabel.textColor =  UIColor.instrumentLabel
                instrumentLabel.textColor = UIColor.instrumentLabel
                self.layer.borderColor = UIColor.instrumentLabel.cgColor

            } else {
                highScoreLabel.text = "Locked"
                highScoreLabel.textColor = .systemRed
                instrumentLabel.textColor = .systemRed
                self.layer.borderColor = UIColor.systemRed.cgColor
            }
        case .AcousticGuitar:
            if AchievementesController().isAcousticNoviceUnlocked() {
                let hs = AchievementesController().getAcousticHighScore()
                highScoreLabel.text = "High Score \(hs)"
                highScoreLabel.textColor =  UIColor.instrumentLabel
                instrumentLabel.textColor = UIColor.instrumentLabel
                self.layer.borderColor = UIColor.instrumentLabel.cgColor

            } else {
                highScoreLabel.text = "Locked"
                highScoreLabel.textColor = .systemRed
                instrumentLabel.textColor = .systemRed
                self.layer.borderColor = UIColor.systemRed.cgColor
            }
        case .Keyboard:
            if AchievementesController().isKeyboardNoviceUnlocked() {
                let hs = AchievementesController().getKeyboardHighScore()
                highScoreLabel.text = "High Score \(hs)"
                highScoreLabel.textColor =  UIColor.instrumentLabel
                instrumentLabel.textColor = UIColor.instrumentLabel
                self.layer.borderColor = UIColor.instrumentLabel.cgColor
            } else {
                highScoreLabel.text = "Locked"
                highScoreLabel.textColor = .systemRed
                instrumentLabel.textColor = .systemRed
                self.layer.borderColor = UIColor.systemRed.cgColor
            }
        case .Violin:
            if AchievementesController().isViolinNoviceUnlocked() {
                let hs = AchievementesController().getViolinHighScore()
                highScoreLabel.text = "High Score \(hs)"
                highScoreLabel.textColor =  UIColor.instrumentLabel
                instrumentLabel.textColor = UIColor.instrumentLabel
                self.layer.borderColor = UIColor.instrumentLabel.cgColor
            } else {
                highScoreLabel.text = "Locked"
                highScoreLabel.textColor = .systemRed
                instrumentLabel.textColor = .systemRed
                self.layer.borderColor = UIColor.systemRed.cgColor
            }
        }
    }
    
    
    //Images and names to be shown
   private func returnInstrumentImage(id:Int)->UIImage {
        switch id {
        case 0: return UIImage(named: "basicPiano")!
        case 1: return UIImage(named: "grandpiano")!
        case 2: return UIImage(named: "AcousticGuitar")!
        case 3: return UIImage(named: "grandpiano")!
        case 4: return UIImage(named: "violin")!
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

