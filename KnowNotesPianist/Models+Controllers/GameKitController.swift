//
//  GameKitController.swift
//  KnowNotesPianist
//
//  Created by Wylan L Neely on 4/18/24.
//

import Foundation
import GameKit

struct GameKitController {
    
    //MARK: - Identifiers
    private let basicPianoLID = "knowNotes.BasicPianoScore"
    private let grandPianoLID = "knowNotes.GrandPianoHighScore"
    private let acousticGuitarLID = "knowNotes.GuitarMajorChords"
    private let keyboardLID = "knowNotes.KeyboardNotesHighScore"
    private let violinLID = "knowNotes.ViolinNotesHighScore"
    private let acousticMinorLID = "knowNotes.AcousticMinorChordsHighScore"
    
    //MARK: - Submit
    
    func submitLeaderboard(score: Int, instrument:InstrumentType){
        switch instrument {
        case .BasicPiano:
            submitBasicPianoScore(score: score)
        case .GrandPiano:
            submitGrandPianoScore(score: score)
        case .AcousticGuitar:
            submitAcousticGuitarScore(score: score)
        case .Keyboard:
            submitKeyboardScore(score: score)
        case .Violin:
            submitViolinScore(score: score)
        case .AcousticMinor:
            submitAcousticMinorScore(score: score)
        }
    }
    
   private func submitBasicPianoScore(score:Int) {
       AchievementesController().setFreePiano(highScore: score)
        GKLeaderboard.submitScore(score, context: 0, player: GKLocalPlayer.local, leaderboardIDs: [basicPianoLID]) { error in
            if let error {
                print(error.localizedDescription.localizedLowercase)
            }
        }
    }
    
    private func submitGrandPianoScore(score:Int) {
        AchievementesController().setGrandPiano(highScore: score)
         GKLeaderboard.submitScore(score, context: 0, player: GKLocalPlayer.local, leaderboardIDs: [grandPianoLID]) { error in
             if let error {
                 print(error.localizedDescription.localizedLowercase)
             }
         }
     }
    
    private func submitAcousticGuitarScore(score:Int) {
        AchievementesController().setAcoustic(highScore: score)
         GKLeaderboard.submitScore(score, context: 0, player: GKLocalPlayer.local, leaderboardIDs: [acousticGuitarLID]) { error in
             if let error {
                 print(error.localizedDescription.localizedLowercase)
             }
         }
     }
    
    private func submitKeyboardScore(score:Int) {
        AchievementesController().setKeyboard(highScore: score)
         GKLeaderboard.submitScore(score, context: 0, player: GKLocalPlayer.local, leaderboardIDs: [keyboardLID]) { error in
             if let error {
                 print(error.localizedDescription.localizedLowercase)
             }
         }
     }
    
    private func submitViolinScore(score:Int) {
        AchievementesController().setViolin(highScore: score)
         GKLeaderboard.submitScore(score, context: 0, player: GKLocalPlayer.local, leaderboardIDs: [violinLID]) { error in
             if let error {
                 print(error.localizedDescription.localizedLowercase)
             }
         }
     }
    
    private func submitAcousticMinorScore(score:Int) {
        AchievementesController().setAcousticMinor(highScore: score)
         GKLeaderboard.submitScore(score, context: 0, player: GKLocalPlayer.local, leaderboardIDs: [acousticMinorLID]) { error in
             if let error {
                 print(error.localizedDescription.localizedLowercase)
             }
         }
     }
    
    
    //MARK: GKAccessPoint
    
    func showGKAccessPoint(){
        GKAccessPoint.shared.location = .topLeading
        GKAccessPoint.shared.isActive = true
    }
    
    func hideGKAcessPoint(){
        GKAccessPoint.shared.isActive = false
    }
    
}
