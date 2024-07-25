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
    private let createVoteUseCase: CreateVoteUseCaseProtocol
    
    public struct State {
        var isLoading: Bool
        @Pulse var questionSection: [VoteProcessSection]
        var processCount: Int
        var voteItemEntity: VoteItemEntity?
        @Pulse var voteResponseEntity: VoteResponseEntity?
        @Pulse var voteUserEntity: VoteUserEntity?
        @Pulse var voteOptionsStub: [CreateVoteItemReqeuest]
        @Pulse var isShowViewController: Bool
        var createVoteEntity: CreateVoteEntity?
    }
    
    public enum Action {
        case fetchQuestionItems
        case didTappedQuestionItem(Int)
        case didTappedResultButton
    }
    
    public enum Mutation {
        case setLoading(Bool)
        case setQuestionRowItems([VoteProcessItem])
        case setVoteOptionItems(VoteItemEntity)
        case addVoteOptionStub(CreateVoteItemReqeuest)
        case setVoteUserItems(VoteUserEntity)
        case setVoteResponseItems(VoteResponseEntity)
        case showNextProcessViewController(Bool)
        case setCreateVoteItems(CreateVoteEntity)
    }
    
    public let initialState: State
    
    public init(
        fetchVoteOptionsUseCase: FetchVoteOptionsUseCaseProtocol,
        createVoteUseCase: CreateVoteUseCaseProtocol,
        voteOptionStub: [CreateVoteItemReqeuest] = []
    ) {
            self.initialState = State(
                isLoading: true,
                questionSection: [.votePrcessInfo([])],
                processCount: 1,
                voteOptionsStub: voteOptionStub,
                isShowViewController: false
            )
            self.fetchVoteOptionsUseCase = fetchVoteOptionsUseCase
            self.createVoteUseCase = createVoteUseCase
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
            
            let voteOption = CreateVoteItemReqeuest(
                userId: request.userInfo.id,
                voteOptionId: request.voteInfo[row].id
            )
            
            return .concat(
                .just(.addVoteOptionStub(voteOption)),
                .just(.showNextProcessViewController(true))
            )
            
        case .didTappedResultButton:
            
            //TODO: 더미 데이터임 -> Swinject로 화면 전환 코드 변경시 삭제
            let createItem: [CreateVoteItemReqeuest] = [
                .init(userId: 1, voteOptionId: 1),
                .init(userId: 2, voteOptionId: 2),
                .init(userId: 3, voteOptionId: 3),
                .init(userId: 4, voteOptionId: 4),
                .init(userId: 5, voteOptionId: 5)
            ]
            
            return createVoteUseCase
                .execute(body: createItem)
                .asObservable()
                .flatMap { entity -> Observable<Mutation> in
                    guard let originalEntity = entity else { return .empty() }
                    return .just(.setCreateVoteItems(originalEntity))
                }
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
            
        case let .setCreateVoteItems(createVoteEntity):
            newState.createVoteEntity = createVoteEntity
        }
        return newState
    }
}
