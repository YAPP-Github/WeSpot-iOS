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

public enum InventoryType {
    case receive
    case sent
}

public final class VoteInventoryViewReactor: Reactor {
    
    private let fetchVoteReceiveItemUseCase: FetchVoteReceiveItemUseCaseProtocol
    private let fetchVoteSentItemUseCase: FetchVoteSentItemUseCaseProtocol
    public let initialState: State
    
    public struct State {
        @Pulse var sentEntity: VoteSentEntity?
        @Pulse var receiveEntity: VoteRecevieEntity?
        @Pulse var inventorySection: [VoteInventorySection]
        var isEmpty: Bool
        var inventoryType: InventoryType
    }
    
    public enum Action {
        case fetchReceiveItems
        case fetchSentItems
        case fetchMoreItems(Int)
    }
    
    public enum Mutation {
        case setInventorySection([VoteInventorySection])
        case setReceiveItems(VoteRecevieEntity)
        case setSentItems(VoteSentEntity)
        case setEmptyItems(Bool)
        case setInventoryType(InventoryType)
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
                .voteSentInfo(header: "", items: []),
                .voteReceiveInfo(header: "", items: [])
            ],
            isEmpty: true,
            inventoryType: .receive
        )
    }
    
    
    public func mutate(action: Action) -> Observable<Mutation> {
        
        switch action {
        case .fetchReceiveItems:
            let receiveQuery = VoteReceiveRequestQuery(cursorId: "1")
            return fetchVoteReceiveItemUseCase
                .execute(query: receiveQuery)
                .asObservable()
                .flatMap { entity -> Observable<Mutation> in
                    guard let originalEntity = entity else {
                        return .concat(
                            .just(.setInventoryType(.receive)),
                            .just(.setEmptyItems(false))
                        )
                    }
                    
                    if originalEntity.response.isEmpty {
                        return .concat(
                            .just(.setInventoryType(.receive)),
                            .just(.setEmptyItems(false))
                        )
                    } else {
                        let receiveSection: [VoteInventorySection] = originalEntity.response.map { response in
                            let dateToString = response.date.toDate(with: .dashYyyyMMdd).toFormatRelative()
                            let receiveItem: [VoteInventoryItem] = response.receiveResponse.map {
                                return .voteReceiveItem(
                                    VoteReceiveCellReactor(
                                        isNew: $0.isNew,
                                        title: $0.voteOption.content,
                                        voteCount: $0.voteCount
                                    )
                                )
                            }
                            
                            return .voteReceiveInfo(header: dateToString, items: receiveItem)
                        }
                        
                        return .concat(
                            .just(.setEmptyItems(true)),
                            .just(.setInventoryType(.receive)),
                            .just(.setInventorySection(receiveSection)),
                            .just(.setReceiveItems(originalEntity))
                        )
                    }
                }
        case .fetchSentItems:
            let sentQuery = VoteSentRequestQuery(cursorId: "1")
            return fetchVoteSentItemUseCase
                .execute(query: sentQuery)
                .asObservable()
                .flatMap { entity -> Observable<Mutation> in
                    guard let originalEntity = entity else {
                        return .concat(
                            .just(.setInventoryType(.sent)),
                            .just(.setEmptyItems(false))
                        )
                    }
                    
                    if originalEntity.response.isEmpty {
                        return .concat(
                            .just(.setInventoryType(.sent)),
                            .just(.setEmptyItems(false))
                        )
                    } else {
                        let sentSection: [VoteInventorySection] = originalEntity.response.map { response in
                            let dateToString = response.date.toDate(with: .dashYyyyMMdd).toFormatRelative()
                            let sentItem: [VoteInventoryItem] = response.sentResponse.map {
                                return .voteSentItem(
                                    VoteSentCellReactor(
                                        title: $0.voteContent.voteOption.content,
                                        userName: $0.voteContent.voteUser.name,
                                        profileImage: $0.voteContent.voteUser.profile.iconUrl
                                    )
                                )
                            }
                            return .voteSentInfo(header: dateToString, items: sentItem)
                        }
                        return .concat(
                            .just(.setEmptyItems(true)),
                            .just(.setInventoryType(.sent)),
                            .just(.setInventorySection(sentSection)),
                            .just(.setSentItems(originalEntity))
                        )
                    }
            }
        case let .fetchMoreItems(index):
            //TODO: 추후 로직 추가
            switch currentState.inventoryType {
            case .receive:
                let curosrId = currentState.receiveEntity
                return .empty()
            case .sent:
                return .empty()
            }
            
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case let .setInventoryType(inventoryType):
            newState.inventoryType = inventoryType
        case let .setReceiveItems(receiveEntity):
            newState.receiveEntity = receiveEntity
        case let .setSentItems(sentEntity):
            newState.sentEntity = sentEntity
        case let .setInventorySection(inventorySection):
            newState.inventorySection = inventorySection
        case let .setEmptyItems(isEmpty):
            newState.isEmpty = isEmpty
        }
        
        return newState
    }
}
