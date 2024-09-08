//
//  VoteMainViewReactor.swift
//  VoteFeature
//
//  Created by Kim dohyun on 7/11/24.
//

import Foundation
import Util
import VoteDomain

import ReactorKit

public final class VoteMainViewReactor: Reactor {
    public var initialState: State
    private let globalService: WSGlobalServiceProtocol = WSGlobalStateService.shared
        
    public enum Action {
        case didTapToggleButton(VoteTypes)
    }
    
    public struct State {
        var voteTypes: VoteTypes
        @Pulse var isShowEffectView: Bool
        @Pulse var isSelected: Bool
        @Pulse var isProfileChanged: Bool
        @Pulse var isProfileUpdate: Bool
    }
    
    public enum Mutation {
        case setVoteTypes(VoteTypes)
        case setSelectedVoteButton(Bool)
        case setShowEffectView(Bool)
        case setUserProfileUpdate(Bool)
    }
    
    public init(isProfileChanged: Bool = true) {
        self.initialState = State(
            voteTypes: .main,
            isShowEffectView: false,
            isSelected: false,
            isProfileChanged: isProfileChanged,
            isProfileUpdate: false
        )
    }
    
    public func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
        let fetchVoteResponse = globalService.event
            .flatMap { event -> Observable<Mutation> in
                switch event {
                case let .didTappedVoteButton(isSelected):
                    return .just(.setSelectedVoteButton(isSelected))
                case .didTappedResultButton:
                    return .just(.setShowEffectView(true))
                case let .didTappedIntroduceButton(isUpdate):
                    return .just(.setUserProfileUpdate(isUpdate))
                default:
                    return .empty()
                }
            }
        return .merge(mutation, fetchVoteResponse)
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .didTapToggleButton(voteTypes):
            return .just(.setVoteTypes(voteTypes))
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setSelectedVoteButton(isSelected):
            newState.isSelected = isSelected
        case let .setVoteTypes(voteTypes):
            globalService.event.onNext(.toggleStatus(voteTypes))
            newState.voteTypes = voteTypes
        case let .setShowEffectView(isShowEffectView):
            newState.isShowEffectView = isShowEffectView
        case let .setUserProfileUpdate(isUpdate):
            newState.isProfileUpdate = isUpdate
        }
        
        return newState
    }
}
