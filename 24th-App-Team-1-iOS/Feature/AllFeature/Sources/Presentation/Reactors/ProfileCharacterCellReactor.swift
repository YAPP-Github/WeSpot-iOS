//
//  ProfileCharacterCellReactor.swift
//  AllFeature
//
//  Created by Kim dohyun on 8/13/24.
//

import Foundation
import Util
import Storage

import ReactorKit


public final class ProfileCharacterCellReactor: Reactor {
    
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
    
    init(iconURL: URL, item: Int, selectedItem: Int = 0) {
        print()
        self.initialState = State(iconURL: iconURL, item: item, selectedItem: selectedItem)
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
