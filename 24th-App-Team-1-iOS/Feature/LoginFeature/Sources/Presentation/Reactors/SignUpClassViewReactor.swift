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
        @Pulse var isSelected: Bool = false
    }
    
    public enum Action {
        case inputClass(Int)
        case didTappedNextButton
    }
    
    public enum Mutation {
        case setClass(Int)
        case setSelected(Bool)
        case setEnabledButton(Bool)
    }
    
    
    public init(accountRequest: CreateAccountRequest, schoolName: String) {
        self.initialState = State(accountRequest: accountRequest, schoolName: schoolName)
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .inputClass(let classNumber):
            let isEnabledButton = classNumber > 0 && classNumber <= 20
            return Observable.concat([
                .just(.setClass(classNumber)),
                .just(.setEnabledButton(isEnabledButton))
            ])
        case .didTappedNextButton:
            globalService.event.onNext(.didChangedAccountClass(classNumber: currentState.accountRequest.classNumber))
            return .just(.setSelected(true))
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setClass(let classNumber):
            newState.accountRequest.classNumber = classNumber
        case .setEnabledButton(let isEnabled):
            newState.isEnabledButton = isEnabled
        case let .setSelected(isSelected):
            newState.isSelected = isSelected
        }
        return newState
    }
}
