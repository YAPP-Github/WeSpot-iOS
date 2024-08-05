//
//  VoteEffectViewReactor.swift
//  VoteFeature
//
//  Created by Kim dohyun on 8/3/24.
//

import Foundation
import VoteDomain

import ReactorKit

public enum VoteEffectType {
    case latest
    case previous
}

public final class VoteEffectViewReactor: Reactor {
    
    private let fetchVoteEffectOptionsUseCase: FetchAllVoteOptionsUseCaseProtocol
    public let initialState: State
    public struct State {
        @Pulse var effectSection: [VoteCompleteSection]
        @Pulse var voteAllEntity: [VoteAllEntity]
        var isLoading: Bool
        var currentPage: Int
        var toggleType: VoteEffectType
    }
    
    public enum Action {
        case fetchlatestAllVoteOption
        case fetchPreviousAllVoteOptions
        case didShowVisibleCell(_ index: Int)
    }
    
    public enum Mutation {
        case setLoading(Bool)
        case setToggleType(VoteEffectType)
        case setCurrentPageControl(Int)
        case setCompleteSection([VoteCompleteItem])
        case setVoteAllEntity([VoteAllEntity])
    }
    

    public init(fetchVoteEffectOptionsUseCase: FetchAllVoteOptionsUseCaseProtocol) {
        self.fetchVoteEffectOptionsUseCase = fetchVoteEffectOptionsUseCase
        self.initialState = State(
            effectSection: [.voteAllRankerInfo([])],
            voteAllEntity: [],
            isLoading: false,
            currentPage: 0,
            toggleType: .latest
        )
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        
        switch action {
        case .fetchlatestAllVoteOption:
            let latestQuery = VoteWinnerRequestQuery(date: Date().toFormatString(with: .dashYyyyMMdd))
            return fetchVoteEffectOptionsUseCase
                .execute(query: latestQuery)
                .asObservable()
                .withUnretained(self)
                .flatMap { owner, entity -> Observable<Mutation> in
                    guard let originalEntity = entity else { return .empty() }
                    var completeSectionitem: [VoteCompleteItem] = []
                    completeSectionitem = owner.createCompleteSectionItem(entity: originalEntity)
                    
                    return .concat(
                        .just(.setLoading(true)),
                        .just(.setToggleType(.latest)),
                        .just(.setVoteAllEntity(originalEntity.response)),
                        .just(.setCompleteSection(completeSectionitem)),
                        .just(.setLoading(false))
                    )
                }
        case let .didShowVisibleCell(index):
            return .just(.setCurrentPageControl(index))
        case .fetchPreviousAllVoteOptions:
            let previousDate = Calendar.current.date(byAdding: .day, value: -1, to: .now) ?? Date()
            let previousQuery = VoteWinnerRequestQuery(date: previousDate.toFormatString(with: .dashYyyyMMdd))
            
            return fetchVoteEffectOptionsUseCase
                .execute(query: previousQuery)
                .asObservable()
                .withUnretained(self)
                .flatMap { owner, entity -> Observable<Mutation> in
                    guard let originalEntity = entity else { return .empty() }
                    var completeSectionitem: [VoteCompleteItem] = []
                    completeSectionitem = owner.createCompleteSectionItem(entity: originalEntity)
                    
                    return .concat(
                        .just(.setLoading(true)),
                        .just(.setToggleType(.previous)),
                        .just(.setVoteAllEntity(originalEntity.response)),
                        .just(.setCompleteSection(completeSectionitem)),
                        .just(.setLoading(false))
                    )
                }
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case let .setLoading(isLoading):
            newState.isLoading = isLoading
        case let .setToggleType(toggleType):
            newState.toggleType = toggleType
        case let .setCurrentPageControl(currentPage):
            newState.currentPage = currentPage
        case let .setCompleteSection(items):
            newState.effectSection = [.voteAllRankerInfo(items)]
        case let .setVoteAllEntity(voteAllEntity):
            newState.voteAllEntity = voteAllEntity
        }
        
        return newState
    }
}


extension VoteEffectViewReactor {
    private func createCompleteSectionItem(entity: VoteAllReponseEntity) -> [VoteCompleteItem] {
        var completeSectionitem: [VoteCompleteItem] = []
        
        entity.response
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
        return completeSectionitem
    }
}
