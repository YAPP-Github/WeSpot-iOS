//
//  VoteProcessViewReactor.swift
//  VoteFeature
//
//  Created by Kim dohyun on 7/16/24.
//

import Foundation

import ReactorKit

final class VoteProcessViewReactor: Reactor {
    
    
    struct State {
        @Pulse var questionSection: [VoteProcessSection]
        //TODO: 질문지 API 호출시 question Count Increment 하도록 로직 구현
        var processCount: String
    }
    
    enum Action {
        case fetchQuestionItems
    }
    
    enum Mutation {
        case setQuestionItems([VoteProcessItem])
    }
    
    let initialState: State
    
    init() {
        self.initialState = State(
            questionSection: [.votePrcessInfo([])],
            processCount: "1/5"
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
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setQuestionItems(items):
            newState.questionSection = [.votePrcessInfo(items)]
        }
        return newState
    }
}
