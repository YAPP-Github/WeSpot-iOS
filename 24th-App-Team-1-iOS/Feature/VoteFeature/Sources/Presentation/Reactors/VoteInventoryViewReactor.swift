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
        @Pulse var receiveResponseEntity: [VoteReceiveItemEntity]?
        @Pulse var sentResponseEntity: [VoteSentItemEntity]?
        @Pulse var inventorySection: [VoteInventorySection]
        @Pulse var isLoading: Bool
        var isEmpty: Bool
        var inventoryType: InventoryType
        @Pulse var voteId: Int?
        @Pulse var voteDate: String
    }
    
    public enum Action {
        case fetchReceiveItems
        case fetchSentItems
        case fetchMoreItems
        case didTappedItems(Int, Int)
    }
    
    public enum Mutation {
        case setInventorySection([VoteInventorySection])
        case setReceiveItems(VoteRecevieEntity)
        case setSentItems(VoteSentEntity)
        case setReceiveResposeItem([VoteReceiveItemEntity])
        case setSentResponseItem([VoteSentItemEntity])
        case setEmptyItems(Bool)
        case setVoteId(Int, String)
        case setLoading(Bool)
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
                .voteSentInfo(items: []),
                .voteReceiveInfo(items: [])
            ],
            isLoading: false,
            isEmpty: true,
            inventoryType: .receive,
            voteDate: ""
        )
    }
    
    
    public func mutate(action: Action) -> Observable<Mutation> {
        
        switch action {
        case .fetchReceiveItems:
            let receiveQuery = VoteReceiveRequestQuery(cursorId: "0")
            return fetchVoteReceiveItemUseCase
                .execute(query: receiveQuery)
                .asObservable()
                .flatMap { entity -> Observable<Mutation> in
                    guard let originalEntity = entity else {
                        return .concat(
                            .just(.setLoading(false)),
                            .just(.setInventoryType(.receive)),
                            .just(.setEmptyItems(false)),
                            .just(.setLoading(true))
                        )
                    }
                    
                    if originalEntity.response.isEmpty {
                        return .concat(
                            .just(.setLoading(false)),
                            .just(.setInventoryType(.receive)),
                            .just(.setEmptyItems(false)),
                            .just(.setLoading(true))
                        )
                    } else {
                        let receiveSection: [VoteInventorySection] = originalEntity.response.map { response in
                            let receiveItem: [VoteInventoryItem] = response.receiveResponse.map {
                                return .voteReceiveItem(
                                    VoteReceiveCellReactor(
                                        isNew: $0.isNew,
                                        title: $0.voteOption.content,
                                        voteCount: $0.voteCount
                                    )
                                )
                            }
                            
                            return .voteReceiveInfo(items: receiveItem)
                        }
                        
                        return .concat(
                            .just(.setLoading(false)),
                            .just(.setEmptyItems(true)),
                            .just(.setInventoryType(.receive)),
                            .just(.setReceiveItems(originalEntity)),
                            .just(.setReceiveResposeItem(originalEntity.response)),
                            .just(.setInventorySection(receiveSection)),
                            .just(.setLoading(true))
                        )
                    }
                }
        case .fetchSentItems:
            let sentQuery = VoteSentRequestQuery(cursorId: "0")
            return fetchVoteSentItemUseCase
                .execute(query: sentQuery)
                .asObservable()
                .flatMap { entity -> Observable<Mutation> in
                    guard let originalEntity = entity else {
                        return .concat(
                            .just(.setLoading(false)),
                            .just(.setInventoryType(.sent)),
                            .just(.setEmptyItems(false)),
                            .just(.setLoading(true))
                        )
                    }
                    
                    if originalEntity.response.isEmpty {
                        return .concat(
                            .just(.setLoading(false)),
                            .just(.setInventoryType(.sent)),
                            .just(.setEmptyItems(false)),
                            .just(.setLoading(true))
                        )
                    } else {
                        let sentSection: [VoteInventorySection] = originalEntity.response.map { response in
                            let sentItem: [VoteInventoryItem] = response.sentResponse.map {
                                return .voteSentItem(
                                    VoteSentCellReactor(
                                        title: $0.voteContent.voteOption.content,
                                        userName: $0.voteContent.voteUser.name,
                                        profileImage: $0.voteContent.voteUser.profile.iconUrl
                                    )
                                )
                            }
                            return .voteSentInfo(items: sentItem)
                        }
                        return .concat(
                            .just(.setLoading(false)),
                            .just(.setEmptyItems(true)),
                            .just(.setInventoryType(.sent)),
                            .just(.setInventorySection(sentSection)),
                            .just(.setSentResponseItem(originalEntity.response)),
                            .just(.setSentItems(originalEntity)),
                            .just(.setLoading(true))
                        )
                    }
                }
        case .fetchMoreItems:
            switch currentState.inventoryType {
            case .receive:
                let cursorId = String(currentState.receiveEntity?.lastCursorId ?? 0)
                var receiveResponse = currentState.receiveResponseEntity ?? []
                let receiveQuery = VoteReceiveRequestQuery(cursorId: cursorId)
                
                return fetchVoteReceiveItemUseCase
                    .execute(query: receiveQuery)
                    .asObservable()
                    .compactMap{ $0 }
                    .withUnretained(self)
                    .flatMap { owner ,entity -> Observable<Mutation> in
                        var originalSection = owner.currentState.inventorySection
                        if entity.response.isEmpty {
                            return .concat(
                                .just(.setLoading(false)),
                                .just(.setInventoryType(.receive)),
                                .just(.setInventorySection(originalSection)),
                                .just(.setLoading(true))
                            )
                        }
                        let receiveSection: [VoteInventorySection] = entity.response.map { response in
                            
                            let receiveItem: [VoteInventoryItem] = response.receiveResponse.map {
                                return .voteReceiveItem(
                                    VoteReceiveCellReactor(
                                        isNew: $0.isNew,
                                        title: $0.voteOption.content,
                                        voteCount: $0.voteCount
                                    )
                                )
                            }
                            return .voteReceiveInfo(items: receiveItem)
                        }
                        receiveResponse.append(contentsOf: entity.response)
                        originalSection.append(contentsOf: receiveSection)
                        return .concat(
                            .just(.setLoading(false)),
                            .just(.setReceiveItems(entity)),
                            .just(.setInventorySection(originalSection)),
                            .just(.setReceiveResposeItem(receiveResponse)),
                            .just(.setInventoryType(.receive)),
                            .just(.setLoading(true))
                        )
                    }
                
            case .sent:
                let cursorId = String(currentState.sentEntity?.lastCursorId ?? 0)
                var sentResponse = currentState.sentResponseEntity ?? []
                let sentQuery = VoteSentRequestQuery(cursorId: cursorId)
                
                return fetchVoteSentItemUseCase
                    .execute(query: sentQuery)
                    .asObservable()
                    .compactMap { $0 }
                    .withUnretained(self)
                    .flatMap { owner, entity -> Observable<Mutation> in
                        var originalSection = owner.currentState.inventorySection
                        if entity.response.isEmpty {
                            return .concat(
                                .just(.setLoading(false)),
                                .just(.setInventoryType(.sent)),
                                .just(.setInventorySection(originalSection)),
                                .just(.setLoading(true))
                            )
                        }
                        
                        let sentSection: [VoteInventorySection] = entity.response.map { response in
                            let sentItem: [VoteInventoryItem] = response.sentResponse.map {
                                return .voteSentItem(
                                    VoteSentCellReactor(
                                        title: $0.voteContent.voteOption.content,
                                        userName: $0.voteContent.voteUser.name,
                                        profileImage: $0.voteContent.voteUser.profile.iconUrl
                                    )
                                )
                            }
                            return .voteSentInfo(items: sentItem)
                        }
                        sentResponse.append(contentsOf: entity.response)
                        originalSection.append(contentsOf: sentSection)
                        
                        return .concat(
                            .just(.setLoading(false)),
                            .just(.setInventoryType(.sent)),
                            .just(.setInventorySection(originalSection)),
                            .just(.setSentResponseItem(sentResponse)),
                            .just(.setSentItems(entity)),
                            .just(.setLoading(true))
                        )
                    }
            }
            
        case let .didTappedItems(index, section):
            guard currentState.inventoryType == .receive else { return .empty() }
            let voteId = currentState.receiveResponseEntity?[section].receiveResponse[index].voteOption.id ?? 0
            let voteDate = currentState.receiveResponseEntity?[section].date ?? ""
            return .just(.setVoteId(voteId, voteDate))
            
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case let .setLoading(isLoading):
            newState.isLoading = isLoading
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
        case let .setVoteId(voteId, voteDate):
            newState.voteId = voteId
            newState.voteDate = voteDate
        case let .setReceiveResposeItem(receiveResponseEntity):
            newState.receiveResponseEntity = receiveResponseEntity
        case let .setSentResponseItem(sentResponseEntity):
            newState.sentResponseEntity = sentResponseEntity
        }
        
        return newState
    }
}
