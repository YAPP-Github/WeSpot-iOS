//
//  VoteResultSection.swift
//  VoteFeature
//
//  Created by Kim dohyun on 7/13/24.
//

import Differentiator


public enum VoteResultSection: SectionModelType {
    case voteResultInfo([VoteResultItem])
    
    public var items: [VoteResultItem] {
        if case let .voteResultInfo(items) = self {
             return items
         }
         return []
    }
    
    public init(original: VoteResultSection, items: [VoteResultItem]) {
        self = original
    }
}

public enum VoteResultItem {
    case voteResultsItem
}
