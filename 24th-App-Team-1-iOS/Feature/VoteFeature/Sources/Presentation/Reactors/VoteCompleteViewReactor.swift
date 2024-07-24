//
//  VoteCompleteViewReactor.swift
//  VoteFeature
//
//  Created by Kim dohyun on 7/24/24.
//

import Foundation

import ReactorKit

final class VoteCompleteViewReactor: Reactor {
    
    let initialState: State
    
    struct State {
        var isLoading: Bool
    }
    
    enum Action {
        case viewDidLoad
    }
    
    enum Mutation {
        case setOnboadingView(Bool)
    }
    
    init() {
        self.initialState = State(isLoading: false)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        
        switch action {
        case .viewDidLoad:
            return .just(.setOnboadingView(true))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setOnboadingView(isLoading):
            newState.isLoading = isLoading
        }
        return newState
    }
}
