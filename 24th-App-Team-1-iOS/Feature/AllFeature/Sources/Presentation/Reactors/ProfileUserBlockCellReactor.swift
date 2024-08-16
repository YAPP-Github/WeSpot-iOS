//
//  ProfileUserBlockCellReactor.swift
//  AllFeature
//
//  Created by Kim dohyun on 8/16/24.
//

import Foundation

import ReactorKit

public final class ProfileUserBlockCellReactor: Reactor {
    
    public typealias Action = NoAction
    
    public struct State {
        var messageId: Int
        var senderName: String
        var backgoundColor: String
        var iconURL: URL
    }
    
    public var initialState: State
    
    init(
        messageId: Int,
        senderName: String,
        backgoundColor: String,
        iconURL: URL
    ) {
        self.initialState = State(messageId: messageId, senderName: senderName, backgoundColor: backgoundColor, iconURL: iconURL)
    }
}
