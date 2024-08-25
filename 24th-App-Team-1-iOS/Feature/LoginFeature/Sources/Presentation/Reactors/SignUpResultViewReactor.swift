//
//  SignUpResultViewReactor.swift
//  LoginFeature
//
//  Created by eunseou on 7/13/24.
//

import Foundation

import ReactorKit
import LoginDomain

public final class SignUpResultViewReactor: Reactor {
    
    private let createAccountUseCase: CreateAccountUseCaseProtocol
    public var initialState: State
    
    public struct State {
        var accountRequest: CreateAccountRequest
        var isAccountCreationCompleted: Bool = false
        var isMarketingAgreed: Bool = false
        var schoolName: String
    }
    
    public enum Action {
        case createAccount
        case setMarketingAgreement(Bool)
    }
    
    public enum Mutation {
        case isCompletedAccount(Bool)
        case setMarketingAgreement(Bool)
    }
    
    public init(
        accountRequest: CreateAccountRequest,
        createAccountUseCase: CreateAccountUseCaseProtocol,
        schoolName: String
    ) {
        self.initialState = State(accountRequest: accountRequest, schoolName: schoolName)
        self.createAccountUseCase = createAccountUseCase
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .createAccount:
            
            return createAccountUseCase
                .execute(body: initialState.accountRequest)
                .asObservable()
                .flatMap { entity -> Observable<Mutation> in
                    return .just(.isCompletedAccount(true))
                }
                .catchAndReturn(.isCompletedAccount(false))
        case .setMarketingAgreement(let isAgreed):
            return .just(.setMarketingAgreement(isAgreed))
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .isCompletedAccount(let isCompleted):
            newState.isAccountCreationCompleted = isCompleted
        case .setMarketingAgreement(let isAgreed):
            newState.accountRequest.consents?.marketing = isAgreed
        }
        return newState
    }
}
