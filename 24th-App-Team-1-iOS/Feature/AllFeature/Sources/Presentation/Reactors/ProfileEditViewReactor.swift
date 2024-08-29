//
//  ProfileEditViewReactor.swift
//  AllFeature
//
//  Created by Kim dohyun on 8/12/24.
//

import Foundation
import AllDomain
import Storage
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
        var backgroundSection: [BackgroundEditSection]
        var characterSection: [CharacterEditSection]
        @Pulse var isUpdate: Bool
        @Pulse var isLoading: Bool
        @Pulse var backgroundColor: String
        @Pulse var iconURL: URL?
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
        case setLoading(Bool)
        case setSelctedBackgroundColor(String)
        case setSelectedIconURL(URL)
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
            isLoading: false,
            backgroundColor: "",
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
                        let selectedItem = UserDefaultsManager.shared.userProfileImage == $0.element.iconUrl.absoluteString ? $0.offset : 9
                        characterSectionItem.append(
                            .profileCharacterItem(
                                ProfileCharacterCellReactor(
                                    iconURL: $0.element.iconUrl,
                                    item: $0.offset,
                                    selectedItem: selectedItem
                                )
                            )
                        )
                    }
                    
                    return .concat(
                        .just(.setLoading(false)),
                        .just(.setProfileImageSectionItem(characterSectionItem)),
                        .just(.setBackgroundImageResponseItems(entity)),
                        .just(.setLoading(true))
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
                        let selectedItem = UserDefaultsManager.shared.userBackgroundColor == $0.element.color ? $0.offset : 9
                        backgroundSectionItem.append(
                            .profileBackgroundItem(
                                ProfileBackgroundCellReactor(
                                    backgroundColor: $0.element.color,
                                    item: $0.offset,
                                    selectedItem: selectedItem
                                )
                            )
                        )
                    }
                    return .concat(
                        .just(.setLoading(false)),
                        .just(.setProfileBackgroundSectionItem(backgroundSectionItem)),
                        .just(.setBackgroundResponseItems(entity)),
                        .just(.setLoading(true))
                    )
                }
        case let .didTappedCharacterItem(item):
            globalService.event.onNext(.didTappedCharacterItem(item))
            guard let iconURL = currentState.fetchProfileImageResponseEntity?.characters[item].iconUrl else { return .empty() }
            return .just(.setSelectedIconURL(iconURL))
            
        case let .didTappedBackgroundItem(item):
            globalService.event.onNext(.didTappedBackgroundItem(item))
            guard let backgroundColor = currentState.fetchProfileBackgroundsResponseEntity?.backgrounds[item].color else { return .empty() }
            return .just(.setSelctedBackgroundColor(backgroundColor))
        case .didTappedUpdateButton:
            
            guard let originalURL = currentState.iconURL else { return .empty() }
            let updateUserBody = UpdateUserProfileRequest(introduction: currentState.userProfileEntity.introduction, backgroundColor: currentState.backgroundColor, iconUrl: originalURL.absoluteString)
            return updateUserProfileUseCase
                .execute(body: updateUserBody)
                .asObservable()
                .withUnretained(self)
                .flatMap { owner, isUpdate -> Observable<Mutation> in
                    if isUpdate {
                        return .concat(
                            .just(.setLoading(false)),
                            .just(.setError(false)),
                            .just(.setUserUpdate(isUpdate)),
                            .just(.setSelctedBackgroundColor(owner.currentState.backgroundColor)),
                            .just(.setSelectedIconURL(originalURL)),
                            .just(.setLoading(true))
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
        case let .setLoading(isLoading):
            newState.isLoading = isLoading
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
            UserDefaultsManager.shared.userProfileImage = iconURL.absoluteString
        case let .setSelctedBackgroundColor(backgroundColor):
            newState.backgroundColor = backgroundColor
            UserDefaultsManager.shared.userBackgroundColor = backgroundColor
        case let .setError(isErorr):
            newState.isError = isErorr
        }
        
        return newState
    }
}
