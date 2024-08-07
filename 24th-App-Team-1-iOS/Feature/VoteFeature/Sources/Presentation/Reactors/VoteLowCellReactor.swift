//
//  VoteLowCellReactor.swift
//  VoteFeature
//
//  Created by Kim dohyun on 7/30/24.
//

import Foundation

import VoteDomain
import ReactorKit


public final class VoteLowCellReactor: Reactor {
    
    public let initialState: State
    
    public typealias Action = NoAction
    
    public struct State {
        @Pulse var lowUser: VoteAllUserEntity
        var rank: Int
        var voteCount: Int
    }
    
    init(lowUser: VoteAllUserEntity, rank: Int, voteCount: Int) {
        self.initialState = State(lowUser: lowUser, rank: rank, voteCount: voteCount)
    }
}
