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
        var isLoading: Bool
    }
    
    public enum Action {
        case viewDidLoad
    }
    
    public enum Mutation {
        case setOnboadingView(Bool)
    }
    
    public init() {
        self.initialState = State(isLoading: false)
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        
        switch action {
        case .viewDidLoad:
            return .just(.setOnboadingView(true))
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setOnboadingView(isLoading):
            newState.isLoading = isLoading
        }
        return newState
    }
}
