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
        var schoolName: String
        @Pulse var schoolList: SchoolListResponseEntity
        var selectedSchool: SchoolListEntity?
        var cursorId: Int
        var isLoading: Bool
        var accountRequest: CreateAccountRequest
    }
    
    public enum Action {
        case searchSchool(String)
        case loadMoreSchools
        case selectSchool(SchoolListEntity?)
    }
    
    public enum Mutation {
        case setSchoolList(SchoolListResponseEntity)
        case appendSchoolList(SchoolListResponseEntity)
        case setSelectedSchool(SchoolListEntity?)
        case setCursorId(Int)
        case setLoading(Bool)
    }
    
    public init(
        fetchSchoolListUseCase: FetchSchoolListUseCaseProtocol,
        accountRequest: CreateAccountRequest
    ) {
        self.initialState = State(
            schoolName: "",
            schoolList: SchoolListResponseEntity(schools: []),
            cursorId: 0,
            isLoading: false,
            accountRequest: accountRequest
        )
        self.fetchSchoolListUseCase = fetchSchoolListUseCase
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .searchSchool(let schoolName):
            guard !schoolName.isEmpty else {
                return .just(.setSchoolList(SchoolListResponseEntity(schools: [])))
            }
            
            let query = SchoolListRequestQuery(name: schoolName, cursorId: 0)
            
            return fetchSchoolListUseCase
                .execute(query: query)
                .asObservable()
                .flatMap { entity -> Observable<Mutation> in
                    guard let entity else {
                        return .just(.setSchoolList(SchoolListResponseEntity(schools: [])))
                    }
                    return .just(.setSchoolList(entity))
                }
            
        case .loadMoreSchools:
            let query = SchoolListRequestQuery(name: currentState.schoolName, cursorId: currentState.cursorId)
            
            return fetchSchoolListUseCase
                .execute(query: query)
                .asObservable()
                .flatMap { entity -> Observable<Mutation> in
                    guard let entity else {
                        return .empty()
                    }
                    return .concat([
                        .just(.appendSchoolList(entity)),
                        .just(.setCursorId(entity.schools.last?.id ?? self.currentState.cursorId))
                    ])
                }
            
        case .selectSchool(let school):
            return .just(.setSelectedSchool(school))
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setSchoolList(let results):
            newState.schoolList = results
            newState.cursorId = results.schools.last?.id ?? 0
            
        case .appendSchoolList(let results):
            var currentSchools = newState.schoolList.schools
            currentSchools.append(contentsOf: results.schools)
            newState.schoolList = SchoolListResponseEntity(schools: currentSchools)
            newState.cursorId = results.schools.last?.id ?? newState.cursorId
            
        case .setSelectedSchool(let school):
            newState.accountRequest.schoolId = school?.id
            newState.selectedSchool = school
            
        case .setCursorId(let cursorId):
            newState.cursorId = cursorId
            
        case .setLoading(let isLoading):
            newState.isLoading = isLoading
        }
        return newState
    }
}
