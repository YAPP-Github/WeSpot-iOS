//
//  WSFont.swift
//  DesignSystem
//
//  Created by eunseou on 6/24/24.
//

import UIKit


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
    case Body11
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
        case .Body11:
            10
        case .Badge:
            12
        }
    }
    
    var weight: DesignSystemFontConvertible {
        switch self {
        case .Header01:
            DesignSystemFontFamily.Pretendard.bold
        case .Header02:
            DesignSystemFontFamily.Pretendard.semiBold
        case .Header03:
            DesignSystemFontFamily.Pretendard.semiBold
        case .Body01:
            DesignSystemFontFamily.Pretendard.bold
        case .Body02:
            DesignSystemFontFamily.Pretendard.semiBold
        case .Body03:
            DesignSystemFontFamily.Pretendard.semiBold
        case .Body04:
            DesignSystemFontFamily.Pretendard.medium
        case .Body05:
            DesignSystemFontFamily.Pretendard.semiBold
        case .Body06:
            DesignSystemFontFamily.Pretendard.medium
        case .Body07:
            DesignSystemFontFamily.Pretendard.medium
        case .Body08:
            DesignSystemFontFamily.Pretendard.regular
        case .Body09:
            DesignSystemFontFamily.Pretendard.medium
        case .Body10:
            DesignSystemFontFamily.Pretendard.semiBold
        case .Body11:
            DesignSystemFontFamily.Pretendard.medium
        case .Badge:
            DesignSystemFontFamily.Pretendard.semiBold
        }
    }
    
    
    var lineHeight: CGFloat {
        return 1.26
    }
    
    var letterSpacing: CGFloat {
        return 0.0
    }
    
    public func font() -> UIFont {
        return DesignSystemFontConvertible.Font(font: weight, size: size) ?? UIFont.systemFont(ofSize: size)
    }
}

