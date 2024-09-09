//
//  ProfileWebViewReactor.swift
//  AllFeature
//
//  Created by Kim dohyun on 8/14/24.
//

import Foundation

import ReactorKit

public final class WSWebViewReactor: Reactor {
    
    
    public struct State {
        var contentURL: URL?
    }
    
    public enum Action {
        case viewDidLoad
    }
    
    public enum Mutation {
        
    }
    
    public let initialState: State
    
    public init(contentURL: URL) {
        self.initialState = State(contentURL: contentURL)
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        
        return .empty()
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
                
        return newState
    }
}
