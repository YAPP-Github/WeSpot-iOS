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
    
    private let createSignUpTokenUseCase: CreateSignUpTokenUseCaseProtocol
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
    
    public init(createSignUpTokenUseCase: CreateSignUpTokenUseCaseProtocol) {
        self.createSignUpTokenUseCase = createSignUpTokenUseCase
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
            
            let body = CreateSignUpTokenRequest(socialType: "APPLE",
                                                authorizationCode: authorizationCode,
                                                identityToken: identityToken,
                                                fcmToken: apnsToken)
          
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
        return createSignUpTokenUseCase
            .execute(body: body)
            .asObservable()
            .compactMap { $0 }
            .flatMap { entity -> Observable<Mutation> in
                if let signUpTokenResponse = entity.signUpTokenResponse {
                    return .just(.setSignUpTokenResponse(signUpTokenResponse))
                } else if let accountResponse = entity.accountResponse {
                    return .just(.setAccountResponse(accountResponse))
                } else {
                    print("Error: Unexpected response format")
                    return .empty()
                }
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
