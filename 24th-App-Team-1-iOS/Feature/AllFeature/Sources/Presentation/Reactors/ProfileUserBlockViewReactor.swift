//
//  ProfileUserBlockViewReactor.swift
//  AllFeature
//
//  Created by Kim dohyun on 8/15/24.
//

import Foundation
import AllDomain

import ReactorKit

public final class ProfileUserBlockViewReactor: Reactor {
    
    private let fetchUserBlockUseCase: FetchUserBlockUseCaseProtocol
    
    public struct State {
        @Pulse var userBlockSection: [ProfileUserBlockSection]
        @Pulse var userBlockEntity: UserBlockEntity?
    }
    
    public enum Action {
        case viewDidLoad
    }
    
    public enum Mutation {
        case setUserBlockProfileItems([ProfileUserBlockItem])
        case setUserBlockItems(UserBlockEntity)
    }
    
    public let initialState: State
    
    public init(fetchUserBlockUseCase: FetchUserBlockUseCaseProtocol) {
        self.initialState = State(userBlockSection: [])
        self.fetchUserBlockUseCase = fetchUserBlockUseCase
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
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setUserBlockProfileItems(items):
            newState.userBlockSection = [.blockInfo(items)]
        case let .setUserBlockItems(userBlockEntity):
            newState.userBlockEntity = userBlockEntity
        }
        
        return newState
    }
}
