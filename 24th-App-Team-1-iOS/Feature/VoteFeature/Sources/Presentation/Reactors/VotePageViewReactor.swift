//
//  VotePageViewReactor.swift
//  VoteFeature
//
//  Created by Kim dohyun on 7/13/24.
//

import Foundation
import Util

import ReactorKit

final class VotePageViewReactor: Reactor {
    
    private let globalService: WSGlobalServiceProtocol = WSGlobalStateService.shared
    
    struct State {
        var pageTypes: VoteTypes
    }
    
    enum Action {
        case updateViewController(Int)
    }
    
    enum Mutation {
        case setViewController(VoteTypes)
    }
    
    public var initialState: State
    
    init() {
        self.initialState = State(pageTypes: .main)
    }
    
    func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
        let setToggleStatus = globalService.event
            .flatMap { event -> Observable<Mutation> in
                switch event {
                case let .toggleStatus(voteTypes):
                    return .just(.setViewController(voteTypes))
                }
            }
        return .merge(mutation, setToggleStatus)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .updateViewController(pageIndex):
            return .just(.setViewController(pageIndex == 0 ? .main : .result))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setViewController(pageTypes):
            newState.pageTypes = pageTypes
        }
        return newState
    }
}
