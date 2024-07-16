//
//  VoteProcessSection.swift
//  VoteFeature
//
//  Created by Kim dohyun on 7/17/24.
//

import Differentiator

enum VoteProcessSection: SectionModelType {
    case votePrcessInfo([VoteProcessItem])
    
    var items: [VoteProcessItem] {
        if case let .votePrcessInfo(items) = self {
            return items
        }
        return []
    }
    init(original: VoteProcessSection, items: [VoteProcessItem]) {
        self = original
    }
    
}


enum VoteProcessItem {
    case voteQuestionItem
}
