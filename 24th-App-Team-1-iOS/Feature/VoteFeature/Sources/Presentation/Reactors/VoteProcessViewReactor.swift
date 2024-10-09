//
//  VoteProcessViewReactor.swift
//  VoteFeature
//
//  Created by Kim dohyun on 7/16/24.
//

import Foundation
import Util
import VoteDomain
import CommonDomain
import Storage

import ReactorKit

public final class VoteProcessViewReactor: Reactor {
    
    private let createVoteUseCase: CreateVoteUseCaseProtocol
    private let createUserReportUseCase: CreateReportUserUseCaseProtocol
    private let fetchVoteOptionsUseCase: FetchVoteOptionsUseCaseProtocol
    
    public struct State {
        @Pulse var questionSection: [VoteProcessSection]
        @Pulse var voteResponseEntity: VoteResponseEntity?
        @Pulse var voteUserEntity: VoteUserEntity?
        @Pulse var processCount: Int
        @Pulse var reportEntity: CreateReportUserEntity?
        @Pulse var isLoading: Bool
        @Pulse var isInviteView: Bool
        var voteItemEntity: VoteItemEntity?
        var createVoteEntity: CreateVoteEntity?
    }
    
    public enum Action {
        case viewDidLoad
        case didTappedQuestionItem(Int)
        case didTappedResultButton
        case didTappedReportButton
        case didTappedLeftBarButtonItem
    }
    
    public enum Mutation {
        case setLoading(Bool)
        case setQuestionRowItems([VoteProcessItem])
        case setVoteOptionItems(VoteItemEntity)
        case setVoteInviteView(Bool)
        case setProcessCount(Int)
        case setVoteUserItems(VoteUserEntity)
        case setVoteResponseItems(VoteResponseEntity?)
        case setCreateVoteItems(CreateVoteEntity)
        case setReportItem(CreateReportUserEntity)
    }
    
    public let initialState: State
    
    public init(
        createVoteUseCase: CreateVoteUseCaseProtocol,
        createUserReportUseCase: CreateReportUserUseCaseProtocol,
        fetchVoteOptionsUseCase: FetchVoteOptionsUseCaseProtocol,
        voteResponseEntity: VoteResponseEntity? = nil
    ) {
        self.initialState = State(
            questionSection: [.votePrcessInfo([])],
            voteResponseEntity: voteResponseEntity,
            processCount: 1,
            isLoading: false,
            isInviteView: false
        )
        self.createVoteUseCase = createVoteUseCase
        self.createUserReportUseCase = createUserReportUseCase
        self.fetchVoteOptionsUseCase = fetchVoteOptionsUseCase
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        let index = UserDefaultsManager.shared.voteRequest.count
        switch action {
        case .viewDidLoad:
            var voteSectionItems: [VoteProcessItem] = []
            let processCount = UserDefaultsManager.shared.voteRequest.count + 1
            guard processCount == 1 else {
                guard let response = currentState.voteResponseEntity?.response[index] else {
                    return .concat(
                        .just(.setLoading(false)),
                        .just(.setVoteInviteView(false)),
                        .just(.setLoading(true))
                    )
                }
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
                    .just(.setLoading(false)),
                    .just(.setVoteInviteView(true)),
                    .just(.setQuestionRowItems(voteSectionItems)),
                    .just(.setProcessCount(processCount)),
                    .just(.setVoteUserItems(response.userInfo)),
                    .just(.setVoteResponseItems(currentState.voteResponseEntity)),
                    .just(.setLoading(true))
                )
            }
            
            return fetchVoteOptionsUseCase
                .execute()
                .asObservable()
                .flatMap { entity -> Observable<Mutation> in
                    
                    guard let entity,
                          !entity.response.isEmpty else {
                        return .concat(
                            .just(.setLoading(false)),
                            .just(.setVoteInviteView(false)),
                            .just(.setLoading(true))
                        )
                    }
                    
                    let response = entity.response[index]
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
                        .just(.setLoading(false)),
                        .just(.setVoteInviteView(true)),
                        .just(.setQuestionRowItems(voteSectionItems)),
                        .just(.setVoteUserItems(response.userInfo)),
                        .just(.setVoteResponseItems(entity)),
                        .just(.setLoading(true))
                    )
                }
            
        case let .didTappedQuestionItem(row):

            let index = UserDefaultsManager.shared.voteRequest.count
            guard let request = currentState.voteResponseEntity?.response[index] else { return .empty() }
            var currentOptions = UserDefaultsManager.shared.voteRequest
            
            let voteOption = CreateVoteItemReqeuest(
                userId: request.userInfo.id,
                voteOptionId: request.voteInfo[row].id
            )
            
            if index < currentOptions.count {
                UserDefaultsManager.shared.voteRequest[index] = voteOption
            } else {
                UserDefaultsManager.shared.voteRequest.append(voteOption)
            }
            return .empty()
            
        case .didTappedResultButton:
            
            let requestBody = UserDefaultsManager.shared.voteRequest
            return createVoteUseCase
                .execute(body: requestBody)
                .asObservable()
                .flatMap { entity -> Observable<Mutation> in
                    
                    guard let originalEntity = entity else { return .empty() }
                    return .just(.setCreateVoteItems(originalEntity))
                }
            
        case .didTappedReportButton:
            
            let userReportQuery = CreateUserReportRequest(type: CreateUserReportType.message.rawValue, targetId: currentState.voteUserEntity?.id ?? 0)
            return createUserReportUseCase
                .execute(body: userReportQuery)
                .asObservable()
                .compactMap { $0}
                .flatMap { entity -> Observable<Mutation> in
                    return .just(.setReportItem(entity))
                }
        case .didTappedLeftBarButtonItem:
            guard UserDefaultsManager.shared.voteRequest.isEmpty else {
                let index = UserDefaultsManager.shared.voteRequest.count - 1
                UserDefaultsManager.shared.voteRequest.remove(at: index)
                return .empty()
            }
            return .empty()
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
            
        case let .setVoteUserItems(voteUserEntity):
            newState.voteUserEntity = voteUserEntity
            
        case let .setLoading(isLoading):
            newState.isLoading = isLoading
            
        case let .setCreateVoteItems(createVoteEntity):
            newState.createVoteEntity = createVoteEntity
            
        case let .setReportItem(reportEntity):
            newState.reportEntity = reportEntity
            
        case let .setVoteInviteView(isInviteView):
            newState.isInviteView = isInviteView
            
        case let .setProcessCount(processCount):
            
            newState.processCount = processCount
        }
        return newState
    }
}
