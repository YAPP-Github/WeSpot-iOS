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
    
    public init() {
        self.initialState = State(
            voteTypes: .main,
            voteResponseStub: []
        )
    }
    
    public enum Action {
        case didTapToggleButton(VoteTypes)
    }
    
    public struct State {
        var voteTypes: VoteTypes
        @Pulse var voteResponseEntity: VoteResponseEntity?
        @Pulse var voteResponseStub: [CreateVoteItemReqeuest]
    }
    
    public enum Mutation {
        case setVoteTypes(VoteTypes)
        case setVoteResponseItems(VoteResponseEntity)
        case setVoteUserItems
    }
    
    public func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
        let fetchVoteResponse = globalService.event
            .flatMap { event -> Observable<Mutation> in
                switch event {
                case let .didFetchVoteReponseItems(response):
                    return .concat(
                        .just(.setVoteResponseItems(response)),
                        .just(.setVoteUserItems)
                    )
                default:
                    return .empty()
                }
            }
        return .merge(mutation, fetchVoteResponse)
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .didTapToggleButton(voteTypes):
            return .just(.setVoteTypes(voteTypes))
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setVoteTypes(voteTypes):
            globalService.event.onNext(.toggleStatus(voteTypes))
            newState.voteTypes = voteTypes
            
        case let .setVoteResponseItems(voteResponseEntity):
            newState.voteResponseEntity = voteResponseEntity
        case .setVoteUserItems:
            newState.voteResponseStub = []
        }
        
        return newState
    }
}
