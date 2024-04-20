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
    private let basicPianoLID = "basicPianoScore"
    private let grandPianoLID = "grandPianoScore"
    private let acousticGuitarLID = "acousticGuitarScore"
    private let keyboardLID = "keyboardScore"
    private let violinLID = "violinScore"
    
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
        }
    }
    
   private func submitBasicPianoScore(score:Int) {
        GKLeaderboard.submitScore(score, context: 0, player: GKLocalPlayer.local, leaderboardIDs: [basicPianoLID]) { error in
            if let error {
                print(error.localizedDescription.localizedLowercase)
            }
        }
    }
    
    private func submitGrandPianoScore(score:Int) {
         GKLeaderboard.submitScore(score, context: 0, player: GKLocalPlayer.local, leaderboardIDs: [grandPianoLID]) { error in
             if let error {
                 print(error.localizedDescription.localizedLowercase)
             }
         }
     }
    
    private func submitAcousticGuitarScore(score:Int) {
         GKLeaderboard.submitScore(score, context: 0, player: GKLocalPlayer.local, leaderboardIDs: [acousticGuitarLID]) { error in
             if let error {
                 print(error.localizedDescription.localizedLowercase)
             }
         }
     }
    
    private func submitKeyboardScore(score:Int) {
         GKLeaderboard.submitScore(score, context: 0, player: GKLocalPlayer.local, leaderboardIDs: [keyboardLID]) { error in
             if let error {
                 print(error.localizedDescription.localizedLowercase)
             }
         }
     }
    
    private func submitViolinScore(score:Int) {
         GKLeaderboard.submitScore(score, context: 0, player: GKLocalPlayer.local, leaderboardIDs: [violinLID]) { error in
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
