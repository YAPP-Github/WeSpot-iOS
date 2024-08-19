//
//  NotificationViewReactor.swift
//  NotificationFeature
//
//  Created by Kim dohyun on 8/19/24.
//

import Foundation
import NotificationDomain

import ReactorKit

public final class NotificationViewReactor: Reactor {
    
    
    private let fetchUserNotificationItemsUseCase: FetchUserNotificationItemUseCaseProtocol
    private let updateUserNotifcationItemUseCase: UpdateUserNotificationItemUseCaseProtocol
    
    public struct State {
        @Pulse var notificationSection: [NotificationSection]
        @Pulse var notificationEntity: NotificationEntity?
        @Pulse var isSelected: Bool
        @Pulse var selectedType: NotificationType
    }
    
    public enum Action {
        case viewDidLoad
        case didTappedNotificationItem(Int)
    }
    
    public enum Mutation {
        case setNotificationSectionItems([NotificationItem])
        case setNotificationItems(NotificationEntity)
        case setSelectedNotificationItem(Bool)
        case setSelectedType(NotificationType)
    }
    
    public let initialState: State
    
    public init(
        fetchUserNotificationItemsUseCase: FetchUserNotificationItemUseCaseProtocol,
        updateUserNotifcationItemUseCase: UpdateUserNotificationItemUseCaseProtocol
    ) {
        self.initialState = State(
            notificationSection: [],
            isSelected: false,
            selectedType: .vote
        )
        self.fetchUserNotificationItemsUseCase = fetchUserNotificationItemsUseCase
        self.updateUserNotifcationItemUseCase = updateUserNotifcationItemUseCase
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        
        switch action {
        case .viewDidLoad:
            let query =  NotificationReqeustQuery(cursorId: 0)
            return fetchUserNotificationItemsUseCase
                .execute(query: query)
                .asObservable()
                .flatMap { entity -> Observable<Mutation> in
                    guard let entity else { return .empty() }
                    var notificationSectionItem: [NotificationItem] = []
  
                    entity.notifications.forEach {
                        notificationSectionItem.append(
                            .userNotificationItem(
                                NotificationCellReactor(
                                    content: $0.content,
                                    date: $0.date,
                                    isNew: $0.isNew, 
                                    isEnabled: $0.isEnable
                                )
                            )
                        )
                    }
                    return .concat(
                        .just(.setNotificationSectionItems(notificationSectionItem)),
                        .just(.setNotificationItems(entity))
                    )
                }
        case let .didTappedNotificationItem(item):
            guard let response = currentState.notificationEntity?.notifications[item] else { return .empty() }
            
            let path = String(response.id)
            let type = response.type
            return updateUserNotifcationItemUseCase
                .execute(path: path)
                .asObservable()
                .flatMap { isSelected -> Observable<Mutation> in
                    print("notification isSelected: \(isSelected)")
                    guard isSelected else { return .empty() }
                    
                    return .concat(
                        .just(.setSelectedNotificationItem(isSelected)),
                        .just(.setSelectedType(type))
                    )
                }
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case let .setNotificationItems(notificationEntity):
            newState.notificationEntity = notificationEntity
        case let .setNotificationSectionItems(items):
            newState.notificationSection = [.notificationInfo(items)]
        case let .setSelectedType(selectedType):
            newState.selectedType = selectedType
        case let .setSelectedNotificationItem(isSelected):
            newState.isSelected = isSelected
        }
        
        return newState
    }
}
