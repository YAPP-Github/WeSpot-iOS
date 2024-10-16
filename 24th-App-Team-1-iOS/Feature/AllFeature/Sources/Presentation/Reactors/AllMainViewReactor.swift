//
//  AllMainViewReactor.swift
//  AllFeature
//
//  Created by Kim dohyun on 8/11/24.
//

import Foundation

import CommonDomain
import ReactorKit

public final class AllMainViewReactor: Reactor {
    private let fetchUserProfileUseCase: FetchUserProfileUseCaseProtocol
    
    public struct State {
        @Pulse var mainAllSection: [AllMainSection]
        @Pulse var accountProfileEntity: UserProfileEntity?
        @Pulse var isLoading: Bool
    }
    
    public enum Action {
        case viewWillAppear
    }
    
    public enum Mutation {
        case setLoading(Bool)
        case setUserProfileItem(UserProfileEntity)
    }
    
    public let initialState: State
    
    public init(fetchUserProfileUseCase: FetchUserProfileUseCaseProtocol) {
        self.initialState = State(mainAllSection: [
            .movementInfo([
                .movementItem("문의 채널 바로가기"),
                .movementItem("공식 SNS 바로가기")
            ]),
            .appInfo([
                .appInfoItem("스토어 리뷰 남기기"),
                .appInfoItem("의견 보내기"),
                .appInfoItem("리서치 참여하기")
            ]),
            .makerInfo([
                .makerInfoItem("WeSpot Makers")
            ])
        ], isLoading: false)
        self.fetchUserProfileUseCase = fetchUserProfileUseCase
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewWillAppear:
            return fetchUserProfileUseCase
                .execute()
                .asObservable()
                .compactMap { $0 }
                .flatMap { response -> Observable<Mutation> in
                    return .concat(
                        .just(.setLoading(false)),
                        .just(.setUserProfileItem(response)),
                        .just(.setLoading(true))
                    )
                }
        }
        
        return .empty()
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setLoading(isLoading):
            newState.isLoading = isLoading
        case let .setUserProfileItem(accountProfileEntity):
            newState.accountProfileEntity = accountProfileEntity
        }
        return newState
    }
}
