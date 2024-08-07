//
//  VoteInventorySection.swift
//  VoteFeature
//
//  Created by Kim dohyun on 8/8/24.
//

import Differentiator

public enum VoteInventorySection: SectionModelType {
    case voteReceiveInfo([VoteInventoryItem])
    case voteSentInfo([VoteInventoryItem])
    
    public var items: [VoteInventoryItem] {
        switch self {
        case let .voteReceiveInfo(items): return items
        case let .voteSentInfo(items): return items
        }
    }
    
    public init(original: VoteInventorySection, items: [VoteInventoryItem]) {
        self = original
    }
}


public enum VoteInventoryItem {
    case voteReceiveItem
    case voteSentItem(VoteSentCellReactor)
}
