//
//  WSNavigationTypeProperty.swift
//  DesignSystem
//
//  Created by Kim dohyun on 7/1/24.
//

import UIKit

/// WSNavigationTypeProperty로 각 **WSNavigationType**에 맞게 UI를 구성할 수 있습니다.
public struct WSNavigationTypeProperty: Equatable {
    /// leftBarButtonItem UI를 구성하기 위한 프로퍼티 입니다.
    var leftItem: UIImage?
    /// centernItem UI를 구성하기 위한 프러퍼티 입니다.
    var centerItem: String?
    /// rightBarButtonItem Image UI를 구성하기 위한 프로퍼티 입니다.
    var rightImageItem: UIImage?
    /// rightBarButtonItem  Text UI를 구성하기 위한 프로퍼티 입니다.
    var rightTextItem: String?
    /// rightBarButtonItem Text Color를 구성하기 위한 프로퍼티 입니다.
    var rightTextItemColor: UIColor?
}


/// WSNavigationType을  통해 NavigationBar를 지정하고 **WSNavigationTypeProperty**를 반환 하도록 하는 열거형 타입입니다.
public enum WSNavigationType: Equatable {
    case `default`
    case center(String)
    case leftIcon(UIImage)
    case leftWithCenterItem(UIImage, String)
    case rightIcon(String? = "")
    case leftWithRightItem(UIImage, String, UIColor)
    case all(UIImage, String?, String?, UIColor)
    
    var items: WSNavigationTypeProperty {
        switch self {
        case .default:
            return .init(
                leftItem: DesignSystemAsset.Images.logo.image,
                rightImageItem: DesignSystemAsset.Images.notice.image
            )
        case let .center(centerItem):
            return .init(centerItem: centerItem)
        case let .leftIcon(leftItem):
            return .init(leftItem: leftItem)
        case let .leftWithCenterItem(leftItem, centerItem):
            return .init(
                leftItem: leftItem,
                centerItem: centerItem
            )
        case let .rightIcon(rightTextItem):
            return .init(
                rightTextItem: rightTextItem
            )
        case let .leftWithRightItem(leftItem, rightTextItem, rightTextItemColor):
            return .init(
                leftItem: leftItem,
                rightTextItem: rightTextItem,
                rightTextItemColor: rightTextItemColor
                
            )
        case let .all(leftItem, rightTextItem, centerItem, rightTextItemColor):
            return .init(
                leftItem: leftItem,
                centerItem: centerItem,
                rightTextItem: rightTextItem,
                rightTextItemColor: rightTextItemColor
            )
        }
    }
}
