//
//  SignUpIntroduceViewReactor.swift
//  LoginFeature
//
//  Created by Kim dohyun on 8/28/24.
//

import Foundation
import Util
import CommonDomain

import ReactorKit

public final class SignUpIntroduceViewReactor: Reactor {
    
    private let updateUserProfileUseCase: UpdateUserProfileUseCaseProtocol
    let globalService: WSGlobalServiceProtocol = WSGlobalStateService.shared
    private let createCheckProfanityUseCase: CreateCheckProfanityUseCaseProtocol
    
    public struct State {
        @Pulse var imageURL: String
        @Pulse var backgroundColor: String
        var introduce: String
        @Pulse var isEnabled: Bool
        @Pulse var errorMessage: String
        @Pulse var isLoading: Bool
        @Pulse var isValidation: Bool
        @Pulse var isUpdate: Bool
    }
    
    public enum Action {
        case didUpdateIntroduce(String)
        case didTappedConfirmButton
    }
    
    public enum Mutation {
        case setIntroduce(String)
        case setErrorMessage(String)
        case setIntroduceValidation(Bool)
        case setConfirmButtonEanbled(Bool)
        case setLoading(Bool)
        case setUpdateProfile(Bool)
    }
    
    public let initialState: State
    
    
    public init(updateUserProfileUseCase: UpdateUserProfileUseCaseProtocol,
                createCheckProfanityUseCase: CreateCheckProfanityUseCaseProtocol,
                imageURL: String,
                backgroundColor: String
    ) {
        let backgroundColor = backgroundColor.isEmpty ? "2E2F33" : backgroundColor
        self.updateUserProfileUseCase = updateUserProfileUseCase
        self.createCheckProfanityUseCase = createCheckProfanityUseCase
        self.initialState = State(
            imageURL: imageURL,
            backgroundColor: backgroundColor,
            introduce: "",
            isEnabled: false,
            errorMessage: "",
            isLoading: true,
            isValidation: false,
            isUpdate: false
        )
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        
        switch action {
        case let .didUpdateIntroduce(introduce):
            let checkIntroduceProfanityBody = CreateCheckProfanityRequest(message: introduce)
            return createCheckProfanityUseCase
                .execute(body: checkIntroduceProfanityBody)
                .asObservable()
                .flatMap { isProfanity -> Observable<Mutation> in
                    if isProfanity {
                        return .concat(
                            .just(.setConfirmButtonEanbled(false)),
                            .just(.setErrorMessage("비속어가 포함되어 있어요")),
                            .just(.setIntroduceValidation(false))
                        )
                    }
                   
                    let isValidation = !introduce.isEmpty && introduce.count <= 20
                    let errorMessage = introduce.count > 20 ? "20자 이내로 입력 가능해요" : ""
                    let isEnabled = !introduce.isEmpty && introduce.count <= 20
                    
                    return .concat(
                        .just(.setIntroduceValidation(isValidation)),
                        .just(.setErrorMessage(errorMessage)),
                        .just(.setConfirmButtonEanbled(isEnabled)),
                        .just(.setIntroduce(introduce))
                    )
                }
        case .didTappedConfirmButton:
            let initalUserProfileBody = UpdateUserProfileRequest(
                introduction: currentState.introduce,
                backgroundColor: currentState.backgroundColor,
                iconUrl: currentState.imageURL
            )
            
            return updateUserProfileUseCase
                .execute(body: initalUserProfileBody)
                .asObservable()
                .flatMap { isUpdate -> Observable<Mutation> in
                    return .concat(
                        .just(.setLoading(false)),
                        .just(.setUpdateProfile(isUpdate)),
                        .just(.setLoading(true))
                    )
                }
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case let .setIntroduce(introduce):
            newState.introduce = introduce
        case let .setErrorMessage(errorMessage):
            newState.errorMessage = errorMessage
        case let .setIntroduceValidation(isValidation):
            newState.isValidation = isValidation
        case let .setConfirmButtonEanbled(isEnabled):
            newState.isEnabled = isEnabled
        case let .setLoading(isLoading):
            newState.isLoading = isLoading
        case let .setUpdateProfile(isUpdate):
            newState.isUpdate = isUpdate
        }
        
        return newState
    }
}
