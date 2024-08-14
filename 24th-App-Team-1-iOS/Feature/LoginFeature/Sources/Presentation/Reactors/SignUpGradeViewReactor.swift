//
//  SignUpGradeViewReactor.swift
//  LoginFeature
//
//  Created by eunseou on 7/12/24.
//

import Foundation

import ReactorKit
import LoginDomain

public final class SignUpGradeViewReactor: Reactor {
    
    public struct State {
        var accountRequest: CreateAccountRequest
        var isGradeSelected: Bool = false
    }
    
    public enum Action {
        case selectGrade(Int)
    }
    
    public enum Mutation {
        case setGrade(Int)
        case setGradeSelected(Bool)
    }
    
    public var initialState: State
    
    public init(accountRequest: CreateAccountRequest) {
        self.initialState = State(accountRequest: accountRequest)
        print(initialState.accountRequest)
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .selectGrade(let grade):
            return Observable.concat([
                .just(.setGrade(grade)),
                .just(.setGradeSelected(true))
            ])
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setGrade(let grade):
            newState.accountRequest.grade = grade
        case .setGradeSelected(let isSelected):
            newState.isGradeSelected = isSelected
        }
        return newState
    }
}
