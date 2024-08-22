//
//  VoteCompleteViewReactor.swift
//  VoteFeature
//
//  Created by Kim dohyun on 7/24/24.
//

import Foundation
import VoteDomain

import ReactorKit

public final class VoteCompleteViewReactor: Reactor {
    
    private let fetchAllVoteOptionsUseCase: FetchAllVoteOptionsUseCaseProtocol
    public let initialState: State
    
    public struct State {
        @Pulse var completeSection: [VoteCompleteSection]
        @Pulse var voteAllEntity: [VoteAllEntity]
        @Pulse var isLoading: Bool
        @Pulse var isOnboarding: Bool
        var currentPage: Int
    }
    
    public enum Action {
        case viewDidLoad
        case didShowVisibleCell(_ index: Int)
    }
    
    public enum Mutation {
        case setLoading(Bool)
        case setOnboadingView(Bool)
        case setCurrentPageControl(Int)
        case setCompleteSection([VoteCompleteItem])
        case setVoteAllEntity([VoteAllEntity])
    }
    
    public init(fetchAllVoteOptionsUseCase: FetchAllVoteOptionsUseCaseProtocol) {
        self.initialState = State(
            completeSection: [.voteAllRankerInfo([])],
            voteAllEntity: [],
            isLoading: false,
            isOnboarding: false,
            currentPage: 0
        )
        self.fetchAllVoteOptionsUseCase = fetchAllVoteOptionsUseCase
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        
        switch action {
        case .viewDidLoad:
            
            let query = VoteWinnerRequestQuery(date: Date().toFormatString(with: .dashYyyyMMdd))
            
            return fetchAllVoteOptionsUseCase
                .execute(query: query)
                .asObservable()
                .flatMap { entity -> Observable<Mutation> in
                    var completeSectionitem: [VoteCompleteItem] = []
                    
                    guard let originalEntity = entity else { return .empty() }
                    
                    
                    originalEntity.response
                        .enumerated()
                        .forEach {
                            if $1.results.count < 5 {
                                completeSectionitem.append(
                                    .voteAllEmptyItem(
                                        VoteEmptyCellReactor(
                                            content: $1.options.content
                                        )
                                    )
                                )
                            } else {
                                completeSectionitem.append(
                                    .voteAllRankerItem(
                                        VoteAllCellReactor(
                                            voteAllResultsEntity: $1.results,
                                            content: $1.options.content
                                        )
                                    )
                                )
                            }
                    }
                    return .concat(
                        .just(.setLoading(false)),
                        .just(.setOnboadingView(true)),
                        .just(.setVoteAllEntity(originalEntity.response)),
                        .just(.setCompleteSection(completeSectionitem)),
                        .just(.setLoading(true))
                    )
                }
        case let .didShowVisibleCell(index):
            return .just(.setCurrentPageControl(index))
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setLoading(isLoading):
            newState.isLoading = isLoading
        case let .setOnboadingView(isOnboarding):
            newState.isOnboarding = isOnboarding
        case let .setCurrentPageControl(currentPage):
            newState.currentPage = currentPage
        case let .setCompleteSection(items):
            newState.completeSection = [.voteAllRankerInfo(items)]
        case let .setVoteAllEntity(voteAllEntity):
            newState.voteAllEntity = voteAllEntity
        }
        return newState
    }
}
