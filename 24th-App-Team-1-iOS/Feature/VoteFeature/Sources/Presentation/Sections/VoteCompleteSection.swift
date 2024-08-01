//
//  VoteCompleteSection.swift
//  VoteFeature
//
//  Created by Kim dohyun on 7/29/24.
//

import Differentiator


public enum VoteCompleteSection: SectionModelType {
    case voteAllRankerInfo([VoteCompleteItem])
    case voteAllEmptyRankerInfo([VoteCompleteItem])
    
    
    public var items: [VoteCompleteItem] {
        switch self {
        case let .voteAllRankerInfo(items): return items
        case let .voteAllEmptyRankerInfo(items): return items
        }
    }
    
    public init(original: VoteCompleteSection, items: [VoteCompleteItem]) {
        self = original
    }
}


public enum VoteCompleteItem {
    case voteAllRankerItem(VoteAllCellReactor)
    case voteAllEmptyItem(VoteEmptyCellReactor)
}
