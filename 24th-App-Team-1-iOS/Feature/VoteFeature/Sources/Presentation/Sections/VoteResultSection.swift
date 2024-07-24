//
//  VoteResultSection.swift
//  VoteFeature
//
//  Created by Kim dohyun on 7/13/24.
//

import Differentiator


enum VoteResultSection: SectionModelType {
    case voteResultInfo([VoteResultItem])
    
    var items: [VoteResultItem] {
        if case let .voteResultInfo(items) = self {
             return items
         }
         return []
    }
    
    init(original: VoteResultSection, items: [VoteResultItem]) {
        self = original
    }
}

enum VoteResultItem {
    case voteResultsItem
}
