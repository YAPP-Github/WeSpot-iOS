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
import KakaoSDKUser
import KakaoSDKAuth

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
    
    public init(createNewMemberUseCase: CreateNewMemberUseCaseProtocol,
                createExistingUseCase: CreateExistingMemberUseCaseProtocol) {
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
            return executeSignUp(socialType: "APPLE", authorizationCode: authorizationCode, identityToken: identityToken)
        case .signInWithKakao:
            
            return handleKakaoLogin().flatMap { self.executeSignUp(socialType: "KAKAO", authorizationCode: "", identityToken: $0.idToken ?? "" ) }
        }
    }
    
    func handleKakaoLogin() -> Observable<OAuthToken> {
        return Observable.create { observer in
            // 카카오톡 앱에 접근 가능할 때
            if (UserApi.isKakaoTalkLoginAvailable()) {
                UserApi.shared.loginWithKakaoTalk { oauthToken, error in
                    if let error = error {
                        print(error)
                        observer.onError(error)
                    } else if let oauthToken = oauthToken {
                        observer.onNext(oauthToken)
                        observer.onCompleted()
                    }
                }
            } else { // 카카오톡 설치가 안되어 있으면
                UserApi.shared.loginWithKakaoAccount { oauthToken, error in
                    if let error = error {
                        print(error)
                    } else if let oauthToken = oauthToken {
                        observer.onNext(oauthToken)
                        observer.onCompleted()
                    }
                }
            }
            return Disposables.create()
        }
    }
    
    private func executeSignUp(socialType: String, authorizationCode: String, identityToken: String) -> Observable<Mutation> {
        let apnsToken = APNsTokenManager.shared.token ?? ""
        let body = CreateSignUpTokenRequest(socialType: socialType,
                                            authorizationCode: authorizationCode,
                                            identityToken: identityToken,
                                            fcmToken: apnsToken)
        
        if UserDefaultsManager.shared.accessToken == nil {
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
