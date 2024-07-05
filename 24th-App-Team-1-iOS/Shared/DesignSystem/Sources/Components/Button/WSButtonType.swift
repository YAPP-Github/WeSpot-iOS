//
//  WSButtonType.swift
//  DesignSystem
//
//  Created by Kim dohyun on 7/6/24.
//

import UIKit


public enum WSButtonType {
    case `default`
    case supplementaryButton(WSButtonColor)
    case strokeButton
    case disableButton
    
    
    var buttonProperties: WSButtonProperty {
        switch self {
        case .default:
            
            return .init(
                backgroundColor: .primary,
                textColor: DesignSystemAsset.Colors.gray900.color,
                textFont: WSFont.Body03.font(),
                radius: 12
            )
        case let .supplementaryButton(colorType):
            return .init(
                backgroundColor: colorType,
                textColor: colorType == .primary ? DesignSystemAsset.Colors.gray900.color : DesignSystemAsset.Colors.gray100.color,
                textFont: WSFont.Body03.font(),
                radius: 10
            )
        case .strokeButton:
            return .init(
                backgroundColor: .tertiary,
                textColor: DesignSystemAsset.Colors.gray100.color,
                textFont: WSFont.Body03.font(),
                radius: 12,
                borderColor: DesignSystemAsset.Colors.primary400.color.cgColor,
                borderWidth: 1
            )
        case .disableButton:
            return .init(
                backgroundColor: .secondary,
                textColor: DesignSystemAsset.Colors.gray300.color.withAlphaComponent(0.8),
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
        case .disableButton:
            return DesignSystemAsset.Colors.pressedGray500.color
        default:
            return UIColor()
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
        case .strokeButton:
            return DesignSystemAsset.Colors.gray300.color
        default:
            return self.buttonProperties.textColor ?? UIColor()
        }
    }
}
