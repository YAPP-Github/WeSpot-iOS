//
//  VoteBeginViewReactor.swift
//  VoteFeature
//
//  Created by Kim dohyun on 10/10/24.
//

import Foundation

import CommonDomain
import ReactorKit

public final class VoteBeginViewReactor: Reactor {
    public var initialState: State
    private let fetchUserProfileUseCase: FetchUserProfileUseCaseProtocol
    
    public struct State {
        @Pulse var profileEntity: UserProfileEntity?
        @Pulse var isLoading: Bool
    }
    
    public enum Action {
        case viewDidLoad
    }
    
    public enum Mutation {
        case setLoading(Bool)
        case setUserProfileItem(UserProfileEntity)
    }
    
    
    public init(fetchUserProfileUseCase: FetchUserProfileUseCaseProtocol) {
        self.fetchUserProfileUseCase = fetchUserProfileUseCase
        self.initialState = State(isLoading: false)
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewDidLoad:
            return fetchUserProfileUseCase
                .execute()
                .asObservable()
                .flatMap { response -> Observable<Mutation> in
                    guard let response else {
                        return .just(.setLoading(false))
                    }
                    return .concat(
                        .just(.setLoading(false)),
                        .just(.setUserProfileItem(response)),
                        .just(.setLoading(true))
                        
                    )
                    
                }
            
        }
    }
    
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setUserProfileItem(profileEntity):
            newState.profileEntity = profileEntity
        case let .setLoading(isLoading):
            newState.isLoading = isLoading
        }
        
        return newState
    }
    
}
