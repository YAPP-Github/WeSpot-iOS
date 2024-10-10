//
//  VoteBeginViewReactor.swift
//  VoteFeature
//
//  Created by Kim dohyun on 10/10/24.
//

import Foundation

import ReactorKit

public final class VoteBeginViewReactor: Reactor {
    public var initialState: State
    
    public typealias Action = NoAction
    
    public struct State {
        
    }
    
    public init() {
        self.initialState = State()
    }
    
}
