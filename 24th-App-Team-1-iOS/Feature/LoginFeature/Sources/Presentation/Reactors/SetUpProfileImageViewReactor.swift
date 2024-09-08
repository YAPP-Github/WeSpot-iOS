//
//  SetUpProfileImageViewReactor.swift
//  LoginFeature
//
//  Created by eunseou on 8/3/24.
//

import Foundation
import Util
import CommonDomain
import CommonService

import ReactorKit

public final class SetUpProfileImageViewReactor: Reactor {
    
    private let fetchProfileImagesUseCase: FetchProfileImagesUseCaseProtocol
    private let fetchProfileBackgroundsUseCase: FetchProfileBackgroundsUseCaseProtocol
    private let globalService: WSGlobalServiceProtocol = WSGlobalStateService.shared
    public let initialState: State
    
    public struct State {
        @Pulse var profileImages: FetchProfileImageResponseEntity?
        @Pulse var profileBackgrounds: FetchProfileBackgroundsResponseEntity?
        @Pulse var backgroundSection: [SignUpBackgroundSection]
        @Pulse var characterSection: [SignUpCharacterSection]
        @Pulse var isLoading: Bool
        var backgroundColor: String
        var iconURL: URL?
    }
    
    public enum Action {
        case fetchProfileImages
        case fetchProfileBackgrounds
        case didTappedBackgroundItem(Int)
        case didTappedCharacterItem(Int)
    }
    
    public enum Mutation {
        case setProfileImages(FetchProfileImageResponseEntity)
        case setProfileBackgrounds(FetchProfileBackgroundsResponseEntity)
        case setSignUpCharacterSectionItem([SignUpCharacterItem])
        case setSignUpBackgroundSectionItem([SignUpBackgroundItem])
        case setLoding(Bool)
        case setSelctedBackgroundColor(String)
        case setSelectedIconURL(URL)
    }
    
    
    public init(
        fetchProfileImagesUseCase: FetchProfileImagesUseCaseProtocol,
        fetchProfileBackgroundsUseCase: FetchProfileBackgroundsUseCaseProtocol
    ) {
        self.initialState = State(
            backgroundSection: [],
            characterSection: [],
            isLoading: false,
            backgroundColor: ""
        )
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
                    var characterSectionItem: [SignUpCharacterItem] = []
                    guard let entity else {
                        return .empty()
                    }
                    
                    entity.characters.enumerated().forEach {
                        characterSectionItem.append(
                            .characterItem(
                                SignUpProfileCharacterCellReactor(
                                    iconURL: $0.element.iconUrl,
                                    item: $0.offset
                                )
                            )
                        )
                    }
                    return .concat(
                        .just(.setLoding(false)),
                        .just(.setSignUpCharacterSectionItem(characterSectionItem)),
                        .just(.setProfileImages(entity)),
                        .just(.setLoding(true))
                    )
                }
            
        case .fetchProfileBackgrounds:
            return fetchProfileBackgroundsUseCase
                .execute()
                .asObservable()
                .flatMap { entity -> Observable<Mutation> in
                    var backgroundSectionItem: [SignUpBackgroundItem] = []
                    guard let entity else {
                        return .empty()
                    }
                    entity.backgrounds.enumerated().forEach {
                        backgroundSectionItem.append(
                            .backgroundItem(
                                SignUpProfileBackgroundCellReactor(
                                    backgroundColor: $0.element.color,
                                    item: $0.offset
                                )
                            )
                        )
                    }
                    
                    return .concat(
                        .just(.setLoding(false)),
                        .just(.setSignUpBackgroundSectionItem(backgroundSectionItem)),
                        .just(.setProfileBackgrounds(entity)),
                        .just(.setLoding(true))
                    )
                }
        case let .didTappedBackgroundItem(item):
            globalService.event.onNext(.didTappedBackgroundItem(item))
            guard let backgroundColor = currentState.profileBackgrounds?.backgrounds[item].color else { return .empty() }
            return .just(.setSelctedBackgroundColor(backgroundColor))
            

        case let .didTappedCharacterItem(item):
            globalService.event.onNext(.didTappedCharacterItem(item))
            guard let iconURL = currentState.profileImages?.characters[item].iconUrl else { return .empty() }
            return .just(.setSelectedIconURL(iconURL))
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setProfileImages(images):
            newState.profileImages = images
        case let .setProfileBackgrounds(backgrounds):
            newState.profileBackgrounds = backgrounds
        case let .setSignUpCharacterSectionItem(items):
            newState.characterSection = [.setupCharacterSection(items)]
        case let .setSignUpBackgroundSectionItem(items):
            newState.backgroundSection = [.setupBackgroundSection(items)]
        case let .setLoding(isLoading):
            newState.isLoading = isLoading
        case let .setSelctedBackgroundColor(backgroundColor):
            newState.backgroundColor = backgroundColor
        case let .setSelectedIconURL(iconURL):
            newState.iconURL = iconURL
        }
        return newState
    }
}
