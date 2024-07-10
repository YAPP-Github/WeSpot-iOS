//
//  VoteMainViewReactor.swift
//  VoteFeature
//
//  Created by Kim dohyun on 7/11/24.
//

import Foundation

import ReactorKit


public final class VoteMainViewReactor: Reactor {
    public var initialState: State = State()
    
    public init(initialState: State) {
        self.initialState = initialState
    }
    
    public enum Action {
        
    }
    
    public struct State {
        
    }
    
    public enum Mutation {
        
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        return .empty()
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        return state
    }
}
