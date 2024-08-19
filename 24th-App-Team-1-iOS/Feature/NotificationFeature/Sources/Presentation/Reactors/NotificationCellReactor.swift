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
        var type: String
        var isNew: Bool
    }
    
    public init(content: String, date: String, type: String, isNew: Bool) {
        self.initialState = State(content: content, date: date, type: type, isNew: isNew)
    }
}
