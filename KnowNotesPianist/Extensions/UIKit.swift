//
//  UIKit.swift
//  KnowNotesPianist
//
//  Created by Wylan L Neely on 3/20/24.
//

import Foundation
import UIKit

//extension UIColor {
//    
//    func PurpleGradient()-> UIColor {
//        return UIColor(named:"GradientColor1")!
//    }
//    
//    func CyanGradient()-> UIColor {
//        return UIColor(named: "GradientColor2")!
//    }
//    
//}

extension UIView {
//    func asImage(rect: CGRect) -> UIImage {
//        UIGraphicsBeginImageContextWithOptions(rect.size, false, UIScreen.main.scale)
//        defer { UIGraphicsEndImageContext() }
//        drawHierarchy(in: rect, afterScreenUpdates: true)
//        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { 
//            return UIImage() }
//        return image
//    }
    func asImage() -> UIImage {
          let renderer = UIGraphicsImageRenderer(bounds: bounds)
          return renderer.image { rendererContext in
              layer.render(in: rendererContext.cgContext)
          }
      }
}

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
    
    func pulsateWrong() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.3
        pulse.fromValue = 1.0
        pulse.toValue = 0.9
        pulse.autoreverses = false
        pulse.repeatCount = 1
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        layer.add(pulse, forKey: nil)
    }
    
    func pulsateGuessed() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.35
        pulse.fromValue = 0.97
        pulse.toValue = 1.0
        pulse.autoreverses = false
        pulse.repeatCount = 1
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        layer.add(pulse, forKey: nil)
    }
    
}

class GradientLabel: UILabel {
    var gradientColors: [CGColor] = []

    override func drawText(in rect: CGRect) {
        if let gradientColor = drawGradientColor(in: rect, colors: gradientColors) {
            self.textColor = gradientColor
        }
        super.drawText(in: rect)
    }

    private func drawGradientColor(in rect: CGRect, colors: [CGColor]) -> UIColor? {
        let currentContext = UIGraphicsGetCurrentContext()
        currentContext?.saveGState()
        defer { currentContext?.restoreGState() }

        let size = rect.size
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        guard let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(),
                                        colors: colors as CFArray,
                                        locations: nil) else { return nil }

        let context = UIGraphicsGetCurrentContext()
        context?.drawLinearGradient(gradient,
                                    start: CGPoint.zero,
                                    end: CGPoint(x: size.width, y: 0),
                                    options: [])
        let gradientImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        guard let image = gradientImage else { return nil }
        return UIColor(patternImage: image)
    }
}
