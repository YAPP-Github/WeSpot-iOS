//
//  VoteInventoryDetailViewReactor.swift
//  VoteFeature
//
//  Created by Kim dohyun on 8/9/24.
//

import Foundation
import VoteDomain
import Extensions

import ReactorKit

public final class VoteInventoryDetailViewReactor: Reactor {
    public var initialState: State
    private let fetchIndividualItemUseCase: FetchIndividualItemUseCaseProtocol
    
    public struct State {
        @Pulse var receiveEntity: VoteIndividualEntity?
        var voteId: Int
    }
    
    public enum Action {
        case viewDidLoad
    }
    
    public enum Mutation {
        case setReceiveEntity(VoteIndividualEntity)
    }
    
    public init(
        fetchIndividualItemUseCase: FetchIndividualItemUseCaseProtocol,
        voteId: Int
    ) {
        self.initialState = State(
            receiveEntity: nil,
            voteId: voteId
        )
        self.fetchIndividualItemUseCase = fetchIndividualItemUseCase
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        
        
        switch action {
        case .viewDidLoad:
            let query = VoteIndividualQuery(date: Date().toFormatString(with: .dashYyyyMMdd))
            return fetchIndividualItemUseCase
                .execute(id: currentState.voteId, query: query)
                .asObservable()
                .flatMap { entity -> Observable<Mutation> in
                    guard let originalEntity = entity else { return .empty() }
                    
                    return .just(.setReceiveEntity(originalEntity))
                }
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case let .setReceiveEntity(receiveEntity):
            newState.receiveEntity = receiveEntity
        }
        
        return newState
    }
}
