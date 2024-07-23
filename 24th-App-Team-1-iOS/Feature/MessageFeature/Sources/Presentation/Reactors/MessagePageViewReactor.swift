//
//  MessagePageViewReactor.swift
//  MessageFeature
//
//  Created by eunseou on 7/21/24.
//

import Foundation

import ReactorKit

final class MessagePageViewReactor: Reactor {
    
    
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
