//
//  SignUpClassViewReactor.swift
//  LoginFeature
//
//  Created by eunseou on 7/12/24.
//

import Foundation
import Util

import ReactorKit
import LoginDomain

public final class SignUpClassViewReactor: Reactor {
    
    public var initialState: State
    private let globalService: WSGlobalServiceProtocol = WSGlobalStateService.shared
    
    public struct State {
        var accountRequest: CreateAccountRequest
        var isEnabledButton: Bool = false
        var schoolName: String
    }
    
    public enum Action {
        case inputClass(Int)
    }
    
    public enum Mutation {
        case setClass(Int)
        case setEnabledButton(Bool)
    }
    
    
    public init(accountRequest: CreateAccountRequest, schoolName: String) {
        self.initialState = State(accountRequest: accountRequest, schoolName: schoolName)
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .inputClass(let classNumber):
            let isEnabledButton = classNumber > 0 && classNumber <= 20
            globalService.event.onNext(.didChangedAccountClass(classNumber: classNumber))
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
