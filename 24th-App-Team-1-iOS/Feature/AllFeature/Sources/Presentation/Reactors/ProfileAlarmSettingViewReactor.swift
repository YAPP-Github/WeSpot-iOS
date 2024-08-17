//
//  ProfileAlarmSettingViewReactor.swift
//  AllFeature
//
//  Created by Kim dohyun on 8/15/24.
//

import Foundation
import Util
import AllDomain

import ReactorKit

public final class ProfileAlarmSettingViewReactor: Reactor {
    
    private let fetchUserAlarmUseCase: FetchUserAlarmSettingUseCaseProtocol
    private let updateUserAlarmUseCase: UpdateUserAlarmSettingUseCaseProtocol
    private let globalService: WSGlobalServiceProtocol = WSGlobalStateService.shared
    
    public struct State {
        @Pulse var alarmEntity: UserAlarmEntity?
        @Pulse var isUpdate: Bool
    }
    
    public enum Action {
        case viewDidLoad
        case didChangeVoteStatus(Bool)
        case didChangeSentStatus(Bool)
        case didChangeEventStatus(Bool)
    }
    
    public enum Mutation {
        case setProfileAlarmEntity(UserAlarmEntity)
        case setUpdateAlarm(Bool)
        
    }
    
    public let initialState: State
    
    public init(
        fetchUserAlarmUseCase: FetchUserAlarmSettingUseCaseProtocol,
        updateUserAlarmUseCase: UpdateUserAlarmSettingUseCaseProtocol
    ) {
        self.fetchUserAlarmUseCase = fetchUserAlarmUseCase
        self.updateUserAlarmUseCase = updateUserAlarmUseCase
        self.initialState = State(isUpdate: false)
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewDidLoad:
            return fetchUserAlarmUseCase
                .execute()
                .asObservable()
                .compactMap { $0 }
                .flatMap { response -> Observable<Mutation> in
                    return .just(.setProfileAlarmEntity(response))
                }
        case let .didChangeVoteStatus(isOn):
            guard let response = currentState.alarmEntity else { return .empty() }
            let updateUserAlarmRequest = UpdateUserProfileAlarmRequest(
                isEnableVoteNotification: isOn,
                isEnableMessageNotification: response.isEnableMessageNotification,
                isEnableMarketingNotification: response.isEnableMarketingNotification
            )
            return updateUserAlarmUseCase
                .execute(body: updateUserAlarmRequest)
                .asObservable()
                .flatMap { isUpdate -> Observable<Mutation> in
                    return .just(.setUpdateAlarm(isUpdate))
                }
            
        case let .didChangeSentStatus(isOn):
            guard let response = currentState.alarmEntity else { return .empty() }
            let updateUserAlarmRequest = UpdateUserProfileAlarmRequest(
                isEnableVoteNotification: response.isEnableVoteNotification,
                isEnableMessageNotification: isOn,
                isEnableMarketingNotification: response.isEnableMarketingNotification
            )
            return updateUserAlarmUseCase
                .execute(body: updateUserAlarmRequest)
                .asObservable()
                .flatMap { isUpdate -> Observable<Mutation> in
                    return .just(.setUpdateAlarm(isUpdate))
                }
        case let .didChangeEventStatus(isOn):
            guard let response = currentState.alarmEntity else { return .empty() }
            let updateUserAlarmRequest = UpdateUserProfileAlarmRequest(
                isEnableVoteNotification: response.isEnableVoteNotification,
                isEnableMessageNotification: response.isEnableMessageNotification,
                isEnableMarketingNotification: isOn
            )
            
            return updateUserAlarmUseCase
                .execute(body: updateUserAlarmRequest)
                .asObservable()
                .flatMap { isUpdate -> Observable<Mutation> in
                    return .just(.setUpdateAlarm(isUpdate))
                }
            
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case let .setProfileAlarmEntity(alarmEntity):
            newState.alarmEntity = alarmEntity
        case let .setUpdateAlarm(isUpdate):
            newState.isUpdate = isUpdate
        }
        return newState
    }
}
