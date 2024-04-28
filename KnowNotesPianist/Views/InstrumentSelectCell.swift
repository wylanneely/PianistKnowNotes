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
    
    //MARK: - Localized Strings
    
    private var language: String = NSLocalizedString("AppLanguage", comment: "to help adjust certain views/settings")
    
   private let highscoreString =  NSLocalizedString("High Score",comment: "high score label")
   private let lockedString = NSLocalizedString("Locked", comment: "locked label")
    private let basicPianoString =  NSLocalizedString("Basic Piano",comment: "")
    private let grandPianoString =  NSLocalizedString("Grand Piano",comment: "")
    private let acousticString =  NSLocalizedString("Acoustic Guitar",comment: "")
    private let keyboardString =  NSLocalizedString("Keyboard",comment: "")
    private let violinString =  NSLocalizedString("Violin",comment: "")
    
    
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
        self.layer.borderWidth = 3
        
        instrumentLabel.font = UIFont(name: "Poppins-Bold", size: 36)
        highScoreLabel.font = UIFont(name: "Poppins-Bold", size: 33)

    }
    
    private func setHSLabelText(score:Int){
        if language == "Chinese" {
            let cHS = score.returnIntAsChinese()
            highScoreLabel.text = highscoreString + cHS
        } else {
            highScoreLabel.text = highscoreString + " \(score)"
        }
    }
    
    func setUpLabels(){
        
        switch instrumentType {
        case .BasicPiano:
            let hs = AchievementesController().getFreePianoHighScore()
            setHSLabelText(score: hs)
            highScoreLabel.textColor =  UIColor.instrumentLabel
            instrumentLabel.textColor = UIColor.instrumentLabel
            self.layer.borderColor = UIColor.unlockedBorder.cgColor
        case .GrandPiano:
            if AchievementesController().isGrandPianoNoviceUnlocked() {
                let hs = AchievementesController().getGrandPianoHighScore()
                setHSLabelText(score: hs)
                highScoreLabel.textColor =  UIColor.instrumentLabel
                instrumentLabel.textColor = UIColor.instrumentLabel
                self.layer.borderColor = UIColor.unlockedBorder.cgColor

            } else {
                highScoreLabel.text = lockedString
                highScoreLabel.textColor = UIColor.lockedBorder
                instrumentLabel.textColor = UIColor.lockedBorder
                self.layer.borderColor = UIColor.lockedBorder.cgColor
            }
        case .AcousticGuitar:
            if AchievementesController().isAcousticNoviceUnlocked() {
                let hs = AchievementesController().getAcousticHighScore()
                setHSLabelText(score: hs)
                highScoreLabel.textColor =  UIColor.instrumentLabel
                instrumentLabel.textColor = UIColor.instrumentLabel
                self.layer.borderColor = UIColor.unlockedBorder.cgColor

            } else {
                highScoreLabel.text = lockedString
                highScoreLabel.textColor = UIColor.lockedBorder
                instrumentLabel.textColor = UIColor.lockedBorder
                self.layer.borderColor = UIColor.lockedBorder.cgColor
            }
        case .Keyboard:
            if AchievementesController().isKeyboardNoviceUnlocked() {
                let hs = AchievementesController().getKeyboardHighScore()
                setHSLabelText(score: hs)
                highScoreLabel.textColor =  UIColor.instrumentLabel
                instrumentLabel.textColor = UIColor.instrumentLabel
                self.layer.borderColor = UIColor.unlockedBorder.cgColor
            } else {
                highScoreLabel.text = lockedString
                highScoreLabel.textColor = UIColor.lockedBorder
                instrumentLabel.textColor = UIColor.lockedBorder
                self.layer.borderColor = UIColor.lockedBorder.cgColor
            }
        case .Violin:
            if AchievementesController().isViolinNoviceUnlocked() {
                let hs = AchievementesController().getViolinHighScore()
                setHSLabelText(score: hs)
                highScoreLabel.textColor =  UIColor.instrumentLabel
                instrumentLabel.textColor = UIColor.instrumentLabel
                self.layer.borderColor = UIColor.unlockedBorder.cgColor
            } else {
                highScoreLabel.text = lockedString
                highScoreLabel.textColor = UIColor.lockedBorder
                instrumentLabel.textColor = UIColor.lockedBorder
                self.layer.borderColor = UIColor.lockedBorder.cgColor
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
        case 0: return basicPianoString
        case 1: return grandPianoString
        case 2: return acousticString
        case 3: return keyboardString
        case 4: return violinString
        default:
            return basicPianoString
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

