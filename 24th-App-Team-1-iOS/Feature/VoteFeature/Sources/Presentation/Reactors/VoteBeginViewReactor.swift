//
//  VoteBeginViewReactor.swift
//  VoteFeature
//
//  Created by Kim dohyun on 7/16/24.
//

import Foundation

import ReactorKit

public final class VoteBeginViewReactor: Reactor {
    
    public let initialState: State
    
    public struct State {
        
    }
    
    public enum Action {
        
    }
    
    public enum Mutation {
        
    }
    
    public init() {
        self.initialState = State()
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        
        return .empty()
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        
        return state
    }
}
