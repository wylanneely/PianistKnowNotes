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
let GrandPianoPack = SoundPack(name: "GrandPiano", type: .GrandPiano, A: A_GrandPiano, AS: AS_GrandPiano, B: B_GrandPiano, C: C_GrandPiano, CS: CS_GrandPiano, D: D_GrandPiano, DS: DS_GrandPiano, E: E_GrandPiano, F: F_GrandPiano, FS: FS_GrandPiano, G: G_GrandPiano, GS: GS_GrandPiano)
let ViolinPack = SoundPack(name: "Violin", type: .Violin, A: A_Violin, AS: AS_Violin, B: B_Violin, C: C_Violin, CS: CS_Violin, D: D_Violin, DS: DS_Violin, E: E_Violin, F: F_Violin, FS: FS_Violin, G: G_Violin, GS: GS_Violin)
let KeyboardPack = SoundPack(name: "Keyboard", type: .Keyboard, A: A_Keyboard, AS: AS_Keyboard, B: B_Keyboard, C: C_Keyboard, CS: CS_Keyboard, D: D_Keyboard, DS: DS_Keyboard, E: E_Keyboard, F: F_Keyboard, FS: FS_Keyboard, G: G_Keyboard, GS: GS_Keyboard)

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
let F_GrandPiano = Note(note: "F_GrandPiano", noteID: 8, soundFileName: "F_GrandPiano_Test")
let FS_GrandPiano = Note(note: "FS_GrandPiano", noteID: 9, soundFileName: "FS_GrandPiano_Test")
let G_GrandPiano = Note(note: "G_GrandPiano", noteID: 10, soundFileName: "G_GrandPiano_Test")
let GS_GrandPiano = Note(note: "GS_GrandPiano", noteID: 11, soundFileName: "GS_GrandPiano_Test")

//MARK: - Violin
let A_Violin = Note(note: "A_Violin", noteID: 0, soundFileName: "A_Violin")
let AS_Violin = Note(note: "AS_Violin", noteID: 1, soundFileName: "AS_Violin")
let B_Violin = Note(note: "B_Violin", noteID: 2, soundFileName: "B_Violin")
let C_Violin = Note(note: "C_Violin", noteID: 3, soundFileName: "C_Violin")
let CS_Violin = Note(note: "CS_Violin", noteID: 4, soundFileName: "CS_Violin")
let D_Violin = Note(note: "D_Violin", noteID: 5, soundFileName: "D_Violin")
let DS_Violin = Note(note: "DS_Violin", noteID: 6, soundFileName: "DS_Violin")
let E_Violin = Note(note: "E_Violin", noteID: 7, soundFileName: "E_Violin")
let F_Violin = Note(note: "F_Violin", noteID: 8, soundFileName: "F_Violin")
let FS_Violin = Note(note: "FS_Violin", noteID: 9, soundFileName: "FS_Violin")
let G_Violin = Note(note: "G_Violin", noteID: 10, soundFileName: "G_Violin")
let GS_Violin = Note(note: "GS_Violin", noteID: 11, soundFileName: "GS_Violin")

//MARK: - Keyboard

let A_Keyboard = Note(note: "A_Keyboard", noteID: 0, soundFileName: "A_Keyboard")
let AS_Keyboard = Note(note: "AS_Keybord", noteID: 1, soundFileName: "AS_Keyboard")
let B_Keyboard = Note(note: "B_Keyboard", noteID: 2, soundFileName: "B_Keyboard")
let C_Keyboard = Note(note: "C_Keyboard", noteID: 3, soundFileName: "C_Keyboard")
let CS_Keyboard = Note(note: "CS_Keyboard", noteID: 4, soundFileName: "CS_Keyboard")
let D_Keyboard = Note(note: "D_Keyboard", noteID: 5, soundFileName: "D_Keyboard")
let DS_Keyboard = Note(note: "DS_Keyboard", noteID: 6, soundFileName: "DS_Keyboard")
let E_Keyboard = Note(note: "E_Keyboard", noteID: 7, soundFileName: "E_Keyboard")
let F_Keyboard = Note(note: "F_Keyboard", noteID: 8, soundFileName: "F_Keyboard")
let FS_Keyboard = Note(note: "FS_Keyboard", noteID: 9, soundFileName: "FS_Keyboard")
let G_Keyboard = Note(note: "G_Keyboard", noteID: 10, soundFileName: "G_Keyboard")
let GS_Keyboard = Note(note: "GS_Keyboard", noteID: 11, soundFileName: "GS_Keyboard")

//MARK: Maj AccGuitar

let AMaj_AGuitar = Note(note: "AMaj_AGuitar", noteID: 0, soundFileName: "AMaj_AccGuitar")
let BMaj_AGuitar = Note(note: "BMaj_AGuitar", noteID: 2, soundFileName: "BMaj_AccGuitar")
let CMaj_AGuitar = Note(note: "CMaj_AGuitar", noteID: 3, soundFileName: "CMaj_AccGuitar")
let DMaj_AGuitar = Note(note: "DMaj_AGuitar", noteID: 5, soundFileName: "DMaj_AccGuitar")
let EMaj_AGuitar = Note(note: "EMaj_AGuitar", noteID: 7, soundFileName: "EMaj_AccGuitar")
let FMaj_AGuitar = Note(note: "FMaj_AGuitar", noteID: 8, soundFileName: "FMaj_AccGuitar")
let GMaj_AGuitar = Note(note: "GMaj_AGuitar", noteID: 10, soundFileName: "GMaj_AccGuitar")
