//
//  MessageStorageViewReactor.swift
//  MessageFeature
//
//  Created by eunseou on 7/20/24.
//

import Foundation

import ReactorKit

public final class MessageStorageViewReactor: Reactor {
    
    public struct State {
        var messageCount: Int = 0
    }
    
    public enum Action {
        case loadMessages
    }
    
    public enum Mutation {
        case setMessageCount(Int)
    }
    
    public var initialState: State
    
    public init() {
        self.initialState = State()
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .loadMessages:
            return .just(.setMessageCount(7))
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setMessageCount(let count):
            newState.messageCount = count
        }
        return newState
    }
}
