//
//  SignUpIntroduceViewReactor.swift
//  LoginFeature
//
//  Created by Kim dohyun on 8/28/24.
//

import Foundation

import ReactorKit

final class SignUpIntroduceViewReactor: Reactor {
    
    
    struct State {
        
    }
    
    enum Action {
        
    }
    
    enum Mutation {
        
    }
    
    let initialState: State = State()
    
    func mutate(action: Action) -> Observable<Mutation> {
        
        return .empty()
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        
        return state
    }
}
