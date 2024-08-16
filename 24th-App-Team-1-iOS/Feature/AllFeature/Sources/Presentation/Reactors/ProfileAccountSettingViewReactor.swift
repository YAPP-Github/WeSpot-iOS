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
    }
    
    public enum Action {
        
    }
    
    public enum Mutation {
        
    }
    
    public let initialState: State
    
    public init() { 
        self.initialState = State(accountSection: [
            .accountInfo([
                .accountItem("로그아웃"),
                .accountItem("계정 탈퇴")
            ])
        ])
    }
}
