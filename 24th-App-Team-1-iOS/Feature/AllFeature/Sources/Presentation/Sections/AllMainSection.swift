//
//  AllMainSection.swift
//  AllFeature
//
//  Created by Kim dohyun on 8/11/24.
//

import Differentiator


public enum AllMainSection: SectionModelType {
    case movementInfo([AllMainItem])
    case appInfo([AllMainItem])
    case makerInfo([AllMainItem])
    
    public var items: [AllMainItem] {
        switch self {
        case let .movementInfo(items): return items
        case let .appInfo(items): return items
        case let .makerInfo(items): return items
        }
    }
    
    public init(original: AllMainSection, items: [AllMainItem]) {
        self = original
    }
    
}

public enum AllMainItem {
    case movementItem(String)
    case appInfoItem(String)
    case makerInfoItem(String)
}
