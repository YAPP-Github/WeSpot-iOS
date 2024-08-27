//
//  SignUpResultViewReactor.swift
//  LoginFeature
//
//  Created by eunseou on 7/13/24.
//

import Foundation
import Util

import ReactorKit
import LoginDomain

public final class SignUpResultViewReactor: Reactor {
    
    private let createAccountUseCase: CreateAccountUseCaseProtocol
    private let globalService: WSGlobalServiceProtocol = WSGlobalStateService.shared
    public var initialState: State
    
    public struct State {
        var accountRequest: CreateAccountRequest
        var isAccountCreationCompleted: Bool = false
        var isMarketingAgreed: Bool = false
        var schoolName: String
        @Pulse var isShowBottomSheet: Bool = false
        @Pulse var isShowPolicyBottomSheet: Bool = false
    }
    
    public enum Action {
        case viewDidLoad
        case createAccount
        case setMarketingAgreement(Bool)
    }
    
    public enum Mutation {
        case isCompletedAccount(Bool)
        case setAccountGedner(String)
        case setAccountNickName(String)
        case setAccountClass(Int)
        case setAccountGrade(Int)
        case setAccountSchoolName(String)
        case setAccountEditBottomSheet(Bool)
        case setPolicyBottomSheet(Bool)
        case setMarketingAgreement(Bool)
    }
    
    public init(
        accountRequest: CreateAccountRequest,
        createAccountUseCase: CreateAccountUseCaseProtocol,
        schoolName: String
    ) {
        self.initialState = State(accountRequest: accountRequest, schoolName: schoolName)
        self.createAccountUseCase = createAccountUseCase
    }
    
    public func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
        let didShowBottomSheetMutation = globalService.event.flatMap { event -> Observable<Mutation> in
            
            switch event {
            case let .didTappedAccountEditButton(isSelected):
                return .just(.setAccountEditBottomSheet(isSelected))
            case let .didTappedAccountConfirmButton(isConfirm):
                return .just(.setPolicyBottomSheet(isConfirm))
            case let .didTappedAccountGenderButton(gender):
                return .just(.setAccountGedner(gender))
            case let .didTappedAccountNickNameButton(nickName):
                return .just(.setAccountNickName(nickName))
            case let .didChangedAccountGrade(grade):
                return .just(.setAccountGrade(grade))
            case let .didChangedAccountClass(classNumber):
                return .just(.setAccountClass(classNumber))
            case let .didChangedAccountSchoolName(schoolName):
                return .just(.setAccountSchoolName(schoolName))
            default:
                return .empty()
            }
        }
        return .merge(mutation, didShowBottomSheetMutation)
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .createAccount:
            return createAccountUseCase
                .execute(body: initialState.accountRequest)
                .asObservable()
                .flatMap { entity -> Observable<Mutation> in
                    return .just(.isCompletedAccount(true))
                }
                .catchAndReturn(.isCompletedAccount(false))
        case .setMarketingAgreement(let isAgreed):
            return .just(.setMarketingAgreement(isAgreed))
        case .viewDidLoad:
            return .just(.setAccountEditBottomSheet(true))
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .isCompletedAccount(let isCompleted):
            newState.isAccountCreationCompleted = isCompleted
        case .setMarketingAgreement(let isAgreed):
            newState.accountRequest.consents?.marketing = isAgreed
        case let .setPolicyBottomSheet(isShowPolicyBottomSheet):
            newState.isShowPolicyBottomSheet = isShowPolicyBottomSheet
        case let .setAccountEditBottomSheet(isShowBottomSheet):
            newState.isShowBottomSheet = isShowBottomSheet
        case let .setAccountGedner(gender):
            newState.accountRequest.gender = gender
        case let .setAccountNickName(name):
            newState.accountRequest.name = name
        case let .setAccountClass(classNumber):
            newState.accountRequest.classNumber = classNumber
        case let .setAccountGrade(grade):
            newState.accountRequest.grade = grade
        case let .setAccountSchoolName(schoolName):
            newState.schoolName = schoolName
        }
        return newState
    }
}
