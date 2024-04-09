//
//  AchievementsController.swift
//  KnowNotesPianist
//
//  Created by Wylan L Neely on 4/6/24.
//

import Foundation


struct AchievementesController {
    
    //MARK: Local GamePlay
    
    let defaults = UserDefaults.standard
    
    
    //MARK: Free Piano
    
    
    //MARK: - Set
    
    func setFreePiano(highScore:Int) {
        guard let oldHS = defaults.object(forKey: kHighScoreFreePiano) as? Int else { 
            defaults.setValue(highScore, forKey: kHighScoreFreePiano)
            return
        }
        
        if highScore > oldHS {
            defaults.setValue(highScore, forKey: kHighScoreFreePiano)
        }
        
    }
    
    func unlockFreePianoRegular(){
            defaults.setValue(true, forKey: kFreePianoRegular)
    }
    func unlockFreePianoPianist(){
            defaults.setValue(true, forKey: kFreePianoPianist)
    }
    func unlockFreePianoVirtuoso(){
            defaults.setValue(true, forKey: kFreePianoVirtuoso)
    }
    
    //MARK: - Gets
    
    func getFreePianoHighScore()->Int{
        if let highScore = defaults.object(forKey: kHighScoreFreePiano) as? Int {
            return highScore
        } else {
            return 0
        }
    }
    
    func isFreePianoRegularUnlocked()->Bool {
        if defaults.bool(forKey: kFreePianoRegular) == true {
            return true
        } else {
            return false
        }
    }
    
    func isFreePianoPianistUnlocked()->Bool {
        if defaults.bool(forKey: kFreePianoPianist) == true {
            return true
        } else {
            return false
        }
    }
    
    func isFreePianoVirtuosoUnlocked()->Bool {
        if defaults.bool(forKey: kFreePianoVirtuoso) == true {
            return true
        } else {
            return false
        }
    }
    
    //MARK: Local Keys
    
    fileprivate let kFreePianoRegular = "FreePianoRegular"
    fileprivate let kFreePianoPianist = "FreePianoPianist"
    fileprivate let kFreePianoVirtuoso = "FreePianoVirtuoso"


    fileprivate let kAcousticGuitarRound1 = "AcousticGuitarRound1"
    fileprivate let kAcousticGuitarRound2 = "AcousticGuitarRound2"
        
    fileprivate let kViolinRound1 = "ViolinRound1"
    fileprivate let kViolinRound2 = "ViolinRound2"
        
    fileprivate let kSaxRound1 = "SaxRound1"
    fileprivate let kSaxRound2 = "SaxRound2"
       
    fileprivate let kHighScoreFreePiano = "FreePianoHS"
    fileprivate let kHighScoreAGuitar = "AcousticGuitarHS"
    fileprivate let kHighScoreViolin = "ViolinHS"
    fileprivate let kHighScoreSaxaphone = "SaxaphoneHS"
}
