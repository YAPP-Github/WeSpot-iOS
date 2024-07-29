//
//  VoteResultViewReactor.swift
//  VoteFeature
//
//  Created by Kim dohyun on 7/13/24.
//

import Foundation

import VoteDomain
import Extensions

import ReactorKit

public final class VoteResultViewReactor: Reactor {
    
    private let fetchWinnerVoteOptionsUseCase: FetchWinnerVoteOptionsUseCaseProtocol
    public var initialState: State
    
    public struct State {
        @Pulse var resultSection: [VoteResultSection]
        @Pulse var winnerResponseEntity: VoteWinnerResponseEntity?
        var currentPage: Int = 0
        var isLoading: Bool = false
    }
    
    enum Action {
        case fetchWinnerResultItems
        case didShowVisibleCell(_ index: Int)
    }
    
    enum Mutation {
        case setLoading(Bool)
        case setResultSectionItems([VoteResultItem])
        case setWinnerItems(VoteWinnerResponseEntity)
        case setVisibleCellIndex(Int)
    }
    
    init(fetchWinnerVoteOptionsUseCase: FetchWinnerVoteOptionsUseCaseProtocol) {
        self.initialState = State(
            resultSection: [.voteResultInfo([])]
        )
        self.fetchWinnerVoteOptionsUseCase = fetchWinnerVoteOptionsUseCase
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .fetchWinnerResultItems:
            let query = VoteWinnerRequestQuery(date: Date().toFormatString(with: .dashYyyyMMdd))
            return fetchWinnerVoteOptionsUseCase
                .execute(query: query)
                .asObservable()
                .flatMap { entity -> Observable<Mutation> in
                    var winnerSectionItem: [VoteResultItem] = []
                    
                    guard let originalEntity = entity else { return .empty() }
                    originalEntity.response.forEach {
                        winnerSectionItem.append(
                            .voteResultsItem(
                                VoteResultCellReactor(
                                    content: $0.options.content,
                                    winnerUser: $0.results.first?.user ?? nil,
                                    voteCount: $0.results.first?.voteCount ?? 0
                                )
                            )
                        )
                    }
                    
                    return .concat(
                        .just(.setLoading(true)),
                        .just(.setResultSectionItems(winnerSectionItem)),
                        .just(.setWinnerItems(originalEntity)),
                        .just(.setLoading(false))
                    )
                    
                }
        case let .didShowVisibleCell(index):
            return .just(.setVisibleCellIndex(index))
            
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setLoading(isLoading):
            newState.isLoading = isLoading
            
        case let .setResultSectionItems(items):
            newState.resultSection = [.voteResultInfo(items)]
            
        case let .setWinnerItems(winnerResponseEntity):
            newState.winnerResponseEntity = winnerResponseEntity
            
        case let .setVisibleCellIndex(currentIndex):
            newState.currentPage = currentIndex
        }
        return newState
    }
}
