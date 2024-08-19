//
//  NotificationCellReactor.swift
//  NotificationFeature
//
//  Created by Kim dohyun on 8/19/24.
//

import Foundation

import ReactorKit


public final class NotificationCellReactor: Reactor {
    public var initialState: State
    
    public typealias Action = NoAction
    
    public struct State {
        var content: String
        var date: String
        var isNew: Bool
        var isEnabled: Bool
    }
    
    public init(content: String, date: String, isNew: Bool, isEnabled: Bool) {
        self.initialState = State(content: content, date: date, isNew: isNew, isEnabled: isEnabled)
    }
}
