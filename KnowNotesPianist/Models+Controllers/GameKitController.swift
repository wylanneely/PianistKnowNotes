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
    
    func submitBasicPianoScore(score:Int) {
        GKLeaderboard.submitScore(score, context: 0, player: GKLocalPlayer.local, leaderboardIDs: [basicPianoLID]) { error in
            if let error {
                print(error.localizedDescription.localizedLowercase)
            }
        }
    }
    
}
