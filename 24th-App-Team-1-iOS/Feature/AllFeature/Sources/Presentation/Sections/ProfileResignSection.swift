//
//  ProfileResignSection.swift
//  AllFeature
//
//  Created by Kim dohyun on 8/17/24.
//

import Differentiator

public enum ProfileResignSection: SectionModelType {
    case accountResignInfo([ProfileResignItem])
    
    public var items: [ProfileResignItem] {
        if case let .accountResignInfo(items) = self {
            return items
        }
        return []
    }
    
    public init(original: ProfileResignSection, items: [ProfileResignItem]) {
        self = original
    }
}

public enum ProfileResignItem {
    case accountResignItem
}
