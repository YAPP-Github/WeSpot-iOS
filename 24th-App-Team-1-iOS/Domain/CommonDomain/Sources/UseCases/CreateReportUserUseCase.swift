//
//  CreateReportUserUseCase.swift
//  CommonDomain
//
//  Created by Kim dohyun on 8/10/24.
//

import Foundation

import RxSwift
import RxCocoa

public protocol CreateReportUserUseCaseProtocol {
    func execute(body: CreateUserReportRequest) -> Single<CreateReportUserEntity?>
}

public final class CreateReportUserUseCase: CreateReportUserUseCaseProtocol {
    
    public let commonRepositroy: CommonRepositoryProtocol
    
    public init(commonRepositroy: CommonRepositoryProtocol) {
        self.commonRepositroy = commonRepositroy
    }
    
    public func execute(body: CreateUserReportRequest) -> Single<CreateReportUserEntity?> {
        return commonRepositroy.createReportUserItem(body: body)
    }
    
}
