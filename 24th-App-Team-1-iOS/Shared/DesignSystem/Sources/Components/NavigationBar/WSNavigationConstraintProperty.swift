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
    var widthScale: CGFloat
    var heightScale: CGFloat
    
    init(
        leftBarButtonItemLeftSpacing: CGFloat = 8.0,
        leftBarButtonItemTopSpacing: CGFloat = 10.0,
        rightBarButtonItemRightSpacing: CGFloat = 18.0,
        rightBarButtonItemTopSpacing: CGFloat = 10.0,
        widthScale: CGFloat = 40.0,
        heightScale: CGFloat = 40.0
    ) {
        self.leftBarButtonItemLeftSpacing = leftBarButtonItemLeftSpacing
        self.leftBarButtonItemTopSpacing = leftBarButtonItemTopSpacing
        self.rightBarButtonItemRightSpacing = rightBarButtonItemRightSpacing
        self.rightBarButtonItemTopSpacing = rightBarButtonItemTopSpacing
        self.widthScale = widthScale
        self.heightScale = heightScale
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
                widthScale: 112.0,
                heightScale: 43.0
            )
        case .center:
            return .init()
        case .leftIcon:
            return .init(
                leftBarButtonItemLeftSpacing: 8.0,
                leftBarButtonItemTopSpacing: 10.0,
                widthScale: 40.0,
                heightScale: 40.0
            )
        case .leftWithCenterItem:
            return .init()
        case .rightIcon:
            return .init(
                rightBarButtonItemRightSpacing: 16,
                rightBarButtonItemTopSpacing: 18
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
