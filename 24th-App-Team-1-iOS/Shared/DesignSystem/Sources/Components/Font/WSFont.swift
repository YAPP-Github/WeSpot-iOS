//
//  WSFont.swift
//  DesignSystem
//
//  Created by eunseou on 6/24/24.
//

import UIKit

public enum PretendardFont: String {
    case bold = "Pretendard-Bold"
    case semibold = "Pretendard-SemiBold"
    case medium = "Pretendard-Medium"
    case regular = "Pretendard-Regular"
}

public enum WSFont {
    case Header01
    case Header02
    case Header03
    case Body01
    case Body02
    case Body03
    case Body04
    case Body05
    case Body06
    case Body07
    case Body08
    case Body09
    case Body10
    case Badge
    
    var size: CGFloat {
        switch self {
        case .Header01:
            20
        case .Header02:
            18
        case .Header03:
            16
        case .Body01:
            18
        case .Body02:
            18
        case .Body03:
            16
        case .Body04:
            16
        case .Body05:
            14
        case .Body06:
            14
        case .Body07:
            13
        case .Body08:
            13
        case .Body09:
            12
        case .Body10:
            10
        case .Badge:
            12
        }
    }
    
    var weight: PretendardFont {
        switch self {
        case .Header01:
                .bold
        case .Header02:
                .semibold
        case .Header03:
                .semibold
        case .Body01:
                .bold
        case .Body02:
                .semibold
        case .Body03:
                .semibold
        case .Body04:
                .medium
        case .Body05:
                .semibold
        case .Body06:
                .medium
        case .Body07:
                .medium
        case .Body08:
                .regular
        case .Body09:
                .medium
        case .Body10:
                .medium
        case .Badge:
                .semibold
        }
    }
    
    
    var lineHeight: CGFloat {
        return 1.5
    }
    
    var letterSpacing: CGFloat {
        return 0.0
    }
    
    func font() -> UIFont {
        let fontName = self.weight.rawValue
        let fontSize = self.size
        return UIFont(name: fontName, size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)
    }
}

