//
//  VoteInventorySection.swift
//  VoteFeature
//
//  Created by Kim dohyun on 8/8/24.
//

import Differentiator

public enum VoteInventorySection: SectionModelType {
    case voteReceiveInfo(items: [VoteInventoryItem])
    case voteSentInfo(items: [VoteInventoryItem])
    
    public var items: [VoteInventoryItem] {
        switch self {
        case let .voteReceiveInfo(items): return items
        case let .voteSentInfo(items): return items
        }
    }
        
    public init(original: VoteInventorySection, items: [VoteInventoryItem]) {
        switch original {
        case .voteReceiveInfo:
            self = .voteReceiveInfo(items: items)
        case .voteSentInfo:
            self = .voteSentInfo(items: items)
        }
    }
}


public enum VoteInventoryItem {
    case voteReceiveItem(VoteReceiveCellReactor)
    case voteSentItem(VoteSentCellReactor)
}
