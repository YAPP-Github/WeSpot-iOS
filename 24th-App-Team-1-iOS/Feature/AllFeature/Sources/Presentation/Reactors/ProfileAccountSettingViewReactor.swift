//
//  ProfileAccountSettingViewReactor.swift
//  AllFeature
//
//  Created by Kim dohyun on 8/16/24.
//

import Foundation

import ReactorKit

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
            return .just(.setUserLogout(true))
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
