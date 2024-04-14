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
        case 0: return InstrumentType.FreePiano
        case 1: return InstrumentType.GrandPiano
        case 2: return InstrumentType.AcousticGuitar
        case 3: return InstrumentType.Keyboard
        default: return InstrumentType.FreePiano
        }
    }
    
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
   private func returnInstrumentImage(id:Int)->UIImage {
        switch id {
        case 0: return UIImage(named: "grandpiano")!
        case 1: return UIImage(named: "grandpiano")!
        case 2: return UIImage(named: "grandpiano")!
        case 3: return UIImage(named: "grandpiano")!
        default:
            return UIImage(named: "grandpiano")!
        }
    }
    
   private func returnLabelText(id:Int)->String{
        switch id {
        case 0: return InstrumentTypeName.FreePiano.rawValue
        case 1: return InstrumentTypeName.GrandPiano.rawValue
        case 2: return InstrumentTypeName.AcousticGuitar.rawValue
        case 3: return InstrumentTypeName.Keyboard.rawValue
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

