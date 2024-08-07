//
//  VotePageViewReactor.swift
//  VoteFeature
//
//  Created by Kim dohyun on 7/13/24.
//

import Foundation
import Util

import ReactorKit

public final class VotePageViewReactor: Reactor {
    
    private let globalService: WSGlobalServiceProtocol = WSGlobalStateService.shared
    
    public struct State {
        var pageTypes: VoteTypes
    }
    
    public enum Action {
        case updateViewController(Int)
    }
    
    public enum Mutation {
        case setViewController(VoteTypes)
    }
    
    public var initialState: State
    
    public init() {
        self.initialState = State(pageTypes: .main)
    }
    
    public func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
        let setToggleStatus = globalService.event
            .flatMap { event -> Observable<Mutation> in
                switch event {
                case let .toggleStatus(voteTypes):
                    return .just(.setViewController(voteTypes))
                case .toogleMessageType(_):
                    return .empty()
                }
            }
        return .merge(mutation, setToggleStatus)
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .updateViewController(pageIndex):
            return .just(.setViewController(pageIndex == 0 ? .main : .result))
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setViewController(pageTypes):
            newState.pageTypes = pageTypes
        }
        return newState
    }
}
