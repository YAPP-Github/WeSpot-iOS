//
//  ProfileAlarmCellReactor.swift
//  AllFeature
//
//  Created by Kim dohyun on 8/15/24.
//

import Foundation

import ReactorKit


public final class ProfileAlarmCellReactor: Reactor {

    
    
    public typealias Action = NoAction
    
    public struct State {
        var isOn: Bool
        var content: String
        var descrption: String
    }
    
    public var initialState: State
    
    public init(isOn: Bool, content: String, descrption: String) {
        self.initialState = State(isOn: isOn, content: content, descrption: descrption)
    }
    
}
