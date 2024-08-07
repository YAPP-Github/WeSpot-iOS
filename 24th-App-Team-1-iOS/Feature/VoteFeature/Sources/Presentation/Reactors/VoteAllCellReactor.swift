//
//  VoteAllCellReactor.swift
//  VoteFeature
//
//  Created by Kim dohyun on 7/30/24.
//

import Foundation
import VoteDomain

import ReactorKit

public final class VoteAllCellReactor: Reactor {
    
    public let initialState: State
    
    public struct State {
        var voteAllResultsEntity: [VoteAllResultEntity]
        var content: String
        @Pulse var completeAllSection: [VoteAllCompleteSection]
    }
    
    public enum Action {
        case fetchCompleteSection
    }
    
    public enum Mutation {
        case setVoteHighRankerItem([VoteAllCompleteItem])
        case setVoteLowRankerItem([VoteAllCompleteItem])
    }
    
    init(voteAllResultsEntity: [VoteAllResultEntity], content: String) {
        self.initialState = State(
            voteAllResultsEntity: voteAllResultsEntity,
            content: content,
            completeAllSection: [
                .voteHighRankerInfo([]),
                .voteLowRankerInfo([])
            ]
        )
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .fetchCompleteSection:
            var highSectionItem: [VoteAllCompleteItem] = []
            var lowSectionItem: [VoteAllCompleteItem] = []
            
            var response = currentState.voteAllResultsEntity
                
            response
                .swapAt(0, 1)
            
            response
                .enumerated()
                .forEach { (index, entity) in
                    if index < 3 {
                        highSectionItem.append(
                            .voteHighRankerItem(
                                VoteHighCellReactor(
                                    highUser: entity.user,
                                    voteCount: entity.voteCount,
                                    ranker: index
                                )
                            )
                        )
                    } else {
                        lowSectionItem.append(
                            .voteLowRankerItem(
                                VoteLowCellReactor(
                                    lowUser: entity.user,
                                    rank: index,
                                    voteCount: entity.voteCount
                                )
                            )
                        )
                    }
                }
            return .concat(
                .just(.setVoteHighRankerItem(highSectionItem)),
                .just(.setVoteLowRankerItem(lowSectionItem))
            )
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case let .setVoteHighRankerItem(items):
            let sectionIndex = getSection(.voteHighRankerInfo([]))
            newState.completeAllSection[sectionIndex] = .voteHighRankerInfo(items)
        case let .setVoteLowRankerItem(items):
            let sectionIndex = getSection(.voteLowRankerInfo([]))
            newState.completeAllSection[sectionIndex] = .voteLowRankerInfo(items)
        }
        
        return newState
    }
}


extension VoteAllCellReactor {
    private func getSection(_ section: VoteAllCompleteSection) -> Int {
        var index: Int = 0
        
        for i in 0 ..< currentState.completeAllSection.count where currentState.completeAllSection[i].getSectionType() == section.getSectionType() {
            index = i
        }
        
        return index
    }
}
