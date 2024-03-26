//
//  SoundPack.swift
//  KnowNotesPianist
//
//  Created by Wylan L Neely on 3/25/24.
//

import Foundation
import UIKit

//MARK: - SoundPacks

struct SoundPack {
    let name: String
    let type: InstrumentType
    let soundURLs: [Note]
    
    init(name: String, type: InstrumentType,
         A:Note, AS:Note, B:Note, C:Note, CS:Note, D:Note,
         DS:Note, E:Note, F:Note, FS: Note, G:Note, GS:Note ) {
        self.name = name
        self.type = type
        self.soundURLs = [A,AS,B,C,CS,D,DS,E,F,FS,G,GS]
    }
    
}
enum InstrumentType {
    case GrandPiano
    case Piano
    case Keyboard
    case AcousticGuitar
    case Guitar
}

let FreePianoPack = SoundPack(name: "FreePiano", type: .GrandPiano, A: FPiano_A, AS: FPiano_AS, B: FPiano_B, C: FPiano_C, CS: FPiano_CS, D: FPiano_D, DS: FPiano_DS, E: FPiano_E, F: FPiano_F, FS: FPiano_FS, G: FPiano_G, GS: FPiano_GS)

//MARK: - Notes

struct Note {
    let note: String
    let noteID: Int
    let soundFileName: String
    
    var soundURL: URL {
      let filePath =  Bundle.main.path(forResource: soundFileName, ofType: "wav")!
        return URL(filePath: filePath)
    }
    
}
//MARK: - FreePiano
let FPiano_A = Note(note: "FPiano_A", noteID: 0, soundFileName: "FPiano_ANote")
let FPiano_AS = Note(note: "FPiano_AS", noteID: 1, soundFileName: "FPiano_ASNote")
let FPiano_B = Note(note: "FPiano_B", noteID: 2, soundFileName: "FPiano_BNote")
let FPiano_C = Note(note: "FPiano_C", noteID: 3, soundFileName: "FPiano_CNote")
let FPiano_CS = Note(note: "FPiano_CS", noteID: 4, soundFileName: "FPiano_CSNote")
let FPiano_D = Note(note: "FPiano_D", noteID: 5, soundFileName: "FPiano_DNote")
let FPiano_DS = Note(note: "FPiano_DS", noteID: 6, soundFileName: "FPiano_DSNote")
let FPiano_E = Note(note: "FPiano_E", noteID: 7, soundFileName: "FPiano_ENote")
let FPiano_F = Note(note: "FPiano_F", noteID: 8, soundFileName: "FPiano_FNote")
let FPiano_FS = Note(note: "FPiano_FS", noteID: 9, soundFileName: "FPiano_FSNote")
let FPiano_G = Note(note: "FPiano_G", noteID: 10, soundFileName: "FPiano_GNote")
let FPiano_GS = Note(note: "FPiano_GS", noteID: 11, soundFileName: "FPiano_GSNote")

