//
//  VoteHomeViewReactor.swift
//  VoteFeature
//
//  Created by Kim dohyun on 7/13/24.
//

import Foundation

import ReactorKit

final class VoteHomeViewReactor: Reactor {
    
    
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
