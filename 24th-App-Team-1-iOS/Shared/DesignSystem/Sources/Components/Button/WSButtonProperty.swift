//
//  WSButtonProperty.swift
//  DesignSystem
//
//  Created by Kim dohyun on 7/6/24.
//

import UIKit


public struct WSButtonProperty {
    let backgroundColor: WSButtonColor
    let textColor: UIColor?
    let textFont: UIFont?
    let radius: CGFloat
    let borderColor: CGColor?
    let borderWidth: CGFloat?
    
    init(
        backgroundColor: WSButtonColor,
        textColor: UIColor?,
        textFont: UIFont?,
        radius: CGFloat,
        borderColor: CGColor? = nil,
        borderWidth: CGFloat? = 0.0
    ) {
        self.backgroundColor = backgroundColor
        self.textColor = textColor
        self.textFont = textFont
        self.radius = radius
        self.borderColor = borderColor
        self.borderWidth = borderWidth
    }
}
