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
        
    //MARK: - Set
    //FreePiano
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
    //GrandPiano
    func setGrandPiano(highScore:Int) {
        guard let oldHS = defaults.object(forKey: kHighScoreGrandPiano) as? Int else {
            defaults.setValue(highScore, forKey: kHighScoreGrandPiano)
            return
        }
        if highScore > oldHS {
            defaults.setValue(highScore, forKey: kHighScoreGrandPiano)
        }
    }
    func unlockGrandPianoNovice(){
            defaults.setValue(true, forKey: kGrandPianoNovice)
    }
    func unlockGrandPianoRegular(){
            defaults.setValue(true, forKey: kGrandPianoRegular)
    }
    func unlockGrandPianoPianist(){
            defaults.setValue(true, forKey: kGrandPianoPianist)
    }
    func unlockGrandPianoVirtuoso(){
            defaults.setValue(true, forKey: kGrandPianoVirtuoso)
    }
    //Acoustic
    func setAcoustic(highScore:Int) {
        guard let oldHS = defaults.object(forKey: kHighScoreAGuitar) as? Int else {
            defaults.setValue(highScore, forKey: kHighScoreAGuitar)
            return
        }
        if highScore > oldHS {
            defaults.setValue(highScore, forKey: kHighScoreAGuitar)
        }
    }
    func unlockAcousticNovice(){
            defaults.setValue(true, forKey: kAcousticNovice)
    }
    func unlockAcousticRegular(){
            defaults.setValue(true, forKey: kAcousticRegular)
    }
    func unlockAcousticPianist(){
            defaults.setValue(true, forKey: kAcousticPianist)
    }
    func unlockAcousticVirtuoso(){
            defaults.setValue(true, forKey: kAcousticVirtuoso)
    }
    //Keyboard
    func setKeyboard(highScore:Int) {
        guard let oldHS = defaults.object(forKey: kHighScoreKeyboard) as? Int else {
            defaults.setValue(highScore, forKey: kHighScoreKeyboard)
            return
        }
        if highScore > oldHS {
            defaults.setValue(highScore, forKey: kHighScoreKeyboard)
        }
    }
    func unlockKeyboardNovice(){
            defaults.setValue(true, forKey: kKeyboardNovice)
    }
    func unlockKeyboardRegular(){
            defaults.setValue(true, forKey: kKeyboardRegular)
    }
    func unlockKeyboardPianist(){
            defaults.setValue(true, forKey: kKeyboardPianist)
    }
    func unlockKeyboardVirtuoso(){
            defaults.setValue(true, forKey: kKeyboardVirtuoso)
    }
    //Violin
    func setViolin(highScore:Int) {
        guard let oldHS = defaults.object(forKey: kHighScoreViolin) as? Int else {
            defaults.setValue(highScore, forKey: kHighScoreViolin)
            return
        }
        if highScore > oldHS {
            defaults.setValue(highScore, forKey: kHighScoreViolin)
        }
    }
    func unlockViolinNovice(){
            defaults.setValue(true, forKey: kViolinNovice)
    }
    func unlockViolinRegular(){
            defaults.setValue(true, forKey: kViolinRegular)
    }
    func unlockViolinPianist(){
            defaults.setValue(true, forKey: kViolinPianist)
    }
    func unlockViolinVirtuoso(){
            defaults.setValue(true, forKey: kViolinVirtuoso)
    }
    
    //MARK: - Gets
    //BasicPiano
    func getFreePianoHighScore()->Int{
        if let highScore = defaults.object(forKey: kHighScoreFreePiano) as? Int {
            return highScore
        } else {
            return 0
        }
    }
    func isFreePianoRegularUnlocked()->Bool {
        if defaults.bool(forKey: kFreePianoRegular) == true
            { return true } else { return false }
    }
    func isFreePianoPianistUnlocked()->Bool {
        if defaults.bool(forKey: kFreePianoPianist) == true
            { return true } else { return false }
    }
    func isFreePianoVirtuosoUnlocked()->Bool {
        if defaults.bool(forKey: kFreePianoVirtuoso) == true
            { return true } else { return false }
    }
    //GrandPiano
    func getGrandPianoHighScore()->Int{
        if let highScore = defaults.object(forKey: kHighScoreGrandPiano) as? Int {
            return highScore
        } else {
            return 0
        }
    }
    func isGrandPianoNoviceUnlocked()->Bool {
        if defaults.bool(forKey: kGrandPianoNovice) == true
        { return true } else { return false }
    }
    func isGrandPianoRegularUnlocked()->Bool {
        if defaults.bool(forKey: kGrandPianoRegular) == true
            { return true } else { return false }
    }
    func isGrandPianoPianistUnlocked()->Bool {
        if defaults.bool(forKey: kGrandPianoPianist) == true
            { return true } else { return false }
    }
    func isGrandPianoVirtuosoUnlocked()->Bool {
        if defaults.bool(forKey: kGrandPianoVirtuoso) == true
            { return true } else { return false }
    }
    //Acoustic
    func getAcousticHighScore()->Int{
        if let highScore = defaults.object(forKey: kHighScoreAGuitar) as? Int {
            return highScore
        } else {
            return 0
        }
    }
    func isAcousticNoviceUnlocked()->Bool {
        if defaults.bool(forKey: kAcousticNovice) == true
            { return true } else { return false }
    }
    func isAcousticRegularUnlocked()->Bool {
        if defaults.bool(forKey: kAcousticRegular) == true
            { return true } else { return false }
    }
    func isAcousticPianistUnlocked()->Bool {
        if defaults.bool(forKey: kAcousticPianist) == true
            { return true } else { return false }
    }
    func isAcousticVirtuosoUnlocked()->Bool {
        if defaults.bool(forKey: kAcousticVirtuoso) == true
            { return true } else { return false }
    }
    //Keyboard
    func getKeyboardHighScore()->Int{
        if let highScore = defaults.object(forKey: kHighScoreKeyboard) as? Int {
            return highScore
        } else {
            return 0
        }
    }
    func isKeyboardNoviceUnlocked()->Bool {
        if defaults.bool(forKey: kKeyboardNovice) == true
            { return true } else { return false }
    }
    func isKeyboardRegularUnlocked()->Bool {
        if defaults.bool(forKey: kKeyboardRegular) == true
            { return true } else { return false }
    }
    func isKeyboardPianistUnlocked()->Bool {
        if defaults.bool(forKey: kKeyboardPianist) == true
            { return true } else { return false }
    }
    func isKeyboardVirtuosoUnlocked()->Bool {
        if defaults.bool(forKey: kKeyboardVirtuoso) == true {
            return true
        } else {
            return false
        }
    }
    //Violin
    func getViolinHighScore()->Int{
        if let highScore = defaults.object(forKey: kHighScoreViolin) as? Int {
            return highScore
        } else {
            return 0
        }
    }
    func isViolinNoviceUnlocked()->Bool {
        if defaults.bool(forKey: kViolinNovice) == true
            { return true } else { return false }
    }
    func isViolinRegularUnlocked()->Bool {
        if defaults.bool(forKey: kViolinRegular) == true
            { return true } else { return false }
    }
    func isViolinPianistUnlocked()->Bool {
        if defaults.bool(forKey: kViolinPianist) == true
            { return true } else { return false }
    }
    func isViolinVirtuosoUnlocked()->Bool {
        if defaults.bool(forKey: kViolinVirtuoso) == true
        { return true } else { return false }
    }
    
    
    //MARK: Local Keys
    
    fileprivate let kFreePianoRegular = "FreePianoRegular"
    fileprivate let kFreePianoPianist = "FreePianoPianist"
    fileprivate let kFreePianoVirtuoso = "FreePianoVirtuoso"

    fileprivate let kGrandPianoNovice = "GrandPianoNovice"
    fileprivate let kGrandPianoRegular = "GrandPianoRegular"
    fileprivate let kGrandPianoPianist = "GrandPianoPianist"
    fileprivate let kGrandPianoVirtuoso = "GrandPianoVirtuoso"

    fileprivate let kAcousticNovice = "AcousticNovice"
    fileprivate let kAcousticRegular = "AcousticRegular"
    fileprivate let kAcousticPianist = "AcousticPianist"
    fileprivate let kAcousticVirtuoso = "AcousticVirtuoso"

    fileprivate let kKeyboardNovice = "KeyboardNovice"
    fileprivate let kKeyboardRegular = "KeyboardRegular"
    fileprivate let kKeyboardPianist = "KeyboardPianist"
    fileprivate let kKeyboardVirtuoso = "KeyboardVirtuoso"

    fileprivate let kViolinNovice = "ViolinNovice"
    fileprivate let kViolinRegular = "ViolinRegular"
    fileprivate let kViolinPianist = "ViolinPianist"
    fileprivate let kViolinVirtuoso = "ViolinVirtuoso"
    
    fileprivate let kHighScoreFreePiano = "FreePianoHS"
    fileprivate let kHighScoreGrandPiano = "FreeGrandHS"
    fileprivate let kHighScoreAGuitar = "AcousticGuitarHS"
    fileprivate let kHighScoreKeyboard = "KeyboardHS"
    fileprivate let kHighScoreViolin = "ViolinHS"
}
