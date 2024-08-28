//
//  VoteResultCellReactor.swift
//  VoteFeature
//
//  Created by Kim dohyun on 7/29/24.
//

import Foundation

import ReactorKit
import Util
import VoteDomain


public final class VoteResultCellReactor: Reactor {
    public var initialState: State
    
    private var globalService: WSGlobalServiceProtocol = WSGlobalStateService.shared
    public enum Action {
        case didTappedResultButton
    }
    
    public struct State {
        public let content: String
        public let winnerUser: VoteWinnerUserEntity?
        public let voteCount: Int
    }
    
    init(
        content: String,
        winnerUser: VoteWinnerUserEntity?,
        voteCount: Int
    ) {
        self.initialState = State(
            content: content,
            winnerUser: winnerUser,
            voteCount: voteCount
        )
    }
    
    public func mutate(action: Action) -> Observable<Action> {
        switch action {
        case .didTappedResultButton:
            if currentState.winnerUser == nil {
                globalService.event.onNext(.didTappedFriendButton(true))
            } else {
                globalService.event.onNext(.didTappedResultButton)
            }
            return .empty()
        }
    }
}
