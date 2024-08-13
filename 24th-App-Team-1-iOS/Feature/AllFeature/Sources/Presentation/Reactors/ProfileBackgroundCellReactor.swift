//
//  ProfileBackgroundCellReactor.swift
//  AllFeature
//
//  Created by Kim dohyun on 8/13/24.
//

import Foundation
import Util

import ReactorKit


public final class ProfileBackgroundCellReactor: Reactor {
    public typealias Action = NoAction
    private let globalService: WSGlobalServiceProtocol = WSGlobalStateService.shared
    public var initialState: State
    
    public struct State {
        var backgroundColor: String
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
                case let .didTappedEditItem(item):
                    return .just(.setSelectedItem(item))
                default:
                    return .empty()
                }
            }
        
        return .merge(mutation, didSelectedItem)
    }
    
    init(backgroundColor: String, item: Int) {
        self.initialState = State(backgroundColor: backgroundColor, item: item)
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case let .setSelectedItem(selectedItem):
            print("selectedItem Test: \(selectedItem)")
            newState.selectedItem = selectedItem
        }
        
        return newState
    }
    
}
