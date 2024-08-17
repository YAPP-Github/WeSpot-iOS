//
//  ProfileResignCellReactor.swift
//  AllFeature
//
//  Created by Kim dohyun on 8/17/24.
//

import Foundation

import ReactorKit

public final class ProfileResignCellReactor: Reactor {
    
    public typealias Action = NoAction
    
    public struct State {
        var contentTitle: String
    }
    
    public var initialState: State
    
    init(contentTitle: String) {
        self.initialState = State(contentTitle: contentTitle)
    }
}
