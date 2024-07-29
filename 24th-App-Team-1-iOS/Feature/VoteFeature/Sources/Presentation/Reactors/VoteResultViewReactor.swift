//
//  VoteResultViewReactor.swift
//  VoteFeature
//
//  Created by Kim dohyun on 7/13/24.
//

import Foundation

import ReactorKit

public final class VoteResultViewReactor: Reactor {
    
    
    public var initialState: State
    
    public struct State {
        @Pulse var resultSection: [VoteResultSection]
        var currentPage: Int = 0
    }
    
    public enum Action {
        case fetchResultItems
        case didShowVisibleCell(_ index: Int)
    }
    
    public enum Mutation {
        case setResultSectionItems([VoteResultItem])
        case setVisibleCellIndex(Int)
    }
    
    public  init() {
        self.initialState = State(
            resultSection: [
                .voteResultInfo([.voteResultsItem, .voteResultsItem, .voteResultsItem])
            ]
        )
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .fetchResultItems:
            return .empty()
        case let .didShowVisibleCell(index):
            return .just(.setVisibleCellIndex(index))
            
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setResultSectionItems(items):
            newState.resultSection = [.voteResultInfo(items)]
        case let .setVisibleCellIndex(currentIndex):
            newState.currentPage = currentIndex
        }
        return newState
    }
}
