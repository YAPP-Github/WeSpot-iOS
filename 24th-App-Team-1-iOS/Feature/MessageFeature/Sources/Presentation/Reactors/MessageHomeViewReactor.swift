//
//  MessageHomeViewReactor.swift
//  MessageFeature
//
//  Created by eunseou on 7/20/24.
//

import Foundation
import MessageDomain
import Extensions

import ReactorKit

public final class MessageHomeViewReactor: Reactor {
    
    private let fetchMessagesStatusUseCase: FetchMessagesStatusUseCaseProtocol
    private let fetchReceivedMessageUseCase: FetchReceivedMessageUseCaseProtocol
    public var initialState: State
    
    public struct State {
        @Pulse var reservedMessages: Int?
        @Pulse var isSendAllowed: Bool?
        @Pulse var recievedMessages: Bool?
    }
    
    public enum Action {
        case fetchReceivedMessageList
        case fetchReservedMessageList
    }
    
    public enum Mutation {
        case setReservedMessagesCount(Int)
        case isSendAllowedState(Bool)
        case setRecievedMessagesBool(Bool)
    }
    
    public init(
        fetchMessagesStatusUseCase: FetchMessagesStatusUseCaseProtocol,
        fetchReceivedMessageUseCase: FetchReceivedMessageUseCaseProtocol
    ) {
        self.fetchMessagesStatusUseCase = fetchMessagesStatusUseCase
        self.fetchReceivedMessageUseCase = fetchReceivedMessageUseCase
        self.initialState = State()
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .fetchReservedMessageList:
            return fetchMessagesStatusUseCase
                .execute()
                .asObservable()
                .flatMap { entity -> Observable<Mutation> in
                    guard let entity else {
                        return .empty()
                    }
                    return Observable.concat(
                        .just(.setReservedMessagesCount(entity.remainingMessages)),
                        .just(.isSendAllowedState(entity.isSendAllowed))
                    )
                }
            
        case .fetchReceivedMessageList:
            return fetchReceivedMessageUseCase
                .execute(cursorId: 0)
                .asObservable()
                .flatMap { entity -> Observable<Mutation> in
                    guard let entity else {
                        return .empty()
                    }
                    let hasMessageToday = self.isReceivedMessageToday(entity.messages.first?.receivedAt ?? "")
                    return .just(.setRecievedMessagesBool(hasMessageToday))
                }
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setReservedMessagesCount(let count):
            newState.reservedMessages = count
        case .setRecievedMessagesBool(let hasMessages):
            newState.recievedMessages = hasMessages
        case .isSendAllowedState(let isAllowed):
            newState.isSendAllowed = isAllowed
        }
        return newState
    }
    
    func isReceivedMessageToday(_ receivedAt: String) -> Bool {
        guard let receivedDate = DateFormatter.iso8601().date(from: receivedAt) else {
            return false
        }
        return receivedDate.isSameDay(as: Date())
    }

}
