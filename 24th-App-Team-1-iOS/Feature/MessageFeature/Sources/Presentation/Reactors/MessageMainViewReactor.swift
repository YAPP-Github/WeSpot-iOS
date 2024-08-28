//
//  MessageMainViewReactor.swift
//  MessageFeature
//
//  Created by eunseou on 7/21/24.
//

import Foundation
import Util

import ReactorKit

public final class MessageMainViewReactor: Reactor {
    
    public var initialState: State
    private let globalService: WSGlobalServiceProtocol
    
    public init(globalService: WSGlobalServiceProtocol = WSGlobalStateService.shared) {
        self.globalService = globalService
        self.initialState = State(
            messageTypes: .home,
            isLoading: false
        )
    }
    
    public enum Action {
        case viewDidLoad
        case didTapToggleButton(MessageTypes)
    }
    
    public struct State {
        var messageTypes: MessageTypes
        @Pulse var isLoading: Bool
    }
    
    public enum Mutation {
        case setVoteTypes(MessageTypes)
        case setLoading(Bool)
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewDidLoad:
            return .just(.setLoading(true))
            
        case let .didTapToggleButton(messageTypes):
            return .just(.setVoteTypes(messageTypes))
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setLoading(isLoading):
            newState.isLoading = isLoading
        case let .setVoteTypes(messageTypes):
            globalService.event.onNext(.toogleMessageType(messageTypes))
            newState.messageTypes = messageTypes
        }
        return newState
    }
    
}
