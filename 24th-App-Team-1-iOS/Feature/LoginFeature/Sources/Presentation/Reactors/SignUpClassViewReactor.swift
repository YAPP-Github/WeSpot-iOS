//
//  SignUpClassViewReactor.swift
//  LoginFeature
//
//  Created by eunseou on 7/12/24.
//

import Foundation

import ReactorKit
import LoginDomain

public final class SignUpClassViewReactor: Reactor {
    
    public var initialState: State
    
    public struct State {
        var accountRequest: CreateAccountRequest
        var isEnabledButton: Bool = false
    }
    
    public enum Action {
        case inputClass(Int)
    }
    
    public enum Mutation {
        case setClass(Int)
        case setEnabledButton(Bool)
    }
    
    
    public init(accountRequest: CreateAccountRequest) {
        self.initialState = State(accountRequest: accountRequest)
        print(initialState)
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .inputClass(let classNumber):
            let isEnabledButton = classNumber > 0 && classNumber <= 20
            return Observable.concat([
                .just(.setClass(classNumber)),
                .just(.setEnabledButton(isEnabledButton))
            ])
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setClass(let classNumber):
            newState.accountRequest.classNumber = classNumber
        case .setEnabledButton(let isEnabled):
            newState.isEnabledButton = isEnabled
        }
        return newState
    }
}
