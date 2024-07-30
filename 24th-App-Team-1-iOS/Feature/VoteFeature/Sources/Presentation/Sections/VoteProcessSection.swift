//
//  VoteProcessSection.swift
//  VoteFeature
//
//  Created by Kim dohyun on 7/17/24.
//

import Differentiator

public enum VoteProcessSection: SectionModelType {
    case votePrcessInfo([VoteProcessItem])
    
    public var items: [VoteProcessItem] {
        if case let .votePrcessInfo(items) = self {
            return items
        }
        return []
    }
    public init(original: VoteProcessSection, items: [VoteProcessItem]) {
        self = original
    }
    
}


public enum VoteProcessItem {
    case voteQuestionItem(VoteProcessCellReactor)
}
