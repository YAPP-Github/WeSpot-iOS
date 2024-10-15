//
//  NotificationViewReactor.swift
//  NotificationFeature
//
//  Created by Kim dohyun on 8/19/24.
//

import Foundation
import Extensions
import NotificationDomain
import CommonDomain

import ReactorKit

public final class NotificationViewReactor: Reactor {
    
    
    private let fetchUserNotificationItemsUseCase: FetchUserNotificationItemUseCaseProtocol
    private let updateUserNotifcationItemUseCase: UpdateUserNotificationItemUseCaseProtocol
    private let fetchVoteOptionUseCase: FetchVoteOptionsUseCaseProtocol
    
    public struct State {
        @Pulse var notificationSection: [NotificationSection]
        var notificationItems: [NotificationItem]
        @Pulse var voteResponseEntity: VoteResponseEntity?
        @Pulse var notificationEntity: NotificationEntity?
        @Pulse var notificationItemEntity: [NotificationItemEntity]
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
        case setNotificationItemEntity([NotificationItemEntity])
        case setVoteResponseItems(VoteResponseEntity?)
        case setSelectedNotificationItem(Bool)
        case setSelectedNotificationDate(Bool)
        case setSelectedType(NotificationType)
    }
    
    public let initialState: State
    
    public init(
        fetchUserNotificationItemsUseCase: FetchUserNotificationItemUseCaseProtocol,
        updateUserNotifcationItemUseCase: UpdateUserNotificationItemUseCaseProtocol,
        fetchVoteOptionUseCase: FetchVoteOptionsUseCaseProtocol
    ) {
        self.initialState = State(
            notificationSection: [],
            notificationItems: [],
            notificationItemEntity: [],
            isSelected: false,
            selectedType: .none,
            isCurrentDate: false
        )
        self.fetchUserNotificationItemsUseCase = fetchUserNotificationItemsUseCase
        self.updateUserNotifcationItemUseCase = updateUserNotifcationItemUseCase
        self.fetchVoteOptionUseCase = fetchVoteOptionUseCase
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        
        //TODO: ViewDidLoad에서 데이터(투표) 조회
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
                                    date: $0.createdAt.toDate(with: .yyyyMMddTHHmmssSSSSSS).toCustomFormatRelative(),
                                    isNew: $0.isNew,
                                    isEnabled: $0.isEnable
                                )
                            )
                        )
                    }
                    return .concat(
                        .just(.setNotificationSectionItems(notificationSectionItem)),
                        .just(.setNotificationItemEntity(entity.notifications)),
                        .just(.setNotificationItems(entity))
                    )
                }
        case let .didTappedNotificationItem(item):
            let response = currentState.notificationItemEntity[item]
            
            let path = String(response.id)
            let type = response.type
            let isCurrentDate = Date().isFutureDay(response.date.toDate(with: .dashYyyyMMdd))
            guard type != .vote else {
                return fetchVoteOptionUseCase
                    .execute()
                    .asObservable()
                    .withUnretained(self)
                    .flatMap { owner, response -> Observable<Mutation> in
                        return owner.updateUserNotifcationItemUseCase
                            .execute(path: path)
                            .asObservable()
                            .flatMap { isSelected -> Observable<Mutation> in
                                return .concat(
                                    .just(.setVoteResponseItems(response)),
                                    .just(.setSelectedType(type)),
                                    .just(.setSelectedNotificationDate(isCurrentDate)),
                                    .just(.setSelectedNotificationItem(isSelected))
                                )
                            }
                        
                    }
                
            }
        
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
                .withUnretained(self)
                .flatMap { owner ,entity -> Observable<Mutation> in
                    var displaySectionItem: [NotificationItem] = owner.currentState.notificationItems
                    var displayNotificationEntity: [NotificationItemEntity] = owner.currentState.notificationItemEntity
                    var originalSectionItem: [NotificationItem] = []
                    guard let entity,
                          !entity.notifications.isEmpty else {
                        return .just(.setNotificationSectionItems(displaySectionItem))
                    }
                    
                    entity.notifications.forEach {
                        originalSectionItem.append(
                            .userNotificationItem(
                                NotificationCellReactor(
                                    content: $0.content,
                                    date: $0.createdAt.toDate(with: .yyyyMMddTHHmmssSSSSSS).toCustomFormatRelative(),
                                    isNew: $0.isNew,
                                    isEnabled: $0.isEnable
                                )
                            )
                        )
                    }
                    displayNotificationEntity.append(contentsOf: entity.notifications)
                    displaySectionItem.append(contentsOf: originalSectionItem)
                    return .concat(
                        .just(.setNotificationSectionItems(displaySectionItem)),
                        .just(.setNotificationItemEntity(displayNotificationEntity)),
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
        case let .setNotificationItemEntity(notificationItemEntity):
            newState.notificationItemEntity = notificationItemEntity
        case let .setVoteResponseItems(voteResponseEntity):
            newState.voteResponseEntity = voteResponseEntity
        }
        
        return newState
    }
}
