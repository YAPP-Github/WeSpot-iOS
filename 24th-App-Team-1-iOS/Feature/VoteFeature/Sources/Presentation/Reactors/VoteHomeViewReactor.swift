//
//  VoteHomeViewReactor.swift
//  VoteFeature
//
//  Created by Kim dohyun on 7/13/24.
//

import Foundation
import Util
import VoteDomain

import ReactorKit

public final class VoteHomeViewReactor: Reactor {
    
    private let globalService: WSGlobalServiceProtocol = WSGlobalStateService.shared
    private let fetchVoteOptionsUseCase: FetchVoteOptionsUseCaseProtocol
    public let initialState: State
    
    public struct State {

    }
    
    public enum Action {
        case didTappedVoteButton
    }
    
    public enum Mutation {
        
    }
    
    public init(fetchVoteOptionsUseCase: FetchVoteOptionsUseCaseProtocol) {
        self.fetchVoteOptionsUseCase = fetchVoteOptionsUseCase
        self.initialState = State()
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        
        switch action {
        case .didTappedVoteButton:
            return fetchVoteOptionsUseCase
                .execute()
                .asObservable()
                .withUnretained(self)
                .flatMap { onwer, entity -> Observable<Mutation> in
                    guard let response = entity else { return .empty() }
                    onwer.globalService.event.onNext(.didFetchVoteReponseItems(response))
                    
                    return .empty()
                }
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
                
        return newState
    }
}
