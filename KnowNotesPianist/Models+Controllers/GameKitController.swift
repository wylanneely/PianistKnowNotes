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
    
    //MARK: - Submit
    
    func submitBasicPianoScore(score:Int) {
        GKLeaderboard.submitScore(score, context: 0, player: GKLocalPlayer.local, leaderboardIDs: [basicPianoLID]) { error in
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
    
    func hiheGKAcessPoint(){
        GKAccessPoint.shared.isActive = false
    }
    
}
