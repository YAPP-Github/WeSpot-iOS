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
    
    public struct State {
        @Pulse var notificationSection: [NotificationSection]
        @Pulse var notificationEntity: NotificationEntity?
    }
    
    public enum Action {
        case viewDidLoad
    }
    
    public enum Mutation {
        case setNotificationSectionItems([NotificationItem])
        case setNotificationItems(NotificationEntity)
    }
    
    public let initialState: State
    
    public init(fetchUserNotificationItemsUseCase: FetchUserNotificationItemUseCaseProtocol) {
        self.initialState = State(notificationSection: [])
        self.fetchUserNotificationItemsUseCase = fetchUserNotificationItemsUseCase
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
                                    type: $0.type,
                                    isNew: $0.isNew
                                )
                            )
                        )
                    }
                    return .concat(
                        .just(.setNotificationSectionItems(notificationSectionItem)),
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
            newState.notificationSection = [.notificationInfo(items)]
        }
        
        return newState
    }
}
