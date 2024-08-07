//
//  VoteAllCompleteSection.swift
//  VoteFeature
//
//  Created by Kim dohyun on 7/30/24.
//

import Differentiator


public enum VoteAllCompleteSectionType: String, Equatable {
    case highType
    case lowType
}

public enum VoteAllCompleteSection: SectionModelType {
    case voteHighRankerInfo([VoteAllCompleteItem])
    case voteLowRankerInfo([VoteAllCompleteItem])
    
    
    public var items: [VoteAllCompleteItem] {
        switch self {
        case let .voteHighRankerInfo(items): return items
        case let .voteLowRankerInfo(items): return items
        }
    }
    
    public init(original: VoteAllCompleteSection, items: [VoteAllCompleteItem]) {
        switch original {
        case .voteHighRankerInfo: self = .voteHighRankerInfo(items)
        case .voteLowRankerInfo: self = .voteLowRankerInfo(items)
        }
    }
    
}

public enum VoteAllCompleteItem {
    case voteHighRankerItem(VoteHighCellReactor)
    case voteLowRankerItem(VoteLowCellReactor)
}

extension VoteAllCompleteSection {
    public func getSectionType() -> VoteAllCompleteSectionType {
        switch self {
        case .voteHighRankerInfo: return .highType
        case .voteLowRankerInfo: return .lowType
        }
    }
}
