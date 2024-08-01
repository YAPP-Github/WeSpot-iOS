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
        var isLoading: Bool
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
    }
    
    public init(fetchAllVoteOptionsUseCase: FetchAllVoteOptionsUseCaseProtocol) {
        self.initialState = State(
            completeSection: [.voteAllRankerInfo([])],
            isLoading: false,
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
                        .just(.setLoading(true)),
                        .just(.setOnboadingView(true)),
                        .just(.setCompleteSection(completeSectionitem)),
                        .just(.setLoading(false))
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
        case let .setOnboadingView(isLoading):
            newState.isLoading = isLoading
        case let .setCurrentPageControl(currentPage):
            newState.currentPage = currentPage
        case let .setCompleteSection(items):
            newState.completeSection = [.voteAllRankerInfo(items)]
            
        }
        return newState
    }
}
