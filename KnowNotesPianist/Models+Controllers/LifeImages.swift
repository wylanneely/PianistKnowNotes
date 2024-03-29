//
//  LifeImages.swift
//  KnowNotesPianist
//
//  Created by Wylan L Neely on 3/28/24.
//

import Foundation
import UIKit


struct LifeImages {
    
   private let lifes0 = UIImage(named: "Lifes0")!
   private let lifes1 = UIImage(named: "Lifes1")!
   private let lifes2 = UIImage(named: "Lifes2")!
   private let lifes3 = UIImage(named: "Lifes3")!
   private let lifes4 = UIImage(named: "Lifes4")!
   private let lifes5 = UIImage(named: "Lifes5")!
    
    func returnLifeImage(for lifes:Int)->UIImage{
        switch lifes{
        case 0: return self.lifes0
        case 1: return self.lifes1
        case 2: return self.lifes2
        case 3: return self.lifes3
        case 4: return self.lifes4
        case 5: return self.lifes5
        default: return self.lifes0
        }
    }
    
}
