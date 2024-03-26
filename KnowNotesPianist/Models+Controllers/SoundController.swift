//
//  SoundController.swift
//  KnowNotesPianist
//
//  Created by Wylan L Neely on 3/25/24.
//

import Foundation
import UIKit


struct SoundController {
    
    let soundPack: SoundPack
    let gameType: GameType
    
    func returnSoundPathFrom(noteID:Int)->URL?{
        switch gameType {
            //NOTE: since easier rounds NoteIDs dont correspond directly to NoteID SoundPath,
            // this is to return correct soundpath URLs
        case .Novice:
            switch noteID {
                //A C G
            case 0 : return soundPack.soundURLs[0].soundURL
            case 1 : return soundPack.soundURLs[3].soundURL
            case 2 : return soundPack.soundURLs[10].soundURL
            default: return nil
            }
        case .Regular:
            //A C D E G
            switch noteID {
            case 0 : return soundPack.soundURLs[0].soundURL
            case 1 : return soundPack.soundURLs[3].soundURL
            case 2 : return soundPack.soundURLs[5].soundURL
            case 3 : return soundPack.soundURLs[7].soundURL
            case 4 : return soundPack.soundURLs[10].soundURL
            default: return nil
            }
        case .Pianist:
            //A B C D E F G
            switch noteID {
            case 0 : return soundPack.soundURLs[0].soundURL
            case 1 : return soundPack.soundURLs[2].soundURL
            case 2 : return soundPack.soundURLs[3].soundURL
            case 3 : return soundPack.soundURLs[5].soundURL
            case 4 : return soundPack.soundURLs[7].soundURL
            case 5 : return soundPack.soundURLs[8].soundURL
            case 6 : return soundPack.soundURLs[10].soundURL
            default: return nil
            }
        case .Virtuoso:
            // all + sharps
            switch noteID {
            case 0 : return soundPack.soundURLs[0].soundURL
            case 1 : return soundPack.soundURLs[1].soundURL
            case 2 : return soundPack.soundURLs[2].soundURL
            case 3 : return soundPack.soundURLs[3].soundURL
            case 4 : return soundPack.soundURLs[4].soundURL
            case 5 : return soundPack.soundURLs[5].soundURL
            case 6 : return soundPack.soundURLs[6].soundURL
            case 7 : return soundPack.soundURLs[7].soundURL
            case 8 : return soundPack.soundURLs[8].soundURL
            case 9 : return soundPack.soundURLs[9].soundURL
            case 10: return soundPack.soundURLs[10].soundURL
            case 11: return soundPack.soundURLs[11].soundURL
            default: return nil
            }
        }
            
        
    }
    
}


