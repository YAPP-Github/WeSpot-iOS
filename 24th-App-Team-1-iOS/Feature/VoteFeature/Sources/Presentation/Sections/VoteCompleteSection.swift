//
//  VoteCompleteSection.swift
//  VoteFeature
//
//  Created by Kim dohyun on 7/29/24.
//

import Differentiator


public enum VoteCompleteSection: SectionModelType {
    case voteHighRankerInfo([VoteCompleteItem])
    case voteLowRankerInfo([VoteCompleteItem])
    
    
    public var items: [VoteCompleteItem] {
        switch self {
        case let .voteHighRankerInfo(items): return items
        case let .voteLowRankerInfo(items): return items
        }
    }
    
    public init(original: VoteCompleteSection, items: [VoteCompleteItem]) {
        switch original {
        case .voteHighRankerInfo: self = .voteHighRankerInfo(items)
        case .voteLowRankerInfo: self = .voteLowRankerInfo(items)
        }
    }
}


public enum VoteCompleteItem {
    case voteHighRankerItem
    case voteLowRankerItem
}
