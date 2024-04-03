//
//  InstrumentSelectCell.swift
//  KnowNotesPianist
//
//  Created by Wylan L Neely on 4/1/24.
//

import UIKit

class InstrumentSelectCell: UICollectionViewCell {
    
    var instrumentID: Int = 0
    
    //MARK: - Outlets
    
    @IBOutlet weak var instrumentImage: UIImageView!
    @IBOutlet weak var instrumentLabel: UILabel!
    
    
    //MARK: - Setup
        
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpVariables()
        setUpGradientColorLabel()
    }
    
    func setUpVariables(){
        let backGroundImage = returnInstrumentImage(id: self.instrumentID)
        instrumentImage.image = backGroundImage
        let labelText = returnLabelText(id: self.instrumentID)
        instrumentLabel.text = labelText
    }
    
    func setUpGradientColorLabel(){
        let labelColor = UIColor(named:"LabelColor")!
        instrumentLabel.textColor = labelColor
    }
    
    
    //Images and names to be shown
    func returnInstrumentImage(id:Int)->UIImage {
        switch id {
        case 0: return UIImage(named: "grandpiano")!
        case 1: return UIImage(named: "grandpiano")!
        case 2: return UIImage(named: "grandpiano")!
        default:
            return UIImage(named: "grandpiano")!
        }
    }
    
    func returnLabelText(id:Int)->String{
        switch id {
        case 0: return InstrumentCollectionName.FreePiano.rawValue
        case 1: return InstrumentCollectionName.GrandPiano.rawValue
        case 2: return InstrumentCollectionName.Keyboard.rawValue
        default:
            return "Piano"
        }
    }

}

enum InstrumentCollectionName: String {
    case FreePiano = "Free Piano"
    case GrandPiano = "Grand Piano"
    case Keyboard = "Keyboard"
}

