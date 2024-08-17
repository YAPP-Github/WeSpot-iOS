//
//  ProfileResignViewReactor.swift
//  AllFeature
//
//  Created by Kim dohyun on 8/17/24.
//

import Foundation
import Util

import ReactorKit

public final class ProfileResignViewReactor: Reactor {
    
    private let globalState: WSGlobalServiceProtocol = WSGlobalStateService.shared
    
    
    public struct State {
        @Pulse var reasonSection: [ProfileResignReasonSection]
        @Pulse var isEnabled: Bool
        @Pulse var isStatus: Bool
    }
    
    public enum Action {
        case didTappedReasonItems
    }
    
    public enum Mutation {
        case setReasonButtonEnabled(Bool)
        case setResignStatus(Bool)
    }
    
    public let initialState: State
    
    public init() { 
        self.initialState = State(
            reasonSection: [
                .accountResignReasonInfo([
                    .resignReasonItem(
                        ProfileResignCellReactor(
                            contentTitle: "기능이 다양하지 않아요")
                    ),
                    .resignReasonItem(
                        ProfileResignCellReactor(
                            contentTitle: "함께할 친구가 부족해요")
                    ),
                    .resignReasonItem(
                        ProfileResignCellReactor(
                            contentTitle: "선택지가 다양하지 않아요")
                    ),
                    .resignReasonItem(
                        ProfileResignCellReactor(
                            contentTitle: "사양하는 방법이 어려워요")
                    ),
                    .resignReasonItem(
                        ProfileResignCellReactor(
                            contentTitle: "기타")
                    )
                ])
            ],
            isEnabled: false,
            isStatus: false
        )
        
    }
    
    public func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
        let didTappedResignButton = globalState.event
            .flatMap { event -> Observable<Mutation> in
                switch event {
                case let .didTappedResignButton(isStatus):
                    return .just(.setResignStatus(isStatus))
                default:
                    return .empty()
                }
            }
        return .merge(mutation, didTappedResignButton)
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .didTappedReasonItems:
            return .just(.setReasonButtonEnabled(true))
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setReasonButtonEnabled(isEnabled):
            newState.isEnabled = isEnabled
        case let .setResignStatus(isStatus):
            newState.isStatus = isStatus
        }
        
        return newState
    }
}
