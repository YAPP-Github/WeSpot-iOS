//
//  VoteHighCellReactor.swift
//  VoteFeature
//
//  Created by Kim dohyun on 7/30/24.
//

import Foundation
import VoteDomain

import ReactorKit

public final class VoteHighCellReactor: Reactor {
    
    public let initialState: State
    public typealias Action = NoAction
    
    public struct State {
        @Pulse var highUser: VoteAllUserEntity
        var voteCount: Int
        var ranker: Int
    }
    
    public init(highUser: VoteAllUserEntity, voteCount: Int, ranker: Int) {
        self.initialState = State(highUser: highUser, voteCount: voteCount, ranker: ranker)
    }
}
