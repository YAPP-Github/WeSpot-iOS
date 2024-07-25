//
//  VoteProcessViewReactor.swift
//  VoteFeature
//
//  Created by Kim dohyun on 7/16/24.
//

import Foundation
import Util
import VoteDomain

import ReactorKit

public final class VoteProcessViewReactor: Reactor {
    
    
    private let fetchVoteOptionsUseCase: FetchVoteOptionsUseCaseProtocol
    
    public struct State {
        var isLoading: Bool
        @Pulse var questionSection: [VoteProcessSection]
        var processCount: Int
        var voteItemEntity: VoteItemEntity?
        @Pulse var voteResponseEntity: VoteResponseEntity?
        @Pulse var voteUserEntity: VoteUserEntity?
        @Pulse var voteOptionsStub: [VoteOptionsStub]
        @Pulse var isShowViewController: Bool
    }
    
    public enum Action {
        case fetchQuestionItems
        case didTappedQuestionItem(Int)
    }
    
    public enum Mutation {
        case setLoading(Bool)
        case setQuestionRowItems([VoteProcessItem])
        case setVoteOptionItems(VoteItemEntity)
        case addVoteOptionStub(VoteOptionsStub)
        case setVoteUserItems(VoteUserEntity)
        case setVoteResponseItems(VoteResponseEntity)
        case showNextProcessViewController(Bool)
    }
    
    public let initialState: State
    
    public init(fetchVoteOptionsUseCase: FetchVoteOptionsUseCaseProtocol, voteOptionStub: [VoteOptionsStub] = []) {
        self.initialState = State(
            isLoading: true,
            questionSection: [.votePrcessInfo([])],
            processCount: 1,
            voteUserEntity: nil,
            voteOptionsStub: voteOptionStub,
            isShowViewController: false
        )
        self.fetchVoteOptionsUseCase = fetchVoteOptionsUseCase
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        let index = currentState.processCount - 1
        switch action {
        case .fetchQuestionItems:
            return fetchVoteOptionsUseCase
                .execute()
                .asObservable()
                .withUnretained(self)
                .flatMap { owner, entity -> Observable<Mutation> in
                    guard let originEntity = entity else { return .empty() }
                    var voteSectionItems: [VoteProcessItem] = []
                    let response = originEntity.response[index]
                    response.voteInfo.forEach {
                        voteSectionItems.append(
                            .voteQuestionItem(
                                VoteProcessCellReactor(
                                    id: $0.id,
                                    content: $0.content
                                )
                            )
                        )
                    }
                    
                    return .concat(
                        .just(.setLoading(true)),
                        .just(.setVoteUserItems(response.userInfo)),
                        .just(.setQuestionRowItems(voteSectionItems)),
                        .just(.setVoteOptionItems(response)),
                        .just(.setVoteResponseItems(originEntity)),
                        .just(.setLoading(false))
                    )
                }
            
        case let .didTappedQuestionItem(row):
            guard let request = currentState.voteResponseEntity?.response[row] else { return .empty() }
            
            let voteOption = VoteOptionsStub(
                userId: request.userInfo.id,
                voteOptionId: request.voteInfo[row].id
            )
            
            return .concat(
                .just(.addVoteOptionStub(voteOption)),
                .just(.showNextProcessViewController(true))
            )
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setVoteResponseItems(voteResponseEntity):
            newState.voteResponseEntity = voteResponseEntity
            
        case let .setQuestionRowItems(items):
            newState.questionSection = [.votePrcessInfo(items)]
            
        case let .setVoteOptionItems(voteItemEntity):
            newState.voteItemEntity = voteItemEntity
            
        case let .addVoteOptionStub(voteOptionStub):
            newState.processCount += 1
            newState.voteOptionsStub.append(voteOptionStub)

        case let .setVoteUserItems(voteUserEntity):
            newState.voteUserEntity = voteUserEntity
            
        case let .setLoading(isLoading):
            newState.isLoading = isLoading
            
        case let .showNextProcessViewController(isShowViewController):
            newState.isShowViewController = isShowViewController
            
        }
        return newState
    }
}
