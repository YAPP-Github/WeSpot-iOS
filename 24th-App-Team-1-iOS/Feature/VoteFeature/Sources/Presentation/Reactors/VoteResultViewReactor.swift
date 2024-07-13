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
    }
    
    enum Action {
        case fetchResultItems
    }
    
    enum Mutation {
        case setResultSectionItems([VoteResultItem])
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
            return .just(.setResultSectionItems([.voteResultsItem, .voteResultsItem, .voteResultsItem]))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setResultSectionItems(items):
            newState.resultSection = [.voteResultInfo(items)]
        }
        return newState
    }
}
