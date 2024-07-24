//
//  VoteMainViewReactor.swift
//  VoteFeature
//
//  Created by Kim dohyun on 7/11/24.
//

import Foundation
import Util
import VoteDomain

import ReactorKit

public final class VoteMainViewReactor: Reactor {
    public var initialState: State
    private let globalService: WSGlobalServiceProtocol = WSGlobalStateService.shared
    private let fetchVoteOptionsUseCase: FetchVoteOptionsUseCaseProtocol
    
    public init(fetchVoteOptionsUseCase: FetchVoteOptionsUseCaseProtocol) {
        self.initialState = State(
            voteTypes: .main
        )
        self.fetchVoteOptionsUseCase = fetchVoteOptionsUseCase
    }
    
    public enum Action {
        case didTapToggleButton(VoteTypes)
        case viewDidLoad
    }
    
    public struct State {
        var voteTypes: VoteTypes
        @Pulse var voteItemEntity: VoteResponseEntity?
    }
    
    public enum Mutation {
        case setVoteTypes(VoteTypes)
        case setVoteItems(VoteResponseEntity)
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .didTapToggleButton(voteTypes):
            return .just(.setVoteTypes(voteTypes))
        case .viewDidLoad:
            return fetchVoteOptionsUseCase
                .execute()
                .asObservable()
                .flatMap { entity -> Observable<VoteMainViewReactor.Mutation> in
                    guard let originEntity = entity else { return .empty() }
                    return .just(.setVoteItems(originEntity))
                }
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setVoteTypes(voteTypes):
            globalService.event.onNext(.toggleStatus(voteTypes))
            newState.voteTypes = voteTypes
        case let .setVoteItems(voteEntity):
            newState.voteItemEntity = voteEntity
        }
        
        return newState
    }
}
