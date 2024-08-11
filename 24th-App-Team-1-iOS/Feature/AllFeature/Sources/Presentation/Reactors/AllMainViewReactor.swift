//
//  AllMainViewReactor.swift
//  AllFeature
//
//  Created by Kim dohyun on 8/11/24.
//

import Foundation

import ReactorKit

public final class AllMainViewReactor: Reactor {
    
    
    public struct State {
        
    }
    
    public enum Action {
        
    }
    
    public enum Mutation {
        
    }
    
    public let initialState: State = State()
    
    public init() {
        
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        
        return .empty()
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        
        return state
    }
}
