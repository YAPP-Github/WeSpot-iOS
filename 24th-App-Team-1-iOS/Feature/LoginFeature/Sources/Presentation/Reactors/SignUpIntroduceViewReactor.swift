//
//  SignUpIntroduceViewReactor.swift
//  LoginFeature
//
//  Created by Kim dohyun on 8/28/24.
//

import Foundation
import CommonDomain

import ReactorKit

public final class SignUpIntroduceViewReactor: Reactor {
    
    private let updateUserProfileUseCase: UpdateUserProfileUseCaseProtocol
    
    public struct State {
        
    }
    
    public enum Action {
        
    }
    
    public enum Mutation {
        
    }
    
    public let initialState: State = State()
    
    public init(updateUserProfileUseCase: UpdateUserProfileUseCaseProtocol) {
        self.updateUserProfileUseCase = updateUserProfileUseCase
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        
        return .empty()
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        
        return state
    }
}
