//
//  NotificationViewReactor.swift
//  NotificationFeature
//
//  Created by Kim dohyun on 8/19/24.
//

import Foundation
import Extensions
import NotificationDomain

import ReactorKit

public final class NotificationViewReactor: Reactor {
    
    
    private let fetchUserNotificationItemsUseCase: FetchUserNotificationItemUseCaseProtocol
    private let updateUserNotifcationItemUseCase: UpdateUserNotificationItemUseCaseProtocol
    
    public struct State {
        @Pulse var notificationSection: [NotificationSection]
        var notificationItems: [NotificationItem]
        @Pulse var notificationEntity: NotificationEntity?
        @Pulse var isSelected: Bool
        @Pulse var selectedType: NotificationType
        @Pulse var isCurrentDate: Bool
    }
    
    public enum Action {
        case viewDidLoad
        case didTappedNotificationItem(Int)
        case fetchMoreItems
    }
    
    public enum Mutation {
        case setNotificationSectionItems([NotificationItem])
        case setNotificationItems(NotificationEntity)
        case setSelectedNotificationItem(Bool)
        case setSelectedNotificationDate(Bool)
        case setSelectedType(NotificationType)
    }
    
    public let initialState: State
    
    public init(
        fetchUserNotificationItemsUseCase: FetchUserNotificationItemUseCaseProtocol,
        updateUserNotifcationItemUseCase: UpdateUserNotificationItemUseCaseProtocol
    ) {
        self.initialState = State(
            notificationSection: [],
            notificationItems: [],
            isSelected: false,
            selectedType: .none,
            isCurrentDate: false
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
            let isCurrentDate = Date().isFutureDay(response.date.toDate(with: .dashYyyyMMdd))
            return updateUserNotifcationItemUseCase
                .execute(path: path)
                .asObservable()
                .withUnretained(self)
                .flatMap { owner, isSelected -> Observable<Mutation> in
                    guard isSelected else { return .empty() }
                    return .concat(
                        .just(.setSelectedType(type)),
                        .just(.setSelectedNotificationDate(isCurrentDate)),
                        .just(.setSelectedNotificationItem(isSelected))
                    )
                }
        case .fetchMoreItems:
            let cursorId = currentState.notificationEntity?.lastCursorId ?? 0
            let query = NotificationReqeustQuery(cursorId: cursorId)
            return fetchUserNotificationItemsUseCase
                .execute(query: query)
                .asObservable()
                .filter { $0?.hasNext != false }
                .withUnretained(self)
                .flatMap { owner ,entity -> Observable<Mutation> in
                    guard let entity else { return .empty() }
                    var displaySectionItem: [NotificationItem] = owner.currentState.notificationItems
                    var originalSectionItem: [NotificationItem] = []
                    
                    entity.notifications.forEach {
                        originalSectionItem.append(
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
                    
                    displaySectionItem.append(contentsOf: originalSectionItem)
                    
                    return .concat(
                        .just(.setNotificationSectionItems(displaySectionItem)),
                        .just(.setNotificationItems(entity))
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
            newState.notificationItems = items
            newState.notificationSection = [.notificationInfo(items)]
        case let .setSelectedType(selectedType):
            newState.selectedType = selectedType
        case let .setSelectedNotificationItem(isSelected):
            newState.isSelected = isSelected
        case let .setSelectedNotificationDate(isCurrentDate):
            newState.isCurrentDate = isCurrentDate
        }
        
        return newState
    }
}
