//
//  GameController.swift
//  KnowNotesPianist
//
//  Created by Wylan L Neely on 3/21/24.
//

import Foundation

class Game {
    
    let gameType: GameType
    var lifes: Int = 5
    var score: Int = 0
    
    var currentNoteID: Int?
    
    //to make sure a note doesnt get pulled twice in a row
    var lastNoteID: Int?
    
    init(gameType: GameType) {
        self.gameType = gameType
    }
    
    var noteNumber: Int {
        switch gameType {
        case .Novice:
            return 3
        case .Regular:
            return 5
        case .Pianist:
            return 7
        case .Virtuoso:
            return 12
        }
    }
    
    func generateNote()->Int{
        if currentNoteID == currentNoteID {
            lastNoteID = currentNoteID
        }
        if lastNoteID == nil {
           let noteID = randomNoteFrom(noteNumber: noteNumber)
            currentNoteID = noteID
            return noteID
        }
        //add feature to make sure last note is not pulled 2x in a row
        let noteID = randomNoteFrom(noteNumber: noteNumber)
         currentNoteID = noteID
         return noteID
    }
    
    private func randomNoteFrom(noteNumber: Int)->Int{
        let randomInt = Int.random(in: 0..<noteNumber)
        return randomInt
    }
    
    
    
}

struct GameController {
    
    var currentGame: Game
    let gameType: GameType
    
    init(gameType: GameType) {
        self.gameType = gameType
        let newGame = Game(gameType: gameType)
        self.currentGame = newGame
    }
    
    mutating func restartGame(){
        let newGame = Game(gameType: self.gameType)
        self.currentGame = newGame
    }
    
    
    
    
}

enum GameType{
    case Novice
    case Regular
    case Pianist
    case Virtuoso
}

enum NoteID: Int {
    case A = 0
    case B = 1
    case C = 2
    case D = 3
    case E = 4
    case F = 5
    case G = 6
    case AS = 7
    case CS = 8
    case DS = 9
    case FS = 10
    case GS = 11
}
