//
//  ProfileEditViewReactor.swift
//  AllFeature
//
//  Created by Kim dohyun on 8/12/24.
//

import Foundation
import AllDomain
import Util
import CommonDomain

import ReactorKit

public final class ProfileEditViewReactor: Reactor {
    
    private let updateUserProfileUseCase: UpdateUserProfileUseCaseProtocol
    private let fetchProfileBackgroundUseCase: FetchProfileBackgroundsUseCaseProtocol
    private let fetchProfileImageUseCase: FetchProfileImagesUseCaseProtocol
    private let globalService: WSGlobalServiceProtocol = WSGlobalStateService.shared
    
    public struct State {
        @Pulse var userProfileEntity: UserProfileEntity
        @Pulse var fetchProfileBackgroundsResponseEntity: FetchProfileBackgroundsResponseEntity?
        @Pulse var fetchProfileImageResponseEntity: FetchProfileImageResponseEntity?
        @Pulse var profileEditSection: [ProfileEditSection]
        var isToggle: Bool
    }
    
    public enum Action {
        case fetchProfileImageItem
        case fetchProfileBackgrounItem
        case didTappedEditItem(Int)
    }
    
    public enum Mutation {
        case setBackgroundResponseItems(FetchProfileBackgroundsResponseEntity)
        case setBackgroundImageResponseItems(FetchProfileImageResponseEntity)
        case setProfileImageSectionItem([ProfileEditItem])
        case setToggleButton(Bool)
        case setProfileBackgroundSectionItem([ProfileEditItem])
    }
    
    public let initialState: State
    
    public init(
        updateUserProfileUseCase: UpdateUserProfileUseCaseProtocol,
        fetchProfileBackgroundUseCase: FetchProfileBackgroundsUseCaseProtocol,
        fetchProfileImageUseCase: FetchProfileImagesUseCaseProtocol,
        userProfileEntity: UserProfileEntity
    ) {
        self.initialState = State(
            userProfileEntity: userProfileEntity,
            profileEditSection: [],
            isToggle: false
        )
        self.updateUserProfileUseCase = updateUserProfileUseCase
        self.fetchProfileBackgroundUseCase = fetchProfileBackgroundUseCase
        self.fetchProfileImageUseCase = fetchProfileImageUseCase
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .fetchProfileImageItem:
            return fetchProfileImageUseCase.execute()
                .asObservable()
                .compactMap { $0 }
                .withUnretained(self)
                .flatMap { owner, entity -> Observable<Mutation> in
                    var imageSectionItem: [ProfileEditItem] = []
                    
                    entity.characters.enumerated().forEach {
                        imageSectionItem.append(
                            .profileCharacterItem(
                                ProfileCharacterCellReactor(
                                    iconURL: $0.element.iconUrl,
                                    item: $0.offset
                                )
                            )
                        )
                    }
                    
                    return .concat(
                        .just(.setProfileImageSectionItem(imageSectionItem)),
                        .just(.setToggleButton(!owner.currentState.isToggle)),
                        .just(.setBackgroundImageResponseItems(entity))
                    )
                }
            
        case .fetchProfileBackgrounItem:
            return fetchProfileBackgroundUseCase.execute()
                .asObservable()
                .compactMap { $0 }
                .withUnretained(self)
                .flatMap { owner, entity -> Observable<Mutation> in
                    var backgroundSectionItem: [ProfileEditItem] = []
                    
                    entity.backgrounds.enumerated().forEach {
                        backgroundSectionItem.append(
                            .profileBackgroundItem(
                                ProfileBackgroundCellReactor(
                                    backgroundColor: $0.element.color,
                                    item: $0.offset
                                )
                            )
                        )
                    }
                    
                    return .concat(
                        .just(.setProfileBackgroundSectionItem(backgroundSectionItem)),
                        .just(.setToggleButton(!owner.currentState.isToggle)),
                        .just(.setBackgroundResponseItems(entity))
                    )
                }
        case let .didTappedEditItem(item):
            globalService.event.onNext(.didTappedEditItem(item))
            return .empty()
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setBackgroundResponseItems(fetchProfileBackgroundsResponseEntity):
            newState.fetchProfileBackgroundsResponseEntity = fetchProfileBackgroundsResponseEntity
        case let .setBackgroundImageResponseItems(fetchProfileImageResponseEntity):
            newState.fetchProfileImageResponseEntity = fetchProfileImageResponseEntity
        case let .setProfileImageSectionItem(items):
            newState.profileEditSection = [.profileCharacterInfo(items)]
        case let .setProfileBackgroundSectionItem(items):
            newState.profileEditSection = [.profileBackgroundInfo(items)]
        case let .setToggleButton(isToggle):
            newState.isToggle = isToggle
        }
        
        return newState
    }
}
