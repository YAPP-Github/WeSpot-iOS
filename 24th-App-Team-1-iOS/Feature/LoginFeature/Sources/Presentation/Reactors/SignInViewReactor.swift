//
//  SignInViewReactor.swift
//  LoginFeature
//
//  Created by eunseou on 7/13/24.
//

import Foundation

import ReactorKit

public final class SignInViewReactor: Reactor {
    
    
    public struct State {
        
    }
    
    public enum Action {
        
    }
    
    public enum Mutation {
        
    }
    
    public var initialState: State = State()
    
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
