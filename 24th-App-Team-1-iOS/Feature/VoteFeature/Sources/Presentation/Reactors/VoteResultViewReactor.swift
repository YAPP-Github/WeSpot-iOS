//
//  VoteResultViewReactor.swift
//  VoteFeature
//
//  Created by Kim dohyun on 7/13/24.
//

import Foundation

import ReactorKit

final class VoteResultViewReactor: Reactor {
    
    
    var initialState: State
    
    struct State {
        @Pulse var resultSection: [VoteResultSection]
        var currentPage: Int = 0
    }
    
    enum Action {
        case fetchResultItems
        case didShowVisibleCell(_ index: Int)
    }
    
    enum Mutation {
        case setResultSectionItems([VoteResultItem])
        case setVisibleCellIndex(Int)
    }
    
    init() {
        self.initialState = State(
            resultSection: [
                .voteResultInfo([.voteResultsItem, .voteResultsItem, .voteResultsItem])
            ]
        )
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .fetchResultItems:
            return .empty()
        case let .didShowVisibleCell(index):
            return .just(.setVisibleCellIndex(index))
            
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
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
