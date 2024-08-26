//
//  SignUpGenderViewReactor.swift
//  LoginFeature
//
//  Created by eunseou on 7/12/24.
//

import Foundation

import ReactorKit
import LoginDomain

public final class SignUpGenderViewReactor: Reactor {
    
    public struct State {
        var accountRequest: CreateAccountRequest
        var schoolName: String
    }
    
    public enum Action {
        case selectGender(String)
    }
    
    public enum Mutation {
        case setGender(String)
    }
    
    public var initialState: State
    
    public init(accountRequest: CreateAccountRequest, schoolName: String) {
        self.initialState = State(accountRequest: accountRequest, schoolName: schoolName)
    }
    
    public  func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .selectGender(let gender):
            return .just(.setGender(gender))
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setGender(let gender):
            newState.accountRequest.gender = gender
        }
        return newState
    }
}
