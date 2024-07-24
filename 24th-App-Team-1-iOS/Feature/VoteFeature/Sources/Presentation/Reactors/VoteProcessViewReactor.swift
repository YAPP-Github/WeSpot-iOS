//
//  VoteProcessViewReactor.swift
//  VoteFeature
//
//  Created by Kim dohyun on 7/16/24.
//

import Foundation
import Util

import ReactorKit

final class VoteProcessViewReactor: Reactor {
    
    
    struct State {
        @Pulse var questionSection: [VoteProcessSection]
        //TODO: 질문지 API 호출시 question Count Increment 하도록 로직 구현
        var processCount: Int
        var voteOptionStub: [VoteOptionsStub]
    }
    
    enum Action {
        case fetchQuestionItems
        case didTappedQuestionItem(Int)
    }
    
    enum Mutation {
        case setQuestionItems([VoteProcessItem])
        case setVoteOptionsItems([VoteOptionsStub])
    }
    
    let initialState: State
    
    init() {
        self.initialState = State(
            questionSection: [.votePrcessInfo([])],
            processCount: 1,
            voteOptionStub: []
        )
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .fetchQuestionItems:
            //TODO: 테스트 코드
            return .just(.setQuestionItems([
                .voteQuestionItem,
                .voteQuestionItem,
                .voteQuestionItem,
                .voteQuestionItem,
                .voteQuestionItem
            ]))
            //TODO: 서버 연동시 추가 작업
        case let .didTappedQuestionItem(row):
            return .just(.setVoteOptionsItems([]))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setQuestionItems(items):
            newState.questionSection = [.votePrcessInfo(items)]
            //TODO: VoteOptionsStub 갯수를 NavgationTitle로 지정
        case .setVoteOptionsItems(_):
            newState.processCount += 1
        }
        return newState
    }
}
