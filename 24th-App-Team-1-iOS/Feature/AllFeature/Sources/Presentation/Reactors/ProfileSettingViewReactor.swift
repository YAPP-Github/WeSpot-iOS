//
//  ProfileSettingViewReactor.swift
//  AllFeature
//
//  Created by Kim dohyun on 8/12/24.
//

import Foundation
import CommonDomain
import AllDomain

import ReactorKit

public final class ProfileSettingViewReactor: Reactor {
    private let createCheckProfanityUseCase: CreateCheckProfanityUseCaseProtocol
    private let updateUserProfileUseCase: UpdateUserProfileUseCaseProtocol
    private let fetchUserProfileUseCase: FetchUserProfileUseCaseProtocol
    
    
    public struct State {
        @Pulse var isProfanity: Bool
        @Pulse var userProfileEntity: UserProfileEntity?
        @Pulse var isUpdate: Bool
        @Pulse var isLoading: Bool
        var errorMessage: String
        @Pulse var isEnabled: Bool
        var introudce: String
    }
    
    public enum Action {
        case didUpdateIntroduceProfile(String)
        case didTapUpdateUserButton
        case viewWillAppear
    }
    
    public enum Mutation {
        case setCheckProfanityValidation(Bool)
        case setButtonEnabled(Bool)
        case setErrorDescriptionMessage(String)
        case setUpdateUserProfileItem(UserProfileEntity)
        case setUpdateIntroduce(String)
        case setUpdateUserProfile(Bool)
        case setLoading(Bool)
    }
    
    public let initialState: State
    
    public init(
        createCheckProfanityUseCase: CreateCheckProfanityUseCaseProtocol,
        updateUserProfileUseCase: UpdateUserProfileUseCaseProtocol,
        fetchUserProfileUseCase: FetchUserProfileUseCaseProtocol
    ) {
        self.createCheckProfanityUseCase = createCheckProfanityUseCase
        self.updateUserProfileUseCase = updateUserProfileUseCase
        self.fetchUserProfileUseCase = fetchUserProfileUseCase
        self.initialState = State(
            isProfanity: false,
            isUpdate: false,
            isLoading: false,
            errorMessage: "",
            isEnabled: false,
            introudce: ""
        )
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewWillAppear:
            return fetchUserProfileUseCase
                .execute()
                .asObservable()
                .compactMap { $0 }
                .flatMap { entity -> Observable<Mutation> in
                    return .concat(
                        .just(.setLoading(false)),
                        .just(.setUpdateUserProfileItem(entity)),
                        .just(.setLoading(true))
                    )
                }
        case let .didUpdateIntroduceProfile(introduce):
            let checkProfanityBody = CreateCheckProfanityRequest(message: introduce)
            return createCheckProfanityUseCase
                .execute(body: checkProfanityBody)
                .asObservable()
                .withUnretained(self)
                .flatMap { owner, isProfanity -> Observable<Mutation> in
                    if isProfanity {
                        return .concat(
                            .just(.setButtonEnabled(false)),
                            .just(.setErrorDescriptionMessage("비속어가 포함되어 있어요")),
                            .just(.setCheckProfanityValidation(isProfanity))
                        )
                    } else {
                        
                        let isChanged = introduce != self.currentState.userProfileEntity?.introduction
                        let isValid = introduce.count <= 20
                        
                        let isDisabled = !isChanged || !isValid
                        let errorMessage = isValid ? "" : "20자 이내로 입력 가능해요"
                                
                        return .concat(
                            .just(.setCheckProfanityValidation(!isValid)),
                            .just(.setErrorDescriptionMessage(errorMessage)),
                            .just(.setButtonEnabled(!isDisabled)),
                            .just(.setUpdateIntroduce(introduce))
                        )
                    }
                }
        case .didTapUpdateUserButton:
            
            //TODO: UserDefaults 로 데이터를 저장해야함
            guard let iconURL = currentState.userProfileEntity?.profile.iconUrl.absoluteString,
                  let backgroundColor = currentState.userProfileEntity?.profile.backgroundColor else { return .empty() }
            
            let updateUserProfileBody = UpdateUserProfileRequest(introduction: currentState.introudce, backgroundColor: backgroundColor, iconUrl: iconURL)
            return updateUserProfileUseCase.execute(body: updateUserProfileBody)
                .asObservable()
                .flatMap { isUpdate -> Observable<Mutation> in
                    return .concat(
                        .just(.setLoading(false)),
                        .just(.setUpdateUserProfile(isUpdate)),
                        .just(.setLoading(true))
                    )
                }
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setCheckProfanityValidation(isProfanity):
            newState.isProfanity = isProfanity
        case let .setErrorDescriptionMessage(errorMessage):
            newState.errorMessage = errorMessage
        case let .setUpdateIntroduce(introduce):
            newState.introudce = introduce
        case let .setUpdateUserProfile(isUpdate):
            newState.isUpdate = isUpdate
        case let .setUpdateUserProfileItem(userProfileEntity):
            newState.userProfileEntity = userProfileEntity
        case let .setButtonEnabled(isEnabled):
            newState.isEnabled = isEnabled
        case let .setLoading(isLoading):
            newState.isLoading = isLoading
        }
        
        return newState
    }
}

extension ProfileSettingViewReactor {
    
    private func validationIntroduce(_ introduce: String) -> Bool {
        let regex = "^[가-힣!_@$%^&+=A-Za-z0-9]{1,20}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: introduce)
    }
    
}
