//
//  AllMainViewReactor.swift
//  AllFeature
//
//  Created by Kim dohyun on 8/11/24.
//

import Foundation

import AllDomain
import ReactorKit

public final class AllMainViewReactor: Reactor {
    
    private let fetchUserProfileUseCase: FetchUserProfileUseCaseProtocol
    
    public struct State {
        @Pulse var mainAllSection: [AllMainSection]
        @Pulse var userProfileEntity: UserProfileEntity?
    }
    
    public enum Action {
        case viewDidLoad
    }
    
    public enum Mutation {
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
        ])
        self.fetchUserProfileUseCase = fetchUserProfileUseCase
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewDidLoad:
            return fetchUserProfileUseCase.execute()
                .asObservable()
                .compactMap { $0 }
                .flatMap { entity -> Observable<Mutation> in
                    return .just(.setUserProfileItem(entity))
                }
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case let .setUserProfileItem(userProfileEntity):
            newState.userProfileEntity = userProfileEntity
        }
        
        return newState
    }
}
