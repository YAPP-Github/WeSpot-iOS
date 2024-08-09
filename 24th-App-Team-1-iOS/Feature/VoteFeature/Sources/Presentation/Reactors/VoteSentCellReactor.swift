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
        var userName: String
        var profileImage: URL
    }
    
    init(title: String, userName: String, profileImage: URL) {
        self.initialState = State(title: title, userName: userName, profileImage: profileImage)
    }
}
