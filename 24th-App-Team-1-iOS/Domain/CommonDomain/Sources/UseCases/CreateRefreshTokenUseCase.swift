//
//  CreateRefreshTokenUseCase.swift
//  LoginDomain
//
//  Created by eunseou on 7/30/24.
//

import Foundation

import RxSwift
import RxCocoa

public protocol CreateRefreshTokenUseCaseProtocol {
    func execute(body: CreateRefreshTokenRequest) -> Single<CreateCommonAccountResponseEntity?>
}

public final class CreateRefreshTokenUseCase: CreateRefreshTokenUseCaseProtocol {

    public let commonRepository: CommonRepositoryProtocol
    
    public init(commonRepository: CommonRepositoryProtocol) {
        self.commonRepository = commonRepository
    }

    public func execute(body: CreateRefreshTokenRequest) -> Single<CreateCommonAccountResponseEntity?> {
        return commonRepository.createRefreshToken(body: body)
    }
}
