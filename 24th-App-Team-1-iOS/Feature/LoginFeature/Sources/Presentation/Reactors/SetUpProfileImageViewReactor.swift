//
//  SetUpProfileImageViewReactor.swift
//  LoginFeature
//
//  Created by eunseou on 8/3/24.
//

import Foundation
import CommonDomain
import CommonService

import ReactorKit

public final class SetUpProfileImageViewReactor: Reactor {
    
    private let fetchProfileImagesUseCase: FetchProfileImagesUseCaseProtocol
    private let fetchProfileBackgroundsUseCase: FetchProfileBackgroundsUseCaseProtocol
    public let initialState: State
    
    public struct State {
        @Pulse var profileImages: FetchProfileImageResponseEntity?
        @Pulse var profileBackgrounds: FetchProfileBackgroundsResponseEntity?
    }
    
    public enum Action {
        case fetchProfileImages
        case fetchProfileBackgrounds
    }
    
    public enum Mutation {
        case setProfileImages(FetchProfileImageResponseEntity)
        case setProfileBackgrounds(FetchProfileBackgroundsResponseEntity)
    }
    
    
    public init(
        fetchProfileImagesUseCase: FetchProfileImagesUseCaseProtocol,
        fetchProfileBackgroundsUseCase: FetchProfileBackgroundsUseCaseProtocol
    ) {
        self.initialState = State()
        self.fetchProfileImagesUseCase = fetchProfileImagesUseCase
        self.fetchProfileBackgroundsUseCase = fetchProfileBackgroundsUseCase
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .fetchProfileImages:
            
            return fetchProfileImagesUseCase
                .execute()
                .asObservable()
                .flatMap { entity -> Observable<Mutation> in
                    guard let entity else {
                        return .empty()
                    }
                    return .just(.setProfileImages(entity))
                }
            
        case .fetchProfileBackgrounds:
            return fetchProfileBackgroundsUseCase
                .execute()
                .asObservable()
                .flatMap { entity -> Observable<Mutation> in
                    guard let entity else {
                        return .empty()
                    }
                    return .just(.setProfileBackgrounds(entity))
                }
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setProfileImages(let images):
            newState.profileImages = images
        case .setProfileBackgrounds(let backgrounds):
            newState.profileBackgrounds = backgrounds
        }
        return newState
    }
}
