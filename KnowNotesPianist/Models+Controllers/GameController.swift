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
    
//    func generateNote()->Int{
//        if currentNoteID == currentNoteID {
//            lastNoteID = currentNoteID
//        }
//        if lastNoteID == nil {
//           let noteID = randomNoteFrom(noteNumber: noteNumber)
//            currentNoteID = noteID
//            return noteID
//        }
//        //add feature to make sure last note is not pulled 2x in a row
//        let noteID = randomNoteFrom(noteNumber: noteNumber)
//         currentNoteID = noteID
//         return noteID
//    }
    
    //updatesScore,lifes and returns if answer is correct and if game is over
    func updateGameWith(noteAnswerID:Int)->(isCorrect:Bool, isGameOver:Bool){
        if noteAnswerID == currentNoteID {
            self.score = (score + 1)
            return (isCorrect:true, isGameOver:false)
        } else {
            self.lifes = (lifes - 1)
            if lifes == 0 {
                return (isCorrect:false, isGameOver:true)
            } else {
                return (isCorrect:false, isGameOver:false)
            }
        }
        
    }
    
    func generateNextNoteID()->Int{
        self.lastNoteID = self.currentNoteID
        let nextNoteID = randomNoteID(upTo: noteNumber, excludingValue: lastNoteID)
        self.currentNoteID = nextNoteID
        return nextNoteID
    }
    
   private func randomNoteID(upTo noteNumber: Int, excludingValue excludedNoteID: Int?) -> Int {
        let noteNumberID = (noteNumber - 1)
        
        if let excludedNoteID = excludedNoteID {
            var randomValue: Int
            repeat {
                randomValue = Int.random(in: 0...noteNumberID)
            } while randomValue == excludedNoteID
            
            return randomValue
        } else {
            return Int.random(in: 0...noteNumberID)
        }
    }
    
    func restart(){
        self.score = 0
        self.lifes = 5
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
    self.currentGame.restart()
    }
    
   mutating func generateNextNoteID()-> Int {
       return self.currentGame.generateNextNoteID()
    }
    
   mutating func updateGameWith(noteAnswerID:Int)->(isCorrect:Bool, isGameOver:Bool){
        
        if noteAnswerID == currentGame.currentNoteID {
            self.currentGame.score = (self.currentGame.score + 1)
            return (isCorrect:true, isGameOver:false)
        } else {
            self.currentGame.lifes = (currentGame.lifes - 1)
            if currentGame.lifes == 0 {
                return (isCorrect:false, isGameOver:true)
            } else {
                return (isCorrect:false, isGameOver:false)
            }
        }
        
    }
    
    func returnGameStats()->(score:Int, lifes:Int) {
        return (score:currentGame.score,lifes:currentGame.lifes)
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
