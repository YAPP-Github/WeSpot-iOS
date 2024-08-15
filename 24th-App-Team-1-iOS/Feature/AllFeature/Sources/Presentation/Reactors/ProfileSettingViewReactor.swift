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
        var isUpdate: Bool
        var errorMessage: String
        var isEnabled: Bool
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
                    return .just(.setUpdateUserProfileItem(entity))
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
                            .just(.setCheckProfanityValidation(isProfanity)),
                            .just(.setButtonEnabled(true)),
                            .just(.setErrorDescriptionMessage("비속어가 포함되어 있어요"))
                        )
                    } else {
                        let isDisabled = introduce == owner.currentState.userProfileEntity?.introduction ? false : true
                        
                        let isValid = self.validationIntroduce(introduce)
                        let errorMessage = isValid ? "" : "20자 이내로 입력 가능해요"
                        return .concat(
                            .just(.setCheckProfanityValidation(isProfanity)),
                            .just(.setUpdateIntroduce(introduce)),
                            .just(.setButtonEnabled(isDisabled)),
                            .just(.setErrorDescriptionMessage(errorMessage))
                        )
                    }
                }
        case .didTapUpdateUserButton:
            
            //TODO: UserDefaults 로 데이터를 저장해야함
//            let iconURL = currentState.userProfileEntity.profile.iconUrl
//            let updateUserProfileItemBody = UpdateUserProfileItemRequest(backgroundColor: <#T##String#>, iconUrl: <#T##String#>)
//            let updateUserProfileBody = UpdateUserProfileRequest(introduction: currentState.introudce, profile: <#T##UpdateUserProfileItemRequest#>)
//            return updateUserProfileUseCase.execute(body: <#T##UpdateUserProfileRequest#>)
            return .empty()
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
