//
//  VoteHomeViewReactor.swift
//  VoteFeature
//
//  Created by Kim dohyun on 7/13/24.
//

import Foundation
import Util
import CommonDomain
import Storage

import ReactorKit

public final class VoteHomeViewReactor: Reactor {
    
    private let globalService: WSGlobalServiceProtocol = WSGlobalStateService.shared
    private let fetchVoteOptionUseCase: FetchVoteOptionsUseCaseProtocol
    public let initialState: State
    
    public struct State {
        @Pulse var voteResponseEntity: VoteResponseEntity?
    }
    
    public enum Action {
        case didTappedVoteButton
    }
    
    public enum Mutation {
        case setVoteResponseEntity(VoteResponseEntity?)
    }
    
    public init(fetchVoteOptionUseCase: FetchVoteOptionsUseCaseProtocol) {
        self.initialState = State(
            voteResponseEntity: nil
        )
        self.fetchVoteOptionUseCase = fetchVoteOptionUseCase
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        
        switch action {
        case .didTappedVoteButton:
            UserDefaultsManager.shared.voteRequest = []
            return fetchVoteOptionUseCase.execute()
                .asObservable()
                .flatMap { entity -> Observable<Mutation> in
                    return .just(.setVoteResponseEntity(entity))
                }
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
                
        switch mutation {
        case let .setVoteResponseEntity(voteResponseEntity):
            newState.voteResponseEntity = voteResponseEntity
            
            globalService.event.onNext(.didTappedVoteButton(true, voteOption: voteResponseEntity))
        }
        return newState
    }
}
