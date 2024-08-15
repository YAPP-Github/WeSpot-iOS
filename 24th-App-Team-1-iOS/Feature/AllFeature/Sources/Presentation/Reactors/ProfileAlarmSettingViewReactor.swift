//
//  ProfileAlarmSettingViewReactor.swift
//  AllFeature
//
//  Created by Kim dohyun on 8/15/24.
//

import Foundation
import AllDomain

import ReactorKit

public final class ProfileAlarmSettingViewReactor: Reactor {
    
    private let fetchUserAlarmUseCase: FetchUserAlarmSettingUseCaseProtocol
    
    public struct State {
        @Pulse var profileAlarmSection: [ProfileAlarmSection]
        @Pulse var alarmEntity: UserAlarmEntity?
    }
    
    public enum Action {
        case viewDidLoad
    }
    
    public enum Mutation {
        case setAlarmItems([ProfileAlarmItem])
        case setProfileAlarmEntity(UserAlarmEntity)
    }
    
    public let initialState: State
    
    public init(fetchUserAlarmUseCase: FetchUserAlarmSettingUseCaseProtocol) {
        self.fetchUserAlarmUseCase = fetchUserAlarmUseCase
        self.initialState = State(profileAlarmSection: [
            .alarmInfo([])
        ])
        
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewDidLoad:
            return fetchUserAlarmUseCase
                .execute()
                .asObservable()
                .compactMap { $0 }
                .flatMap { response -> Observable<Mutation> in
                    let alarmItems: [ProfileAlarmItem] = [
                        .profileAlarmItem(.init(isOn: response.isEnableVoteNotification, content: "투표", descrption: "우리 반 투표 및 결과 관련 알림")),
                        .profileAlarmItem(.init(isOn: response.isEnableMessageNotification, content: "쪽지", descrption: "오늘의 쪽지 보내기 및 받은 쪽지 관련 알림")),
                        .profileAlarmItem(.init(isOn: response.isEnableMarketingNotification, content: "이벤트 혜택", descrption: "광고성 정보 수신 동의에 의한 이벤트 혜택 알림"))
                    ]
                    return .concat(
                        .just(.setAlarmItems(alarmItems)),
                        .just(.setProfileAlarmEntity(response))
                    )
                }
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case let .setAlarmItems(items):
            newState.profileAlarmSection = [.alarmInfo(items)]
        case let .setProfileAlarmEntity(alarmEntity):
            newState.alarmEntity = alarmEntity
        }
        return newState
    }
}
