//
//  VoteCompleteSection.swift
//  VoteFeature
//
//  Created by Kim dohyun on 7/29/24.
//

import Differentiator


public enum VoteCompleteSection: SectionModelType {
    case voteAllRankerInfo([VoteCompleteItem])
    
    
    public var items: [VoteCompleteItem] {
        switch self {
        case let .voteAllRankerInfo(items): return items
        }
    }
    
    public init(original: VoteCompleteSection, items: [VoteCompleteItem]) {
        switch original {
        case .voteAllRankerInfo: self = .voteAllRankerInfo(items)
        }
    }
}


public enum VoteCompleteItem {
    case voteAllRankerItem(VoteAllCellReactor)
}
