//
//  MessagePageViewReactor.swift
//  MessageFeature
//
//  Created by eunseou on 7/21/24.
//

import Foundation
import Util

import ReactorKit

final class MessagePageViewReactor: Reactor {

    private let globalService: WSGlobalServiceProtocol = WSGlobalStateService.shared
    
    struct State {
        var pageTypes: MessageTypes
    }
    
    enum Action {
        case updateViewController(Int)
    }
    
    enum Mutation {
        case setViewController(MessageTypes)
    }
    
    public var initialState: State
    
    init() {
        self.initialState = State(pageTypes: .home)
    }
    
    func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
        
        let setToggleStatus = globalService.event
            .flatMap { event -> Observable<Mutation> in
                switch event {
                case .toggleStatus:
                    return .empty()
                case let .toogleMessageType(messsageTypes):
                    return .just(.setViewController(messsageTypes))
                case .didFetchVoteReponseItems(_):
                    return .empty()
                case .didTappedResultButton:
                    return .empty()
                }
            }
        return .merge(mutation, setToggleStatus)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .updateViewController(pageIndex):
            return .just(.setViewController(pageIndex == 0 ? .home : .storage))
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
