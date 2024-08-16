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
        @Pulse var userBlockId: String
    }
    
    public enum Action {
        case viewDidLoad
        case didTappedUserBlockButton
    }
    
    public enum Mutation {
        case setUserBlockProfileItems([ProfileUserBlockItem])
        case setUserBlockItems(UserBlockEntity)
        case setUserBlockId(String)
        
    }
    
    public let initialState: State
    
    public init(
        fetchUserBlockUseCase: FetchUserBlockUseCaseProtocol,
        updateUserBlockUseCase: UpdateUserBlockUseCaseProtocol
    ) {
        self.initialState = State(
            userBlockSection: [],
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
                        .just(.setUserBlockProfileItems(blockSectionItem)),
                        .just(.setUserBlockItems(entity))
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
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setUserBlockProfileItems(items):
            newState.userBlockSection = [.blockInfo(items)]
        case let .setUserBlockItems(userBlockEntity):
            newState.userBlockEntity = userBlockEntity
        case let .setUserBlockId(userBlockId):
            newState.userBlockId = userBlockId
        }
        
        return newState
    }
}
