//
//  SignInViewReactor.swift
//  LoginFeature
//
//  Created by eunseou on 7/13/24.
//

import Foundation
import Networking
import LoginDomain
import Storage

import ReactorKit
import AuthenticationServices

public final class SignInViewReactor: Reactor {
    
    private let createNewMemberUseCase: CreateNewMemberUseCaseProtocol
    private let createExistingUseCase: CreateExistingMemberUseCaseProtocol
    public var initialState: State
    
    public struct State {
        var signUpTokenResponse: CreateSignUpTokenResponseEntity?
        var accountResponse: CreateAccountResponseEntity?
    }
    
    public enum Action {
        case signInWithApple(ASAuthorization)
        case signInWithKakao
    }
    
    public enum Mutation {
        case setSignUpTokenResponse(CreateSignUpTokenResponseEntity)
        case setAccountResponse(CreateAccountResponseEntity)
    }
    
    public init(createNewMemberUseCase: CreateNewMemberUseCaseProtocol, createExistingUseCase: CreateExistingMemberUseCaseProtocol) {
        self.createNewMemberUseCase = createNewMemberUseCase
        self.createExistingUseCase = createExistingUseCase
        self.initialState = State()
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .signInWithApple(let authorization):
            //애플로그인 로직
            guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential else { return .empty() }
            
            guard let authorizationCodeData = appleIDCredential.authorizationCode,
                  let authorizationCode = String(data: authorizationCodeData, encoding: .utf8),
                  let identityTokenData = appleIDCredential.identityToken,
                  let identityToken = String(data: identityTokenData, encoding: .utf8)
            else {
                return .empty()
            }
            let apnsToken = APNsTokenManager.shared.token ?? ""
            
            return executeSignUp(socialType: "APPLE", authorizationCode: authorizationCode, identityToken: identityToken)
        case .signInWithKakao:
            //TODO: 카카오 로그인 로직 추가
            return .empty()
        }
    }
    
    private func executeSignUp(socialType: String, authorizationCode: String, identityToken: String) -> Observable<Mutation> {
        let apnsToken = APNsTokenManager.shared.token ?? ""
        let body = CreateSignUpTokenRequest(socialType: socialType,
                                            authorizationCode: authorizationCode,
                                            identityToken: identityToken,
                                            fcmToken: apnsToken)
        
        if UserDefaultsManager.shared.accessToken != nil {
            return createNewMemberUseCase
                .execute(body: body)
                .asObservable()
                .compactMap { $0 }
                .map { .setSignUpTokenResponse($0) }
            
        } else {
            return createExistingUseCase
                .execute(body: body)
                .asObservable()
                .compactMap { $0 }
                .map { .setAccountResponse($0) }
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setSignUpTokenResponse(let signUpTokenResponse):
            newState.signUpTokenResponse = signUpTokenResponse
        case .setAccountResponse(let accountResponse):
            newState.accountResponse = accountResponse
        }
        return newState
    }
}
