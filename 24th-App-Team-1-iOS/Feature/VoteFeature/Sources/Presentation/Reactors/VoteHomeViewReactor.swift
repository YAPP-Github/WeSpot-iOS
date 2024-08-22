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
    public let initialState: State
    
    public struct State {

    }
    
    public enum Action {
        case didTappedVoteButton
    }
    
    public enum Mutation {
        
    }
    
    public init() {
        self.initialState = State()
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        
        switch action {
        case .didTappedVoteButton:
            globalService.event.onNext(.didTappedVoteButton(true))
                    
            return .empty()
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
                
        return newState
    }
}
