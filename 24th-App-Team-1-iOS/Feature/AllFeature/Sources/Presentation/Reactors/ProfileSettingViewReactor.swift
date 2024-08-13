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
    
    
    public struct State {
        @Pulse var isProfanity: Bool
        @Pulse var userProfileEntity: UserProfileEntity
        var errorMessage: String
    }
    
    public enum Action {
        case didUpdateIntroduceProfile(String)
    }
    
    public enum Mutation {
        case setCheckProfanityValidation(Bool)
        case setErrorDescriptionMessage(String)
    }
    
    public let initialState: State
    
    public init(createCheckProfanityUseCase: CreateCheckProfanityUseCaseProtocol, userProfileEntity: UserProfileEntity) {
        self.createCheckProfanityUseCase = createCheckProfanityUseCase
        self.initialState = State(
            isProfanity: false,
            userProfileEntity: userProfileEntity,
            errorMessage: ""
        )
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .didUpdateIntroduceProfile(introduce):
            let checkProfanityBody = CreateCheckProfanityRequest(message: introduce)
            return createCheckProfanityUseCase
                .execute(body: checkProfanityBody)
                .asObservable()
                .flatMap { isProfanity -> Observable<Mutation> in
                    if isProfanity {
                        return .concat(
                            .just(.setCheckProfanityValidation(isProfanity)),
                            .just(.setErrorDescriptionMessage("비속어가 포함되어 있어요"))
                        )
                    } else {
                        
                        let isValid = self.validationIntroduce(introduce)
                        let errorMessage = isValid ? "" : "20자 이내로 입력 가능해요"
                        return .concat(
                            .just(.setCheckProfanityValidation(isProfanity)),
                            .just(.setErrorDescriptionMessage(errorMessage))
                        )
                    }
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
