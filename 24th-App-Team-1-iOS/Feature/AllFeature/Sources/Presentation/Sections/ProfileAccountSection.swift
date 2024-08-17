//
//  ProfileAccountSection.swift
//  AllFeature
//
//  Created by Kim dohyun on 8/17/24.
//

import Differentiator

public enum ProfileAccountSection: SectionModelType {
    case accountInfo([ProfileAccountItem])
    
    public var items: [ProfileAccountItem] {
        if case let .accountInfo(items) = self {
            return items
        }
        return []
    }
    
    public init(original: ProfileAccountSection, items: [ProfileAccountItem]) {
        self = original
    }
}


public enum ProfileAccountItem {
    case accountItem(String)
}
