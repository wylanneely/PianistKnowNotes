//
//  GameController.swift
//  KnowNotesPianist
//
//  Created by Wylan L Neely on 3/21/24.
//

import Foundation

class Game {
    
    var gameType: GameType
    var lifes: Int = 5
    var score: Int = 0
    
    var currentNoteID: Int?
    
    //to make sure a note doesnt get pulled twice in a row
    var lastNoteID: Int?
    
    init(gameType: GameType) {
        self.gameType = gameType
        shuffledNovice.shuffle()
        shuffledPianist.shuffle()
        shuffledRegular.shuffle()
        shuffledVirtuoso.shuffle()
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
        //self.lastNoteID = self.currentNoteID
       // let nextNoteID = randomNoteID(upTo: noteNumber, excludingValue: lastNoteID)
//        let nextNoteID = randomNoteID(upTo: noteNumber)
//        self.currentNoteID = nextNoteID
        let nextNoteID = generateShuffledNote()
        self.currentNoteID = nextNoteID
        return nextNoteID
    }
    
//   private func randomNoteID(upTo noteNumber: Int, excludingValue excludedNoteID: Int?) -> Int {
//        let noteNumberID = (noteNumber - 1)
//        
//        if let excludedNoteID = excludedNoteID {
//            var randomValue: Int
//            repeat {
//                randomValue = Int.random(in: 0...noteNumberID)
//            } while randomValue == excludedNoteID
//            
//            return randomValue
//        } else {
//            return Int.random(in: 0...noteNumberID)
//        }
//    }
    
    private var noviceExcludedNotes = [Int]()
    private var regularExcludedNotes = [Int]()
    private var pianistExcludedNotes = [Int]()
    private var virtuosoExcludedNotes = [Int]()
    
    private var shuffledNovice = [0,1,2]
    private var shuffledRegular = [0,1,2,3,4]
    private var shuffledPianist = [0,1,2,3,4,5,6]
    private var shuffledVirtuoso = [0,1,2,3,4,5,6,7,8,9,10,11]
    private var shuffledIteration = 0
     
    private func generateShuffledNote() -> Int {
        switch gameType {
        case .Novice:
            if shuffledIteration == 2 {
                let note = shuffledNovice[shuffledIteration]
                shuffledNovice.shuffle()
                shuffledIteration = 0
                return note
            } else {
                let note = shuffledNovice[shuffledIteration]
                shuffledIteration = shuffledIteration + 1
                return note
            }
        case .Regular:
            if shuffledIteration == 4 {
                let note = shuffledRegular[shuffledIteration]
                shuffledRegular.shuffle()
                shuffledIteration = 0
                return note
            } else {
                let note = shuffledRegular[shuffledIteration]
                shuffledIteration = shuffledIteration + 1
                return note
            }
        case .Pianist:
            if shuffledIteration == 6 {
                let note = shuffledPianist[shuffledIteration]
                shuffledPianist.shuffle()
                shuffledIteration = 0
                return note
            } else {
                let note = shuffledPianist[shuffledIteration]
                shuffledIteration = shuffledIteration + 1
                return note
            }
        case .Virtuoso:
            if shuffledIteration == 11 {
                let note = shuffledVirtuoso[shuffledIteration]
                shuffledVirtuoso.shuffle()
                shuffledIteration = 0
                return note
            } else {
                let note = shuffledVirtuoso[shuffledIteration]
                shuffledIteration = shuffledIteration + 1
                return note
            }
        }
        
    }
    
    private func randomNoteID(upTo noteNumber: Int) -> Int {
         let noteNumberID = (noteNumber - 1)
        
        switch gameType {
        case .Novice:
            var randomValue: Int
            if noviceExcludedNotes.count < noteNumber {
                repeat {
                    randomValue = Int.random(in: 0...noteNumberID)
                } while noviceExcludedNotes.contains(randomValue)
                noviceExcludedNotes.append(randomValue)
                return randomValue
            } else {
                randomValue = Int.random(in: 0...noteNumberID)
                noviceExcludedNotes = [randomValue]
                return randomValue
            }
            
        case .Regular:
            var randomValue: Int
            if regularExcludedNotes.count < noteNumber {
                repeat {
                    randomValue = Int.random(in: 0...noteNumberID)
                } while regularExcludedNotes.contains(randomValue)
                regularExcludedNotes.append(randomValue)
                return randomValue
            } else {
                randomValue = Int.random(in: 0...noteNumberID)
                regularExcludedNotes = [randomValue]
                return randomValue
            }
            
        case .Pianist:
            var randomValue: Int
            if pianistExcludedNotes.count < noteNumber {
                repeat {
                    randomValue = Int.random(in: 0...noteNumberID)
                } while pianistExcludedNotes.contains(randomValue)
                pianistExcludedNotes.append(randomValue)
                return randomValue
            } else {
                randomValue = Int.random(in: 0...noteNumberID)
                pianistExcludedNotes = [randomValue]
                return randomValue
            }
            
        case .Virtuoso:
            var randomValue: Int
            if virtuosoExcludedNotes.count < noteNumber {
                repeat {
                    randomValue = Int.random(in: 0...noteNumberID)
                } while virtuosoExcludedNotes.contains(randomValue)
                virtuosoExcludedNotes.append(randomValue)
                return randomValue
            } else {
                randomValue = Int.random(in: 0...noteNumberID)
                virtuosoExcludedNotes = [randomValue]
                return randomValue
            }
        }
         
     }
    
    func restart(){
        self.score = 0
        self.lifes = 5
        self.shuffledIteration = 0
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
    
    mutating func setGame(game:Game){
        self.currentGame = game
    }
    
    func returnGameStats()->(score:Int, lifes:Int) {
        return (score:currentGame.score,lifes:currentGame.lifes)
    }
    
    
}

enum GameType: String, Codable{
    case Novice
    case Regular
    case Pianist
    case Virtuoso
}

//enum NoteID: Int {
//    case A = 0
//    case B = 1
//    case C = 2
//    case D = 3
//    case E = 4
//    case F = 5
//    case G = 6
//    case AS = 7
//    case CS = 8
//    case DS = 9
//    case FS = 10
//    case GS = 11
//}
