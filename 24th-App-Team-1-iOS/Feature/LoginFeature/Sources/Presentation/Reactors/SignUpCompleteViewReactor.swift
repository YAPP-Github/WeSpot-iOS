//
//  SignUpCompleteViewReactor.swift
//  LoginFeature
//
//  Created by eunseou on 7/12/24.
//

import Foundation
import Storage
import Extensions
import LoginDomain

import ReactorKit

public final class SignUpCompleteViewReactor: Reactor {
    
    private let createAccountUseCase: CreateAccountUseCaseProtocol
    
    public struct State {
        @Pulse var accountEntity: CreateAccountResponseEntity?
        @Pulse var accountRequest: CreateAccountRequest
        @Pulse var isLoading: Bool
        @Pulse var isExpired: Bool
    }
    
    public enum Action {
        case viewDidLoad
    }
    
    public enum Mutation {
        case setLoading(Bool)
        case setExpiredDate(Bool)
        case setAccountToken(CreateAccountResponseEntity)
    }
    
    public var initialState: State
    
    public init(createAccountUseCase: CreateAccountUseCaseProtocol, accountRequest: CreateAccountRequest) {
        self.createAccountUseCase = createAccountUseCase
        self.initialState = State(
            accountRequest: accountRequest,
            isLoading: false,
            isExpired: false
        )
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        
        switch action {
        case .viewDidLoad:
            let expiredDate = UserDefaultsManager.shared.expiredDate
            let currentDate = Date.now
                .toFormatLocaleString(with: .dashYyyyMMddhhmmss)
                .toLocalDate(with: .dashYyyyMMddhhmmss)
            
            if expiredDate <= currentDate {
                return .just(.setExpiredDate(true))
            } else {
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
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setLoading(isLoading):
            newState.isLoading = isLoading
        case let .setAccountToken(accountEntity):
            newState.accountEntity = accountEntity
            KeychainManager.shared.set(value: accountEntity.accessToken, type: .accessToken)
            UserDefaultsManager.shared.refreshToken = accountEntity.refreshToken
            UserDefaultsManager.shared.userName = accountEntity.name
            UserDefaultsManager.shared.classNumber = currentState.accountRequest.classNumber
            UserDefaultsManager.shared.grade = currentState.accountRequest.grade
        case let .setExpiredDate(isExpired):
            newState.isExpired = isExpired
        }
        
        
        return newState
    }
}
