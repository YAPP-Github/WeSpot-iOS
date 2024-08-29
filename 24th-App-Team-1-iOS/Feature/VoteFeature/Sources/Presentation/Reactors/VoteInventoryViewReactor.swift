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
        @Pulse var isLoading: Bool
        var isEmpty: Bool
        var inventoryType: InventoryType
        @Pulse var voteId: Int?
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
        case setEmptyItems(Bool)
        case setVoteId(Int)
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
                .voteSentInfo(header: "", items: []),
                .voteReceiveInfo(header: "", items: [])
            ], 
            isLoading: false,
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
                            .just(.setLoading(false)),
                            .just(.setEmptyItems(true)),
                            .just(.setInventoryType(.receive)),
                            .just(.setInventorySection(receiveSection)),
                            .just(.setReceiveItems(originalEntity)),
                            .just(.setLoading(true))
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
                            .just(.setLoading(false)),
                            .just(.setEmptyItems(true)),
                            .just(.setInventoryType(.sent)),
                            .just(.setInventorySection(sentSection)),
                            .just(.setSentItems(originalEntity)),
                            .just(.setLoading(true))
                        )
                    }
            }
        case .fetchMoreItems:
            switch currentState.inventoryType {
            case .receive:
                let cursorId = String(currentState.receiveEntity?.lastCursorId ?? 0)
                let receiveQuery = VoteReceiveRequestQuery(cursorId: cursorId)
                
                return fetchVoteReceiveItemUseCase
                    .execute(query: receiveQuery)
                    .asObservable()
                    .filter { $0?.isLastPage == false }
                    .compactMap{ $0 }
                    .withUnretained(self)
                    .flatMap { owner ,entity -> Observable<Mutation> in
                    
                        var originalSection = owner.currentState.inventorySection
                        let receiveSection: [VoteInventorySection] = entity.response.map { response in
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
                        
                        originalSection.append(contentsOf: receiveSection)
                        return .concat(
                            .just(.setLoading(false)),
                            .just(.setInventoryType(.receive)),
                            .just(.setInventorySection(originalSection)),
                            .just(.setReceiveItems(entity)),
                            .just(.setLoading(true))
                        )
                    }
                
            case .sent:
                let cursorId = String(currentState.sentEntity?.lastCursorId ?? 0)
                let sentQuery = VoteSentRequestQuery(cursorId: cursorId)
                
                return fetchVoteSentItemUseCase
                    .execute(query: sentQuery)
                    .asObservable()
                    .filter { $0?.isLastPage == false }
                    .compactMap { $0 }
                    .withUnretained(self)
                    .flatMap { owner, entity -> Observable<Mutation> in
                        
                        var originalSection = owner.currentState.inventorySection
                        let sentSection: [VoteInventorySection] = entity.response.map { response in
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
                        
                        originalSection.append(contentsOf: sentSection)
                        
                        return .concat(
                            .just(.setInventoryType(.sent)),
                            .just(.setInventorySection(originalSection)),
                            .just(.setSentItems(entity))
                        )
                    }
            }
            
        case let .didTappedItems(index, section):
            let voteId = currentState.receiveEntity?.response[section].receiveResponse[index].voteOption.id ?? 0
            
            return .just(.setVoteId(voteId))
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
        case let .setVoteId(voteId):
            newState.voteId = voteId
        }
        
        return newState
    }
}
