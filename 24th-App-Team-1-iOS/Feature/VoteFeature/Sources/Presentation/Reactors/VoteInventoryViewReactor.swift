//
//  VoteInventoryViewReactor.swift
//  VoteFeature
//
//  Created by Kim dohyun on 8/7/24.
//

import Foundation
import VoteDomain
import Extensions

import ReactorKit

enum InventoryType {
    case receive
    case send
}

public final class VoteInventoryViewReactor: Reactor {
    
    private let fetchVoteReceiveItemUseCase: FetchVoteReceiveItemUseCaseProtocol
    private let fetchVoteSentItemUseCase: FetchVoteSentItemUseCaseProtocol
    public let initialState: State
    
    public struct State {
        @Pulse var sentEntity: VoteSentEntity?
        @Pulse var receiveEntity: VoteRecevieEntity?
        @Pulse var inventorySection: [VoteInventorySection]
    }
    
    public enum Action {
        case fetchReceiveItems
        case fetchSentItems
    }
    
    public enum Mutation {
        case setReceiveSection([VoteInventorySection])
        case setReceiveItems(VoteRecevieEntity)
        case setSentItems(VoteSentEntity)
    }
    
    public init(
        fetchVoteReceiveItemUseCase: FetchVoteReceiveItemUseCaseProtocol,
        fetchVoteSentItemUseCase: FetchVoteSentItemUseCaseProtocol
    ) {
        self.fetchVoteReceiveItemUseCase = fetchVoteReceiveItemUseCase
        self.fetchVoteSentItemUseCase = fetchVoteSentItemUseCase
        self.initialState = State(
            sentEntity: nil,
            receiveEntity: nil,
            inventorySection: [
                .voteReceiveInfo([]),
                .voteSentInfo([])
            ]
        )
    }
    
    
    public func mutate(action: Action) -> Observable<Mutation> {
        
        switch action {
        case .fetchReceiveItems:
            return fetchVoteReceiveItemUseCase
                .execute()
                .asObservable()
                .flatMap { entity -> Observable<Mutation> in
                    guard let origialEntity = entity else { return .empty() }
 
                    return .concat(
                        .just(.setReceiveItems(origialEntity))
                    )
                }
        case .fetchSentItems:
            return fetchVoteSentItemUseCase
                .execute()
                .asObservable()
                .flatMap { entity -> Observable<Mutation> in
                    guard let originalEntity = entity else { return .empty() }
                return .just(.setSentItems(originalEntity))
            }
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case let .setReceiveItems(receiveEntity):
            newState.receiveEntity = receiveEntity
        case let .setSentItems(sentEntity):
            newState.sentEntity = sentEntity
        case let .setReceiveSection(inventorySection):
            newState.inventorySection = inventorySection
        }
        
        return newState
    }
}
