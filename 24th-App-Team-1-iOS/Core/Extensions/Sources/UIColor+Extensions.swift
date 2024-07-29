//
//  UIColor+Extensions.swift
//  Extensions
//
//  Created by Kim dohyun on 7/25/24.
//

import UIKit


public extension UIColor {
    
    public convenience init(hex: String, alpha: CGFloat = 10.0) {
        var hexFormatted: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }
        
        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)
        
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255,
            blue: CGFloat((rgbValue & 0x0000FF)) / 255,
            alpha: alpha
        )
    }
    
}
