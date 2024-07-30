//
//  VoteCompleteViewReactor.swift
//  VoteFeature
//
//  Created by Kim dohyun on 7/24/24.
//

import Foundation

import ReactorKit

public final class VoteCompleteViewReactor: Reactor {
    
    public let initialState: State
    
    public struct State {
        @Pulse var completeSection: [VoteCompleteSection]
        var isLoading: Bool
        var currentPage: Int
    }
    
    public enum Action {
        case viewDidLoad
        case didShowVisibleCell(_ index: Int)
    }
    
    public enum Mutation {
        case setOnboadingView(Bool)
        case setCurrentPageControl(Int)
        case setCompleteSection([VoteCompleteItem])
    }
    
    public init() {
        self.initialState = State(
            completeSection: [
                .voteAllRankerInfo(
                    [
                        .voteAllRankerItem(VoteAllCellReactor()),
                        .voteAllRankerItem(VoteAllCellReactor()),
                        .voteAllRankerItem(VoteAllCellReactor())
                    ]
                )
            ],
            isLoading: false,
            currentPage: 0
        )
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        
        switch action {
        case .viewDidLoad:
            return .just(.setOnboadingView(true))
        case let .didShowVisibleCell(index):
            return .just(.setCurrentPageControl(index))
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setOnboadingView(isLoading):
            newState.isLoading = isLoading
        case let .setCurrentPageControl(currentPage):
            newState.currentPage = currentPage
        case let .setCompleteSection(items):
            newState.completeSection = [.voteAllRankerInfo(items)]
            
        }
        return newState
    }
}
