//
//  VoteReceiveCellReactor.swift
//  VoteFeature
//
//  Created by Kim dohyun on 8/8/24.
//

import Foundation

import ReactorKit

public final class VoteReceiveCellReactor: Reactor {
    public let initialState: State
    
    public typealias Action = NoAction
    
    public struct State {
        var isNew: Bool
        var title: String
        var voteCount: Int
    }
    
    init(isNew: Bool, title: String, voteCount: Int) {
        self.initialState = State(isNew: isNew, title: title, voteCount: voteCount)
    }
}
