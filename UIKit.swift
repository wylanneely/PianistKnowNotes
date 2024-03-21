//
//  UIKit.swift
//  KnowNotesPianist
//
//  Created by Wylan L Neely on 3/20/24.
//

import Foundation
import UIKit

extension UIButton {
    func pulsate() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.4
        pulse.fromValue = 0.93
        pulse.toValue = 1.0
        pulse.autoreverses = false
        pulse.repeatCount = 1
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        layer.add(pulse, forKey: nil)
    }
    
}
