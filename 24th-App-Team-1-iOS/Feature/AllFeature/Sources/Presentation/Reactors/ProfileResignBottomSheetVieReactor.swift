//
//  ProfileResignBottomSheetVieReactor.swift
//  AllFeature
//
//  Created by Kim dohyun on 8/17/24.
//

import Foundation

import ReactorKit
import Util

public final class ProfileResignBottomSheetVieReactor: Reactor {
    public var initialState: State
    private let globalState: WSGlobalServiceProtocol = WSGlobalStateService.shared
    
    
    
    public enum Action {
        case didTappedResignConfirmButton
        case didTappedAgreementButton
    }
    
    public enum Mutation {
        case setAgreementEnabled(Bool)
    }
    
    public struct State {
        var isEnabled: Bool
    }
    
    public init() {
        self.initialState = State(isEnabled: false)
    }
    
    
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .didTappedResignConfirmButton:
            globalState.event.onNext(.didTappedResignButton(true))
            return .empty()
        case .didTappedAgreementButton:
            return .just(.setAgreementEnabled(!currentState.isEnabled))
        }
    }
    
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case let .setAgreementEnabled(isEnabled):
            newState.isEnabled = isEnabled
        }
        
        return newState
    }
    
}
