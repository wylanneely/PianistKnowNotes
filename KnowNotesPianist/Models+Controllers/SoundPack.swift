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

let BasicPianoPack = SoundPack(name: "BasicPiano", type: .BasicPiano, A: FPiano_A, AS: FPiano_AS, B: FPiano_B, C: FPiano_C, CS: FPiano_CS, D: FPiano_D, DS: FPiano_DS, E: FPiano_E, F: FPiano_F, FS: FPiano_FS, G: FPiano_G, GS: FPiano_GS)
//let GrandPianoPack = SoundPack

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
//MARK: - BasicPiano
let FPiano_A = Note(note: "FPiano_A", noteID: 0, soundFileName: "FPiano-ANote")
let FPiano_AS = Note(note: "FPiano_AS", noteID: 1, soundFileName: "FPiano-ASNote")
let FPiano_B = Note(note: "FPiano_B", noteID: 2, soundFileName: "FPiano-BNote")
let FPiano_C = Note(note: "FPiano_C", noteID: 3, soundFileName: "FPiano-CNote")
let FPiano_CS = Note(note: "FPiano_CS", noteID: 4, soundFileName: "FPiano-CSNote")
let FPiano_D = Note(note: "FPiano_D", noteID: 5, soundFileName: "FPiano-DNote")
let FPiano_DS = Note(note: "FPiano_DS", noteID: 6, soundFileName: "FPiano-DSNote")
let FPiano_E = Note(note: "FPiano_E", noteID: 7, soundFileName: "FPiano-ENote")
let FPiano_F = Note(note: "FPiano_F", noteID: 8, soundFileName: "FPiano-FNote")
let FPiano_FS = Note(note: "FPiano_FS", noteID: 9, soundFileName: "FPiano-FSNote")
let FPiano_G = Note(note: "FPiano_G", noteID: 10, soundFileName: "FPiano-GNote")
let FPiano_GS = Note(note: "FPiano_GS", noteID: 11, soundFileName: "FPiano-GSNote")

//MARK: - GrandPiano
let A_GrandPiano = Note(note: "A_GrandPiano", noteID: 0, soundFileName: "A_GrandPiano_Test")
let AS_GrandPiano = Note(note: "AS_GrandPiano", noteID: 1, soundFileName: "AS_GrandPiano_Test")
let B_GrandPiano = Note(note: "B_GrandPiano", noteID: 2, soundFileName: "B_GrandPiano_Test")
let C_GrandPiano = Note(note: "C_GrandPiano", noteID: 3, soundFileName: "C_GrandPiano_Test")
let CS_GrandPiano = Note(note: "CS_GrandPiano", noteID: 4, soundFileName: "CS_GrandPiano_Test")
let D_GrandPiano = Note(note: "D_GrandPiano", noteID: 5, soundFileName: "D_GrandPiano_Test")
let DS_GrandPiano = Note(note: "DS_GrandPiano", noteID: 6, soundFileName: "DS_GrandPiano_Test")
let E_GrandPiano = Note(note: "E_GrandPiano", noteID: 7, soundFileName: "E_GrandPiano_Test")
//let F_GrandPiano = Note(note: "F_GrandPiano", noteID: 8, soundFileName: "F_GrandPiano_Test")
let FS_GrandPiano = Note(note: "FS_GrandPiano", noteID: 9, soundFileName: "FS_GrandPiano_Test")
let G_GrandPiano = Note(note: "G_GrandPiano", noteID: 10, soundFileName: "G_GrandPiano_Test")
let GS_GrandPiano = Note(note: "GS_GrandPiano", noteID: 11, soundFileName: "GS_GrandPiano_Test")
