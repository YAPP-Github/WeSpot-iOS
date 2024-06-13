//
//  BaseViewModel.swift
//  Util
//
//  Created by eunseou on 6/14/24.
//

import UIKit

import ReactorKit

final class BaseViewModel: Reactor {
    
    struct State {
       
    }
  
    enum Action {
        
    }
    
    
    enum Mutation {
        
    }
    
    let initialState: State
    
    init(initialState: State = State()) {
        self.initialState = initialState
    }
    
    // Action -> Mutation
    func mutate(action: Action) -> Observable<Mutation> {
     
        return .empty()
    }
    
    // Mutation -> State
    func reduce(state: State, mutation: Mutation) -> State {
        
        return state
    }
}

