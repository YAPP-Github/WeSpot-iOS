//
//  ProfileUserBlockViewReactor.swift
//  AllFeature
//
//  Created by Kim dohyun on 8/15/24.
//

import Foundation
import AllDomain
import Util

import ReactorKit

public final class ProfileUserBlockViewReactor: Reactor {
    
    private let fetchUserBlockUseCase: FetchUserBlockUseCaseProtocol
    private let updateUserBlockUseCase: UpdateUserBlockUseCaseProtocol
    private let globalState: WSGlobalServiceProtocol = WSGlobalStateService.shared
    
    public struct State {
        @Pulse var userBlockSection: [ProfileUserBlockSection]
        @Pulse var userBlockEntity: UserBlockEntity?
        @Pulse var isLoading: Bool
        var userPageBlockItems: [ProfileUserBlockItem]
        @Pulse var userBlockId: String
    }
    
    public enum Action {
        case viewDidLoad
        case didTappedUserBlockButton
        case fetchMoreUserBlockItems
    }
    
    public enum Mutation {
        case setUserBlockProfileItems([ProfileUserBlockItem])
        case setUserBlockItems(UserBlockEntity)
        case setUserBlockId(String)
        case setLoading(Bool)
        
    }
    
    public let initialState: State
    
    public init(
        fetchUserBlockUseCase: FetchUserBlockUseCaseProtocol,
        updateUserBlockUseCase: UpdateUserBlockUseCaseProtocol
    ) {
        self.initialState = State(
            userBlockSection: [],
            isLoading: false, 
            userPageBlockItems: [],
            userBlockId: ""
        )
        self.fetchUserBlockUseCase = fetchUserBlockUseCase
        self.updateUserBlockUseCase = updateUserBlockUseCase
    }
    
    public func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
        let didTappedBlockButton = globalState.event
            .withUnretained(self)
            .flatMap { owner,event -> Observable<Mutation> in
                switch event {
                case let .didTappedBlockButton(messageId):
                    return .just(.setUserBlockId("\(messageId)"))
                default:
                    return .empty()
                }
            }
        return .merge(mutation, didTappedBlockButton)
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        
        switch action {
        case .viewDidLoad:
            let query = UserBlockRequestQuery(cursorId: 0)
            return fetchUserBlockUseCase
                .execute(query: query)
                .asObservable()
                .flatMap { entity -> Observable<Mutation> in
                    var blockSectionItem: [ProfileUserBlockItem] = []
                    guard let entity else { return .empty() }
                    
                    entity.message.forEach {
                        blockSectionItem.append(
                            .userBlockItem(
                                ProfileUserBlockCellReactor(
                                    messageId: $0.id,
                                    senderName: $0.senderName,
                                    backgoundColor: $0.senderProfile.backgroundColor,
                                    iconURL: $0.senderProfile.iconUrl
                                )
                            )
                        )
                    }
                    return .concat(
                        .just(.setLoading(false)),
                        .just(.setUserBlockProfileItems(blockSectionItem)),
                        .just(.setUserBlockItems(entity)),
                        .just(.setLoading(true))
                    )
            }
        case .didTappedUserBlockButton:
            return updateUserBlockUseCase
                .execute(path: currentState.userBlockId)
                .asObservable()
                .withUnretained(self)
                .flatMap { owner, isUpdate -> Observable<Mutation> in
                    guard isUpdate else { return .empty() }
                    owner.globalState.event.onNext(.didUpdateUserBlockButton(id: owner.currentState.userBlockId))
                    return .empty()
                }
        case .fetchMoreUserBlockItems:
            let cursorId = currentState.userBlockEntity?.lastCursorId ?? 0
            let query = UserBlockRequestQuery(cursorId: cursorId)
            return fetchUserBlockUseCase.execute(query: query)
                .asObservable()
                .filter { $0?.hasNext != false }
                .compactMap { $0 }
                .withUnretained(self)
                .flatMap { owner, entity -> Observable<Mutation> in
                    var originalBlockItems: [ProfileUserBlockItem] = owner.currentState.userPageBlockItems
                    var currentPageBlcokItems: [ProfileUserBlockItem] = []
                    entity.message.forEach {
                        currentPageBlcokItems.append(
                            .userBlockItem(
                                ProfileUserBlockCellReactor(
                                    messageId: $0.id,
                                    senderName: $0.senderName,
                                    backgoundColor: $0.senderProfile.backgroundColor,
                                    iconURL: $0.senderProfile.iconUrl
                                )
                            )
                        )
                    }
                    
                    originalBlockItems.append(contentsOf: currentPageBlcokItems)
                    
                    return .concat(
                        .just(.setLoading(false)),
                        .just(.setUserBlockProfileItems(originalBlockItems)),
                        .just(.setUserBlockItems(entity)),
                        .just(.setLoading(true))
                    )
                }
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setLoading(isLoading):
            newState.isLoading = isLoading
        case let .setUserBlockProfileItems(items):
            newState.userPageBlockItems = items
            newState.userBlockSection = [.blockInfo(items)]
        case let .setUserBlockItems(userBlockEntity):
            newState.userBlockEntity = userBlockEntity
        case let .setUserBlockId(userBlockId):
            newState.userBlockId = userBlockId
        }
        
        return newState
    }
}
