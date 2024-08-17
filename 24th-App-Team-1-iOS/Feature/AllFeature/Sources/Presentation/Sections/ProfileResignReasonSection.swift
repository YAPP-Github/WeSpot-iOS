//
//  ProfileResignReasonSection.swift
//  AllFeature
//
//  Created by Kim dohyun on 8/17/24.
//

import Differentiator


public enum ProfileResignReasonSection: SectionModelType {
    case accountResignReasonInfo([ProfileResingReasonItem])
    
    public var items: [ProfileResingReasonItem] {
        if case let .accountResignReasonInfo(items) = self {
            return items
        }
        return []
    }
    
    public init(original: ProfileResignReasonSection, items: [ProfileResingReasonItem]) {
        self = original
    }
}

public enum ProfileResingReasonItem {
    case resignReasonItem(ProfileResignCellReactor)
}
