//
//  SignUpSchoolViewReactor.swift
//  LoginFeature
//
//  Created by eunseou on 7/12/24.
//

import Foundation
import LoginDomain

import ReactorKit

public final class SignUpSchoolViewReactor: Reactor {
    
    private let fetchSchoolListUseCase: FetchSchoolListUseCaseProtocol
    public var initialState: State
    
    public struct State {
        var schoolName: String = ""
        var schoolList: SchoolListResponseEntity = SchoolListResponseEntity(schools: [])
        var selectedSchool: String?
    }
    
    public enum Action {
        case searchSchool(String)
        case selectSchool(String)
    }
    
    public enum Mutation {
        case setSchoolList(SchoolListResponseEntity)
        case setSelectedSchool(String?)
    }
    
    public init(fetchSchoolListUseCase: FetchSchoolListUseCaseProtocol) {
        self.fetchSchoolListUseCase = fetchSchoolListUseCase
        self.initialState = State()
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .searchSchool(let schoolName):
            if schoolName.isEmpty {
                return .just(.setSchoolList(SchoolListResponseEntity(schools: [])))
            }
            
            let query = SchoolListRequestQuery(name: schoolName)
            
            return fetchSchoolListUseCase
                .execute(query: query)
                .asObservable()
                .map { entity in
                    return .setSchoolList(entity ?? SchoolListResponseEntity(schools: []))
                }
        case .selectSchool(let schoolName):
            return .just(.setSelectedSchool(schoolName))
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setSchoolList(let results):
            newState.schoolList = results
        case .setSelectedSchool(let schoolName):
            newState.selectedSchool = schoolName
        }
        return newState
    }
}
