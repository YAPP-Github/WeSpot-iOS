//
//  PolicyAgreementBottomSheetViewReactor.swift
//  LoginFeature
//
//  Created by Kim dohyun on 8/27/24.
//

import Foundation

import ReactorKit

public final class PolicyAgreementBottomSheetViewReactor: Reactor {
    public var initialState: State
    
    public enum Action {
        case didTappedAllAgreement
        case didTappedPrivacyAgreement
        case didTappedServiceAgreement
        case didTappedMarketingAgreement
    }
    
    public enum Mutation {
        case setupAllAgreement(Bool)
        case setupServiceAgreement(Bool)
        case setupPrivacyAgreement(Bool)
        case setupMarketingAgreement(Bool)
        case setupConfirmButton(Bool)
    }
    
    public struct State {
        var isAllAgreement: Bool
        var isServiceAgreement: Bool
        var isPrivacyAgreement: Bool
        var isMarketingAgreement: Bool
        var isEnabled: Bool
    }
    
    public init() {
        self.initialState = State(
            isAllAgreement: false,
            isServiceAgreement: false,
            isPrivacyAgreement: false,
            isMarketingAgreement: false,
            isEnabled: false
        )
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .didTappedAllAgreement:
            return .concat(
                .just(.setupServiceAgreement(!currentState.isAllAgreement)),
                .just(.setupAllAgreement(!currentState.isAllAgreement)),
                .just(.setupConfirmButton(!currentState.isAllAgreement)),
                .just(.setupMarketingAgreement(!currentState.isAllAgreement)),
                .just(.setupPrivacyAgreement(!currentState.isAllAgreement))
            )
            
        case .didTappedPrivacyAgreement:
            let isEnabled = !currentState.isPrivacyAgreement == true && currentState.isServiceAgreement == true ? true : false
            return .concat(
                .just(.setupPrivacyAgreement(!currentState.isPrivacyAgreement)),
                .just(.setupConfirmButton(isEnabled))
            )
        case .didTappedServiceAgreement:
            let isEnabled = currentState.isPrivacyAgreement == true && !currentState.isServiceAgreement == true ? true : false
            return .concat(
                .just(.setupServiceAgreement(!currentState.isServiceAgreement)),
                .just(.setupConfirmButton(isEnabled))
            )
        case .didTappedMarketingAgreement:
            return .just(.setupMarketingAgreement(!currentState.isMarketingAgreement))
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setupAllAgreement(isAllAgreement):
            newState.isAllAgreement = isAllAgreement
        case let .setupServiceAgreement(isServiceAgreement):
            newState.isServiceAgreement = isServiceAgreement
        case let .setupPrivacyAgreement(isPrivacyAgreement):
            newState.isPrivacyAgreement = isPrivacyAgreement
        case let .setupConfirmButton(isEnabled):
            newState.isEnabled = isEnabled
        case let .setupMarketingAgreement(isMarketingAgreement):
            newState.isMarketingAgreement = isMarketingAgreement
        }
        return newState
    }
    
}
