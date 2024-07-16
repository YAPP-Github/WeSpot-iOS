//
//  SignUpSchoolViewReactor.swift
//  LoginFeature
//
//  Created by eunseou on 7/12/24.
//

import Foundation

import ReactorKit

public final class SignUpSchoolViewReactor: Reactor {
    
    public struct State {
        var schoolName: String = ""
        var schoolList: [String] = []
        var selectedSchool: String?
    }
    
    public enum Action {
        case searchSchool(String)
        case selectSchool(String)
    }
    
    public enum Mutation {
        case setSchoolList(String, [String])
        case setSelectedSchool(String?)
    }
    
    public var initialState: State = State()
    
    public init() {
        self.initialState = State()
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .searchSchool(let schoolName):
            if schoolName.isEmpty {
                return .just(.setSchoolList(schoolName, []))
            }
            let randomCount = Int.random(in: 0...3)
            let schoolList = Array(repeating: "test", count: randomCount)
            return .just(.setSchoolList(schoolName, schoolList))
        case .selectSchool(let schoolName):
            return .just(.setSelectedSchool(schoolName))
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setSchoolList(let schoolName, let results):
            newState.schoolName = schoolName
            newState.schoolList = results
        case .setSelectedSchool(let schoolName):
            newState.selectedSchool = schoolName
        }
        return newState
    }
}
