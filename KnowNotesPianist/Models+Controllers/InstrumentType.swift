//
//  InstrumentType.swift
//  KnowNotesPianist
//
//  Created by Wylan L Neely on 4/14/24.
//

import Foundation

enum InstrumentType {
    case BasicPiano
    case GrandPiano
    case AcousticGuitar
    case Keyboard
    case Violin
    case AcousticMinor
}

private let basicPianoString =  NSLocalizedString("Basic Piano",comment: "")
private let grandPianoString =  NSLocalizedString("Grand Piano",comment: "")
private let acousticString =  NSLocalizedString("Acoustic Guitar",comment: "")
private let keyboardString =  NSLocalizedString("Keyboard",comment: "")
private let violinString =  NSLocalizedString("Violin",comment: "")
private let acousticMinor = NSLocalizedString("Acoustic Minor Chords", comment: "")


enum InstrumentTypeName: String {
    case BasicPiano = "Basic Piano"
    case GrandPiano = "Grand Piano"
    case AcousticGuitar = "Acoustic Guitar"
    case Keyboard = "Keyboard"
    case Violin = "Violin"
    case acousticMinor = "Acoustic Minor Chords"
}
