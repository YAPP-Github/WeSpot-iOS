//
//  VoteAllCellReactor.swift
//  VoteFeature
//
//  Created by Kim dohyun on 7/30/24.
//

import Foundation

import ReactorKit

public final class VoteAllCellReactor: Reactor {
    
    public let initialState: State
    
    public struct State {
        @Pulse var completeSection: [VoteAllCompleteSection]
    }
    
    public enum Action {
        case fetchCompleteSection
    }
    
    public enum Mutation {
        case setCompleteSection([VoteAllCompleteItem])
    }
    
    init() {
        self.initialState = State(
            completeSection: [
                .voteHighRankerInfo(
                    [
                        .voteHighRankerItem,
                        .voteHighRankerItem,
                        .voteHighRankerItem
                    ]
                ),
                .voteLowRankerInfo(
                    [
                        .voteLowRankerItem,
                        .voteLowRankerItem
                    ]
                )
            ]
        )
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .fetchCompleteSection:
            return .empty()
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case let .setCompleteSection(items):
            newState.completeSection = [.voteHighRankerInfo(items), .voteLowRankerInfo(items)]
        }
        
        return newState
    }
}
