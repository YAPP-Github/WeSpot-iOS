//
//  SignUpCompleteViewReactor.swift
//  LoginFeature
//
//  Created by eunseou on 7/12/24.
//

import Foundation
import Storage
import LoginDomain

import ReactorKit

public final class SignUpCompleteViewReactor: Reactor {
    
    private let createAccountUseCase: CreateAccountUseCaseProtocol
    
    public struct State {
        @Pulse var accountEntity: CreateAccountResponseEntity?
        @Pulse var accountRequest: CreateAccountRequest
        @Pulse var isLoading: Bool
    }
    
    public enum Action {
        case viewDidLoad
    }
    
    public enum Mutation {
        case setLoading(Bool)
        case setAccountToken(CreateAccountResponseEntity)
    }
    
    public var initialState: State
    
    public init(createAccountUseCase: CreateAccountUseCaseProtocol, accountRequest: CreateAccountRequest) {
        self.createAccountUseCase = createAccountUseCase
        self.initialState = State(
            accountRequest: accountRequest,
            isLoading: false
        )
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        
        switch action {
        case .viewDidLoad:
            return createAccountUseCase
                .execute(body: currentState.accountRequest)
                .asObservable()
                .flatMap { response -> Observable<Mutation> in
                    guard let response else { return .empty() }
                    return .concat(
                        .just(.setLoading(false)),
                        .just(.setAccountToken(response)),
                        .just(.setLoading(true))
                    )
                }
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setLoading(isLoading):
            newState.isLoading = isLoading
        case let .setAccountToken(accountEntity):
            newState.accountEntity = accountEntity
            print("accountEntity: \(accountEntity)")
            KeychainManager.shared.set(value: accountEntity.accessToken, type: .accessToken)
            UserDefaultsManager.shared.refreshToken = accountEntity.refreshToken
            
            print("accessToken Keychain : \(KeychainManager.shared.get(type: .accessToken))")
        }
        
        
        return newState
    }
}
