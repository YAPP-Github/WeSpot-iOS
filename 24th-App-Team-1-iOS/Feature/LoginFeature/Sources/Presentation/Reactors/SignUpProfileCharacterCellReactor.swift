//
//  SignUpProfileCharacterCellReactor.swift
//  LoginFeature
//
//  Created by Kim dohyun on 8/29/24.
//

import Foundation
import Util

import ReactorKit


public final class SignUpProfileCharacterCellReactor: Reactor {
    
    public typealias Action = NoAction
    private let globalService: WSGlobalServiceProtocol = WSGlobalStateService.shared
    public var initialState: State
    
    
    public struct State {
        var iconURL: URL
        var item: Int
        var selectedItem: Int = 0
    }
    
    public enum Mutation {
        case setSelectedItem(Int)
    }
    
    public func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
        let didSelectedItem = globalService.event
            .flatMap { event -> Observable<Mutation> in
                switch event {
                case let .didTappedCharacterItem(item):
                    return .just(.setSelectedItem(item))
                default:
                    return .empty()
                }
            }
        
        return .merge(mutation, didSelectedItem)
    }
    
    
    init(iconURL: URL, item: Int) {
        self.initialState = State(iconURL: iconURL, item: item)
    }
    
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setSelectedItem(selectedItem):
            newState.selectedItem = selectedItem
        }
        
        return newState
    }
    
    
}
