//
//  RotatingLogoScreensaver.swift
//  RotatingLogo
//
//  Created by Aryaman Sharda on 11/14/24.
//

import Foundation
import ScreenSaver

class RotatingLogoScreensaver: ScreenSaverView {
    override init?(frame: NSRect, isPreview: Bool) {
        super.init(frame: frame, isPreview: isPreview)
        setupLayers()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayers()
    }

    private func setupLayers() {
        // 1
        wantsLayer = true // Enable layer-backed view for animations

        // 2
        layer = CALayer()
        layer?.backgroundColor = NSColor.black.cgColor

        // 3
        let logoLayer = CALayer()
        logoLayer.contents = Bundle(for: Self.self).image(forResource: "Logo")

        // Scales the logo to 35% of the view's dimensions
        let defaultLogoSize: CGFloat = 150.0
        var logoDimension: CGFloat = defaultLogoSize
        if let currentWidth = layer?.frame.width {
            logoDimension = currentWidth * 0.35
        }
        logoLayer.frame = CGRect(x: 0, y: 0, width: logoDimension, height: logoDimension)

        // Center the logoLayer in the view
        logoLayer.position = CGPoint(x: bounds.midX, y: bounds.midY)

        // Apply the rotation animation
        let rotation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.fromValue = 0
        rotation.toValue = CGFloat.pi * 2
        rotation.duration = 4.0 // Adjust for rotation speed
        rotation.repeatCount = .infinity // Repeat indefinitely

        // 5
        logoLayer.add(rotation, forKey: "rotate")

        // 6
        layer?.addSublayer(logoLayer)
    }
}
