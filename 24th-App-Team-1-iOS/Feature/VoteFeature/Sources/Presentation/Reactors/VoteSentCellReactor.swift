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
        var title: String
        var profileImage: URL
    }
    
    init(title: String, profileImage: URL) {
        self.initialState = State(title: title, profileImage: profileImage)
    }
}
