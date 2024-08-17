//
//  ProfileUserBlockSection.swift
//  AllFeature
//
//  Created by Kim dohyun on 8/15/24.
//

import Differentiator

public enum ProfileUserBlockSection: SectionModelType {
    case blockInfo([ProfileUserBlockItem])
    
    public var items: [ProfileUserBlockItem] {
        if case let .blockInfo(items) = self {
            return items
        }
        return []
    }
    
    public init(original: ProfileUserBlockSection, items: [ProfileUserBlockItem]) {
        self = original
    }
}


public enum ProfileUserBlockItem {
    case userBlockItem(ProfileUserBlockCellReactor)
}
