//
//  WSButtonType.swift
//  DesignSystem
//
//  Created by Kim dohyun on 7/6/24.
//

import UIKit


public enum WSButtonType {
    case `default`(CGFloat)
    case secondaryButton
    case strokeButton
    case disableButton
    
    
    var buttonProperties: WSButtonProperty {
        switch self {
        /// Primary Button 생성 Case  입니다
        case let .default(radius):
            return .init(
                backgroundColor: .primary,
                textColor: DesignSystemAsset.Colors.gray900.color,
                textFont: WSFont.Body03.font(),
                radius: radius
            )
        /// Secondary Button 생성 Case  입니다
        case .secondaryButton:
            return .init(
                backgroundColor: .secondary,
                textColor: DesignSystemAsset.Colors.gray100.color,
                textFont: WSFont.Body03.font(),
                radius: 10
            )
        /// Stroke Button이 있는 생성 Case  입니다
        case .strokeButton:
            return .init(
                backgroundColor: .tertiary,
                textColor: DesignSystemAsset.Colors.gray100.color,
                textFont: WSFont.Body03.font(),
                radius: 12,
                borderColor: DesignSystemAsset.Colors.primary400.color.cgColor,
                borderWidth: 1
            )
        /// Disabled Button이 있는 생성 Case  입니다
        case .disableButton:
            return .init(
                backgroundColor: .secondary,
                textColor: DesignSystemAsset.Colors.gray300.color,
                textFont: WSFont.Body03.font(),
                radius: 12
            )
        }
    }
    
    var pressedBackgroundColor: UIColor {
        switch self {
        case .default:
            return DesignSystemAsset.Colors.pressedPrimary300.color
        case .strokeButton:
            return DesignSystemAsset.Colors.pressedGray700.color
        case .disableButton, .secondaryButton:
            return DesignSystemAsset.Colors.pressedGray500.color
        }
    }
    
    var pressedBorderColor: CGColor {
        switch self {
        case .strokeButton:
            return DesignSystemAsset.Colors.pressedPrimary400.color.cgColor
        default:
            return UIColor.clear.cgColor
        }
    }
    
    var pressedTextColor: UIColor {
        switch self {
        case .strokeButton, .disableButton, .secondaryButton:
            return DesignSystemAsset.Colors.gray300.color
        default:
            return self.buttonProperties.textColor ?? UIColor()
        }
    }
}
