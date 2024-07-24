//
//  ReservedMessageViewReactor.swift
//  MessageFeature
//
//  Created by eunseou on 7/20/24.
//

import Foundation

import ReactorKit

public final class ReservedMessageViewReactor: Reactor {
    
    public struct State {
        @Pulse var messageSection: [ReservedMessageSection]
    }
    
    public enum Action {
        case fetchMessages
    }
    
    public enum Mutation {
        case setMessages([ReservedMessageItem])
    }
    
    public var initialState: State
    
    public init() {
        self.initialState = State(messageSection: [])
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .fetchMessages:
            let messages = [
                ReservedMessageItem(reciptent: "역삼중 1학년 16반 이지호호호", profile: nil),
                ReservedMessageItem(reciptent: "역삼중 1학년 16반 이지호호호", profile: nil),
                ReservedMessageItem(reciptent: "역삼중 1학년 16반 이지호호호", profile: nil)
            ]
            return .just(.setMessages(messages))
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setMessages(let messages):
            newState.messageSection = [.main(messages)]
        }
        return newState
    }
}
