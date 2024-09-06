//
//  ProfileAccountSettingViewReactor.swift
//  AllFeature
//
//  Created by Kim dohyun on 8/16/24.
//

import Foundation

import Storage
import ReactorKit
import KakaoSDKUser
import RxKakaoSDKCommon

public final class ProfileAccountSettingViewReactor: Reactor {
    
    
    public struct State {
        @Pulse var accountSection: [ProfileAccountSection]
        @Pulse var isLogout: Bool
    }
    
    public enum Action {
        case didTappedLogoutButton
    }
    
    public enum Mutation {
        case setUserLogout(Bool)
    }
    
    public let initialState: State
    
    public init() { 
        self.initialState = State(accountSection: [
            .accountInfo([
                .accountItem("로그아웃"),
                .accountItem("계정 탈퇴")
            ])
        ],
            isLogout: false
        )
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .didTappedLogoutButton:
            guard let socialTypes = UserDefaultsManager.shared.socialType else { return .empty() }
            
            switch socialTypes {
            case "KAKAO":
                return kakaoLogout()
                    .asObservable()
                    .flatMap { _ -> Observable<Mutation> in
                        return .just(.setUserLogout(true))
                    }
            default:
                return .just(.setUserLogout(true))
            }
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case let .setUserLogout(isLogout):
            newState.isLogout = isLogout
        }
        
        return newState
    }
}


//TODO: KakaoLogout로직 UseCase로 빼기
extension ProfileAccountSettingViewReactor {
    private func kakaoLogout() -> Observable<Void> {
        Observable<Void>.create { observer in
            UserApi.shared.logout { error in
                if let error = error {
                    observer.onError(error)
                } else {
                    observer.onNext(())
                }
            }
            return Disposables.create()
        }
    }
}
