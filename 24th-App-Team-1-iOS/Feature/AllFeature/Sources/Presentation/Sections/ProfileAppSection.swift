//
//  ProfileAppSection.swift
//  AllFeature
//
//  Created by Kim dohyun on 8/15/24.
//

import Differentiator


public enum ProfileAppSection: SectionModelType {
    case privacyInfo([ProfileAppItem])
    case alarmInfo([ProfileAppItem])
    case accountInfo([ProfileAppItem])
    
    public var items: [ProfileAppItem] {
        switch self {
        case let .privacyInfo(items): return items
        case let .alarmInfo(items): return items
        case let .accountInfo(items): return items
        }
    }
    
    public init(original: ProfileAppSection, items: [ProfileAppItem]) {
        self = original
    }
}



public enum ProfileAppItem {
    case privacyItem(String)
    case alarmItem(String)
    case accountItem(String)
    
}

