//
//  ProfileUserBlockCellReactor.swift
//  AllFeature
//
//  Created by Kim dohyun on 8/16/24.
//

import Foundation
import Util

import ReactorKit

public final class ProfileUserBlockCellReactor: Reactor {
    
    private let globalState: WSGlobalServiceProtocol = WSGlobalStateService.shared
    
    public enum Action {
        case didTappedUserBlockButton
    }
    
    public enum Mutation {
        case setUserBlockStatus(Bool)
    }
    
    public func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
        let didUpdateUserBlock = globalState.event
            .withUnretained(self)
            .flatMap { owner, event -> Observable<Mutation> in
                switch event {
                case let .didUpdateUserBlockButton(id):
                    let isUpdate = String(owner.currentState.messageId) == id || owner.currentState.isUpdate ? true : false
                    return .just(.setUserBlockStatus(isUpdate))
                default:
                    return .empty()
                }
                
            }
        return .merge(mutation, didUpdateUserBlock)
    }
    
    public struct State {
        var messageId: Int
        var senderName: String
        var backgoundColor: String
        var iconURL: URL
        var isUpdate: Bool
    }
    
    public var initialState: State
    
    init(
        messageId: Int,
        senderName: String,
        backgoundColor: String,
        iconURL: URL
    ) {
        self.initialState = State(messageId: messageId, senderName: senderName, backgoundColor: backgoundColor, iconURL: iconURL, isUpdate: false)
    }
    
    
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .didTappedUserBlockButton:
            globalState.event.onNext(.didTappedBlockButton(currentState.messageId))
            return .empty()
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setUserBlockStatus(isUpdate):
            newState.isUpdate = isUpdate
        }
        
        return newState
    }
    
}
