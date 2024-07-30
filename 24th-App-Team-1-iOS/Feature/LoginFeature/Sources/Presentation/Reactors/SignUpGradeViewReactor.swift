//
//  SignUpGradeViewReactor.swift
//  LoginFeature
//
//  Created by eunseou on 7/12/24.
//

import Foundation

import ReactorKit

public final class SignUpGradeViewReactor: Reactor {
    
    public struct State {
        
    }
    
    public enum Action {
        
    }
    
    public enum Mutation {
        
    }
    
    public var initialState: State = State()
    
    public func mutate(action: Action) -> Observable<Mutation> {
        
        return .empty()
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        
        return state
    }
}
