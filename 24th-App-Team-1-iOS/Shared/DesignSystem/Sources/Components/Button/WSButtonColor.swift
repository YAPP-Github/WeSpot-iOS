//
//  WSButtonColor.swift
//  DesignSystem
//
//  Created by Kim dohyun on 7/6/24.
//

import UIKit


public enum WSButtonColor {
    case primary
    case secondary
    case tertiary
    
    var color: UIColor {
        switch self {
        case .primary:
            return DesignSystemAsset.Colors.primary300.color
        case .secondary:
            return DesignSystemAsset.Colors.gray500.color
        case .tertiary:
            return DesignSystemAsset.Colors.gray700.color
        }
    }
}
