//
//  FetchSchoolListUseCase.swift
//  LoginDomain
//
//  Created by eunseou on 7/30/24.
//

import Foundation

import RxSwift
import RxCocoa

public protocol FetchSchoolListUseCaseProtocol {
    func execute(query: SchoolListRequestQuery) -> Single<SchoolListResponseEntity?>
}

public final class FetchSchoolListUseCase: FetchSchoolListUseCaseProtocol {
    
    public let loginRepository: LoginRepositoryProtocol
    
    public init(loginRepository: LoginRepositoryProtocol) {
        self.loginRepository = loginRepository
    }

    public func execute(query: SchoolListRequestQuery) -> Single<SchoolListResponseEntity?> {
        return loginRepository.fetchSchoolList(query: query)
    }
}
