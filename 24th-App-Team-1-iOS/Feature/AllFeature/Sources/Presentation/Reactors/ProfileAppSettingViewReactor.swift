//
//  ProfileAppSettingViewReactor.swift
//  AllFeature
//
//  Created by Kim dohyun on 8/15/24.
//

import Foundation

import ReactorKit

public final class ProfileAppSettingViewReactor: Reactor {
    
    
    public struct State {
        @Pulse var profileAppSection: [ProfileAppSection]
    }
    
    public enum Action {
        case viewDidLoad
    }
    
    public enum Mutation {
        
    }
    
    public let initialState: State
    
    public init() {
        self.initialState = State(profileAppSection: [
            .alarmInfo([
                .accountItem("알림 설정")
            ]),
            .privacyInfo([
                .privacyItem("개인정보처리 방침"),
                .privacyItem("서비스 이용약관"),
                .privacyItem("최신 버전 업데이트")
            ]),
            .accountInfo([
                .accountItem("차단 목록"),
                .accountItem("계정 관리")
            ])
        ])
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        
        return .empty()
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        return newState
    }
}
