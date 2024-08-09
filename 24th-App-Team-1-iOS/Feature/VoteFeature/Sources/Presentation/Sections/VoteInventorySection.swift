//
//  VoteInventorySection.swift
//  VoteFeature
//
//  Created by Kim dohyun on 8/8/24.
//

import Differentiator

public enum VoteInventorySection: SectionModelType {
    case voteReceiveInfo(header: String, items: [VoteInventoryItem])
    case voteSentInfo(header: String, items: [VoteInventoryItem])
    
    public var items: [VoteInventoryItem] {
        switch self {
        case let .voteReceiveInfo(_ ,items): return items
        case let .voteSentInfo(_ ,items): return items
        }
    }
    
    public var headerTitle: String {
        switch self {
        case let .voteReceiveInfo(header, _): return header
        case let .voteSentInfo(header, _): return header
        }
    }
    
    public init(original: VoteInventorySection, items: [VoteInventoryItem]) {
        switch original {
        case let .voteReceiveInfo(header, _):
            self = .voteReceiveInfo(header: header, items: items)
        case let .voteSentInfo(header, _):
            self = .voteSentInfo(header: header, items: items)
        }
    }
}


public enum VoteInventoryItem {
    case voteReceiveItem(VoteReceiveCellReactor)
    case voteSentItem(VoteSentCellReactor)
}
