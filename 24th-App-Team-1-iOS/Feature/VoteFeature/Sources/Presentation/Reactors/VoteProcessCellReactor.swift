//
//  VoteProcessCellReactor.swift
//  VoteFeature
//
//  Created by Kim dohyun on 7/25/24.
//

import Foundation

import ReactorKit


public final class VoteProcessCellReactor: Reactor {
    public var initialState: State
    
    public typealias Action = NoAction
    
    public struct State: Identifiable {
        public let id: Int
        public let content: String
    }
    
    init(id: Int, content: String) {
        self.initialState = State(id: id, content: content)
    }
}
