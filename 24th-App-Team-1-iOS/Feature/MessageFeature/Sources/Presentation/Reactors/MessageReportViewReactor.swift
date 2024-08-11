//
//  MessageReportViewReactor.swift
//  MessageFeature
//
//  Created by eunseou on 7/24/24.
//

import Foundation

import ReactorKit

public final class MessageReportViewReactor: Reactor {
    
    public struct State {
        var sections: [ReportMessageSection]
    }
    
    public enum Action {
        case selectReason(Int)
        case fetchReasons
    }
    
    public enum Mutation {
        case toggleSelection(Int)
        case setReasons([ReportReason])
    }
    
    public var initialState: State
    
    public init() {
        let initialReasons = [
            ReportReason(id: 1, description: "유출/사칭/사기", isSelected: false),
            ReportReason(id: 2, description: "음란물/불건전한 만남 및 대화", isSelected: false),
            ReportReason(id: 3, description: "욕설/비하", isSelected: false),
            ReportReason(id: 4, description: "욕설/비하", isSelected: false),
            ReportReason(id: 5, description: "기타", isSelected: false)
        ]
        self.initialState = State(sections: [ReportMessageSection.main(initialReasons)])
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .selectReason(let index):
            return .just(.toggleSelection(index))
        case .fetchReasons:
            let reasons = [
                ReportReason(id: 1, description: "유출/사칭/사기", isSelected: false),
                ReportReason(id: 2, description: "음란물/불건전한 만남 및 대화", isSelected: false),
                ReportReason(id: 3, description: "욕설/비하", isSelected: false),
                ReportReason(id: 4, description: "욕설/비하", isSelected: false),
                ReportReason(id: 5, description: "기타", isSelected: false)
            ]
            return .just(.setReasons(reasons))
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .toggleSelection(let index):
            if case .main(var items) = newState.sections[0] {
                items[index].isSelected.toggle()
                newState.sections[0] = .main(items)
            }
        case .setReasons(let reasons):
            newState.sections = [ReportMessageSection.main(reasons)]
        }
        return newState
    }
}
