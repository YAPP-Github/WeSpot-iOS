//
//  SetUpProfileImageViewReactor.swift
//  LoginFeature
//
//  Created by eunseou on 8/3/24.
//

import Foundation
import LoginDomain

import ReactorKit

public final class SetUpProfileImageViewReactor: Reactor {
    
    
    public struct State {
        
    }
    
    public enum Action {
        
    }
    
    public enum Mutation {
        
    }
    
    public let initialState: State
    
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
