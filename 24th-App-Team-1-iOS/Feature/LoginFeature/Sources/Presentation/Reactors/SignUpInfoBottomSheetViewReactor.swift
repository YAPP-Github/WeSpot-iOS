//
//  SignUpInfoBottomSheetViewReactor.swift
//  LoginFeature
//
//  Created by Kim dohyun on 8/26/24.
//

import Foundation
import LoginDomain
import Util

import ReactorKit

public final class SignUpInfoBottomSheetViewReactor: Reactor {
    public typealias Mutation = NoMutation
    
    private let globalService: WSGlobalServiceProtocol = WSGlobalStateService.shared
    
    public let initialState: State
    
    public enum Action {
        case didTappedAccountEditButton
        case didTappedConfirmButton
    }
    
    public struct State {
        var accountRequest: CreateAccountRequest
        var schoolName: String
    }
    
    public init(accountRequest: CreateAccountRequest, schoolName: String) {
        self.initialState = State(
            accountRequest: accountRequest
            , schoolName: schoolName
        )
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        
        switch action {
        case .didTappedAccountEditButton:
            globalService.event.onNext(.didTappedAccountEditButton(true))
        case .didTappedConfirmButton:
            globalService.event.onNext(.didTappedAccountConfirmButton(true))
        }
        
        return .empty()
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        
        return state
    }
}
