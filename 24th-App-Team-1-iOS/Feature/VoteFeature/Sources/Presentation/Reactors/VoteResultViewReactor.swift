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

final class VoteResultViewReactor: Reactor {
    
    
    var initialState: State
    private let fetchWinnerVoteOptionsUseCase: FetchWinnerVoteOptionsUseCaseProtocol
    
    struct State {
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
            resultSection: [
                .voteResultInfo([.voteResultsItem, .voteResultsItem, .voteResultsItem])
            ]
        )
        self.fetchWinnerVoteOptionsUseCase = fetchWinnerVoteOptionsUseCase
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .fetchWinnerResultItems:
            let query = VoteWinnerRequestQuery(date: Date().toFormatString(with: .dashYyyyMMdd))
            return fetchWinnerVoteOptionsUseCase
                .execute(query: query)
                .asObservable()
                .flatMap { entity -> Observable<Mutation> in
                    let winnerSectionItem: [VoteResultItem] = []
                    
                    guard let response = entity else { return .empty() }
                    
                    return .concat(
                        .just(.setLoading(true)),
                        .just(.setWinnerItems(response)),
                        .just(.setLoading(false))
                    )
                    
                }
        case let .didShowVisibleCell(index):
            return .just(.setVisibleCellIndex(index))
            
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setLoading(isLoading):
            newState.isLoading = isLoading
            
        case let .setResultSectionItems(items):
            newState.resultSection = [.voteResultInfo(items)]
            
        case let .setWinnerItems(winnerResponseEntity):
            newState.winnerResponseEntity = winnerResponseEntity
            print("fetch winner response: \(winnerResponseEntity)")
            
        case let .setVisibleCellIndex(currentIndex):
            newState.currentPage = currentIndex
        }
        return newState
    }
}
