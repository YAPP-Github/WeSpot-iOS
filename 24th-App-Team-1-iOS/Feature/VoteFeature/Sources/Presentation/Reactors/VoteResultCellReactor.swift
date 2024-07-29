//
//  VoteResultCellReactor.swift
//  VoteFeature
//
//  Created by Kim dohyun on 7/29/24.
//

import Foundation

import ReactorKit
import VoteDomain


public final class VoteResultCellReactor: Reactor {
    public var initialState: State
    
    public typealias Action = NoAction
    
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
}
