//
//  WSNavigationConstraintProperty.swift
//  DesignSystem
//
//  Created by Kim dohyun on 7/1/24.
//

import Foundation

public struct WSNavigationConstraintProperty: Equatable {
    var leftBarButtonItemLeftSpacing: CGFloat
    var leftBarButtonItemTopSpacing: CGFloat
    var rightBarButtonItemRightSpacing: CGFloat
    var rightBarButtonItemTopSpacing: CGFloat
    var leftWidthScale: CGFloat
    var leftHeightScale: CGFloat
    var rightWidthScale: CGFloat
    var rightHeightScale: CGFloat
    
    init(
        leftBarButtonItemLeftSpacing: CGFloat = 8.0,
        leftBarButtonItemTopSpacing: CGFloat = 10.0,
        rightBarButtonItemRightSpacing: CGFloat = 16.0,
        rightBarButtonItemTopSpacing: CGFloat = 10.0,
        leftWidthScale: CGFloat = 40.0,
        leftHeightScale: CGFloat = 40.0,
        rightWidthScale: CGFloat = 40.0,
        rightHeightScale: CGFloat = 40.0
    ) {
        self.leftBarButtonItemLeftSpacing = leftBarButtonItemLeftSpacing
        self.leftBarButtonItemTopSpacing = leftBarButtonItemTopSpacing
        self.rightBarButtonItemRightSpacing = rightBarButtonItemRightSpacing
        self.rightBarButtonItemTopSpacing = rightBarButtonItemTopSpacing
        self.leftWidthScale = leftWidthScale
        self.leftHeightScale = leftHeightScale
        self.rightWidthScale = rightWidthScale
        self.rightHeightScale = rightHeightScale
    }
}

public enum WSNavigationPropertyType: Equatable {
    case `default`
    case center
    case leftIcon
    case leftWithCenterItem
    case rightIcon
    case leftWithRightItem
    case all
    
    
    var constraints: WSNavigationConstraintProperty {
        switch self {
        case .default:
            return .init(
                leftBarButtonItemLeftSpacing: 14.0,
                leftBarButtonItemTopSpacing: 8.0,
                rightBarButtonItemRightSpacing: 16.0,
                leftWidthScale: 112.0,
                leftHeightScale: 43.0
            )
        case .center:
            return .init()
        case .leftIcon:
            return .init(
                leftBarButtonItemLeftSpacing: 8.0,
                leftBarButtonItemTopSpacing: 10.0,
                leftWidthScale: 40.0,
                leftHeightScale: 40.0
            )
        case .leftWithCenterItem:
            return .init()
        case .rightIcon:
            return .init(
                rightBarButtonItemRightSpacing: 16,
                rightBarButtonItemTopSpacing: 10
            )
        case .leftWithRightItem:
            return .init(
                rightBarButtonItemTopSpacing: 18
            )
        case .all:
            return .init(
                rightBarButtonItemTopSpacing: 18
            )
        }
    }
}
