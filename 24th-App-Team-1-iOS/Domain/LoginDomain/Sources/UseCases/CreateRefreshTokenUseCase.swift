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
    func execute(body: CreateRefreshTokenRequest) -> Single<CreateAccountResponseEntity?>
}

public final class createRefreshTokenUseCase: CreateRefreshTokenUseCaseProtocol {

    public let loginRepository: LoginRepositoryProtocol
    
    public init(loginRepository: LoginRepositoryProtocol) {
        self.loginRepository = loginRepository
    }

    public func execute(body: CreateRefreshTokenRequest) -> Single<CreateAccountResponseEntity?> {
        return loginRepository.createRefreshToken(body: body)
    }
}
