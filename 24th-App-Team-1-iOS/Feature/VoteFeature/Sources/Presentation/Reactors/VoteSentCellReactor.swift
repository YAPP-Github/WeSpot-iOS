//
//  VoteSentCellReactor.swift
//  VoteFeature
//
//  Created by Kim dohyun on 8/8/24.
//

import Foundation

import ReactorKit

public final class VoteSentCellReactor: Reactor {
    
    public let initialState: State
    
    public typealias Action = NoAction
    
    public struct State {
        var titleContent: String
        var subContent: String
    }
    
    init(titleContent: String, subContent: String) {
        self.initialState = State(titleContent: titleContent, subContent: subContent)
    }
}
