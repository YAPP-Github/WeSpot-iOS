//
//  VoteMainViewReactor.swift
//  VoteFeature
//
//  Created by Kim dohyun on 7/11/24.
//

import Foundation
import Util

import ReactorKit

public final class VoteMainViewReactor: Reactor {
    public var initialState: State
    private let globalService: WSGlobalServiceProtocol = WSGlobalStateService.shared
    
    public init() {
        self.initialState = State(
            voteTypes: .main
        )
    }
    
    public enum Action {
        case didTapToggleButton(VoteTypes)
    }
    
    public struct State {
        var voteTypes: VoteTypes
    }
    
    public enum Mutation {
        case setVoteTypes(VoteTypes)
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
        }
        
        return newState
    }
}
