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
    
    private let createVoteUseCase: CreateVoteUseCaseProtocol
    
    public struct State {
        @Pulse var questionSection: [VoteProcessSection]
        @Pulse var voteResponseEntity: VoteResponseEntity?
        @Pulse var voteUserEntity: VoteUserEntity?
        @Pulse var voteOptionsStub: [CreateVoteItemReqeuest]
        @Pulse var processCount: Int
        var isLoading: Bool
        var voteItemEntity: VoteItemEntity?
        var createVoteEntity: CreateVoteEntity?
    }
    
    public enum Action {
        case viewDidLoad
        case didTappedQuestionItem(Int)
        case didTappedResultButton
    }
    
    public enum Mutation {
        case setLoading(Bool)
        case setQuestionRowItems([VoteProcessItem])
        case setVoteOptionItems(VoteItemEntity)
        case addVoteOptionStub(CreateVoteItemReqeuest)
        case updateVoteOptionStub(Int, CreateVoteItemReqeuest)
        case setVoteUserItems(VoteUserEntity)
        case setVoteResponseItems(VoteResponseEntity)
        case setCreateVoteItems(CreateVoteEntity)
    }
    
    public let initialState: State
    
    public init(
        createVoteUseCase: CreateVoteUseCaseProtocol,
        voteResponseEntity: VoteResponseEntity,
        voteOptionStub: [CreateVoteItemReqeuest] = [],
        processCount: Int = 1
    ) {
            self.initialState = State(
                questionSection: [.votePrcessInfo([])],
                voteResponseEntity: voteResponseEntity,
                voteOptionsStub: voteOptionStub,
                processCount: processCount,
                isLoading: true
            )
            self.createVoteUseCase = createVoteUseCase
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        let index = currentState.processCount - 1
        switch action {
        case .viewDidLoad:
            var voteSectionItems: [VoteProcessItem] = []
            guard let entity = currentState.voteResponseEntity?.response[index] else { return .empty() }
            
            entity.voteInfo.forEach {
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
                .just(.setQuestionRowItems(voteSectionItems)),
                .just(.setVoteUserItems(entity.userInfo)),
                .just(.setLoading(false))
            )
            
        case let .didTappedQuestionItem(row):
            guard let request = currentState.voteResponseEntity?.response[row] else { return .empty() }
                        
            let voteOption = CreateVoteItemReqeuest(
                userId: request.userInfo.id,
                voteOptionId: request.voteInfo[row].id
            )
            
            if index < currentState.voteOptionsStub.count {
                return .just(.updateVoteOptionStub(index, voteOption))
            } else {
                return .just(.addVoteOptionStub(voteOption))
            }
            
        case .didTappedResultButton:
            
            let requestBody = currentState.voteOptionsStub
            
            return createVoteUseCase
                .execute(body: requestBody)
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
            newState.voteOptionsStub.append(voteOptionStub)
            
        case let .updateVoteOptionStub(index, voteOptionStub):
            newState.voteOptionsStub[index] = voteOptionStub
            
        case let .setVoteUserItems(voteUserEntity):
            newState.voteUserEntity = voteUserEntity
            
        case let .setLoading(isLoading):
            newState.isLoading = isLoading
            
        case let .setCreateVoteItems(createVoteEntity):
            newState.createVoteEntity = createVoteEntity
        }
        return newState
    }
}
