//
//  VoteEmptyCellReactor.swift
//  VoteFeature
//
//  Created by Kim dohyun on 8/2/24.
//

import Foundation

import ReactorKit

public final class VoteEmptyCellReactor: Reactor {
    public typealias Action = NoAction
    public var initialState: State
    public struct State {
        var content: String
    }
    
    
    init(content: String) {
        self.initialState = State(content: content)
    }
}
