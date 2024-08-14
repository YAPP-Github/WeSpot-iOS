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
        @Pulse var backgroundSection: [BackgroundEditSection]
        @Pulse var characterSection: [CharacterEditSection]
        @Pulse var isUpdate: Bool
        var backgroundColor: String
        var iconURL: String
        var isError: Bool
    }
    
    public enum Action {
        case fetchProfileImageItem
        case fetchProfileBackgrounItem
        case didTappedCharacterItem(Int)
        case didTappedBackgroundItem(Int)
        case didTappedUpdateButton
    }
    
    public enum Mutation {
        case setBackgroundResponseItems(FetchProfileBackgroundsResponseEntity)
        case setBackgroundImageResponseItems(FetchProfileImageResponseEntity)
        case setProfileImageSectionItem([CharacterEditItem])
        case setProfileBackgroundSectionItem([BackgroundEditItem])
        case setUserUpdate(Bool)
        case setSelctedBackgroundColor(String)
        case setSelectedIconURL(String)
        case setError(Bool)
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
            backgroundSection: [
                .profileBackgroundInfo([])
            ],
            characterSection: [],
            isUpdate: false,
            backgroundColor: "",
            iconURL: "",
            isError: false
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
                    var characterSectionItem: [CharacterEditItem] = []
                    
                    entity.characters.enumerated().forEach {
                        characterSectionItem.append(
                            .profileCharacterItem(
                                ProfileCharacterCellReactor(
                                    iconURL: $0.element.iconUrl,
                                    item: $0.offset
                                )
                            )
                        )
                    }
                    
                    return .concat(
                        .just(.setProfileImageSectionItem(characterSectionItem)),
                        .just(.setBackgroundImageResponseItems(entity))
                    )
                }
            
        case .fetchProfileBackgrounItem:
            return fetchProfileBackgroundUseCase.execute()
                .asObservable()
                .compactMap { $0 }
                .withUnretained(self)
                .flatMap { owner, entity -> Observable<Mutation> in
                    var backgroundSectionItem: [BackgroundEditItem] = []
                    
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
                        .just(.setBackgroundResponseItems(entity))
                    )
                }
        case let .didTappedCharacterItem(item):
            globalService.event.onNext(.didTappedCharacterItem(item))
            let iconURL = currentState.fetchProfileImageResponseEntity?.characters[item].iconUrl.absoluteString
            return .just(.setSelectedIconURL(iconURL ?? ""))
            
        case let .didTappedBackgroundItem(item):
            globalService.event.onNext(.didTappedBackgroundItem(item))
            let backgroundColor = currentState.fetchProfileBackgroundsResponseEntity?.backgrounds[item].color
            return .just(.setSelctedBackgroundColor(backgroundColor ?? ""))
        case .didTappedUpdateButton:
            
            let updateUserProfileBody = UpdateUserProfileItemRequest(backgroundColor: currentState.backgroundColor, iconUrl: currentState.iconURL)
            let updateUserBody = UpdateUserProfileRequest(introduction: currentState.userProfileEntity.introduction, profile: updateUserProfileBody)
            return updateUserProfileUseCase
                .execute(body: updateUserBody)
                .asObservable()
                .flatMap { isUpdate -> Observable<Mutation> in
                    if isUpdate {
                        return .concat(
                            //TODO: Error 예외 처리 추가
                            .just(.setError(false)),
                            .just(.setUserUpdate(isUpdate))
                        )
                    } else {
                        return .just(.setError(true))
                    }
                    
                }
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
            newState.characterSection = [.profileCharacterInfo(items)]
        case let .setProfileBackgroundSectionItem(items):
            newState.backgroundSection = [.profileBackgroundInfo(items)]
        case let .setUserUpdate(isUpdate):
            newState.isUpdate = isUpdate
        case let .setSelectedIconURL(iconURL):
            newState.iconURL = iconURL
        case let .setSelctedBackgroundColor(backgroundColor):
            newState.backgroundColor = backgroundColor
        case let .setError(isErorr):
            newState.isError = isErorr
        }
        
        return newState
    }
}
