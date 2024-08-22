//
//  ProfileResignViewReactor.swift
//  AllFeature
//
//  Created by Kim dohyun on 8/17/24.
//

import Foundation
import AllDomain
import Util

import ReactorKit

public final class ProfileResignViewReactor: Reactor {
    
    private let globalState: WSGlobalServiceProtocol = WSGlobalStateService.shared
    private let createUserResignUseCase: CreateUserResignUseCaseProtocol
    
    
    public struct State {
        @Pulse var reasonSection: [ProfileResignReasonSection]
        @Pulse var isEnabled: Bool
        @Pulse var isStatus: Bool
        @Pulse var isLoading: Bool
        @Pulse var isSuccess: Bool
        var selectedItem: [Int]
    }
    
    public enum Action {
        case didTappedReasonItems(Int)
        case didTappedResignButton
        case didTappedDeselectedItems(Int)
    }
    
    public enum Mutation {
        case setReasonButtonEnabled(Bool)
        case setResignStatus(Bool)
        case setLoading(Bool)
        case setResignSelectedIndexPath([Int])
        case setUserResignStatus(Bool)
    }
    
    public let initialState: State
    
    public init(createUserResignUseCase: CreateUserResignUseCaseProtocol) {
        self.initialState = State(
            reasonSection: [
                .accountResignReasonInfo([
                    .resignReasonItem(
                        ProfileResignCellReactor(
                            contentTitle: "기능이 다양하지 않아요")
                    ),
                    .resignReasonItem(
                        ProfileResignCellReactor(
                            contentTitle: "함께할 친구가 부족해요")
                    ),
                    .resignReasonItem(
                        ProfileResignCellReactor(
                            contentTitle: "선택지가 다양하지 않아요")
                    ),
                    .resignReasonItem(
                        ProfileResignCellReactor(
                            contentTitle: "사양하는 방법이 어려워요")
                    ),
                    .resignReasonItem(
                        ProfileResignCellReactor(
                            contentTitle: "기타")
                    )
                ])
            ],
            isEnabled: false,
            isStatus: false,
            isLoading: true,
            isSuccess: false,
            selectedItem: []
        )
        
        self.createUserResignUseCase = createUserResignUseCase
        
    }
    
    public func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
        let didTappedResignButton = globalState.event
            .flatMap { event -> Observable<Mutation> in
                switch event {
                case let .didTappedResignButton(isStatus):
                    
                    return .concat(
                        .just(.setLoading(false)),
                        .just(.setResignStatus(isStatus)),
                        .just(.setLoading(true))
                    )
                default:
                    return .empty()
                }
            }
        return .merge(mutation, didTappedResignButton)
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .didTappedReasonItems(item):
            var selectedItem = currentState.selectedItem
            selectedItem.append(item)
            
            return .concat(
                .just(.setResignSelectedIndexPath(selectedItem)),
                .just(.setReasonButtonEnabled(true))
            )
        case let .didTappedDeselectedItems(item):
            var selectedItem = currentState.selectedItem
            let index = selectedItem.firstIndex(of: item)
            
            guard let index = selectedItem.firstIndex(of: item ) else { return .empty() }

            selectedItem.remove(at: index)
            if selectedItem.isEmpty {
                return .concat(
                    .just(.setResignSelectedIndexPath([])),
                    .just(.setReasonButtonEnabled(false))
                )
            } else {
                return .concat(
                    .just(.setResignSelectedIndexPath(selectedItem)),
                    .just(.setReasonButtonEnabled(true))
                )
            }
        case .didTappedResignButton:
            return createUserResignUseCase
                .execute()
                .asObservable()
                .withUnretained(self)
                .flatMap { owner, isSuccess -> Observable<Mutation> in
                    guard isSuccess else { return .just(.setUserResignStatus(false))}
                    
                    owner.globalState.event.onNext(.didShowSignInViewController(isSuccess))
                    return .concat(
                        .just(.setLoading(false)),
                        .just(.setUserResignStatus(isSuccess)),
                        .just(.setLoading(true))
                    )
                }
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setReasonButtonEnabled(isEnabled):
            newState.isEnabled = isEnabled
        case let .setResignStatus(isStatus):
            newState.isStatus = isStatus
        case let .setLoading(isLoading):
            newState.isLoading = isLoading
        case let .setUserResignStatus(isSuccess):
            newState.isSuccess = isSuccess
        case let .setResignSelectedIndexPath(selectedItem):
            newState.selectedItem = selectedItem
        }
        
        return newState
    }
}
