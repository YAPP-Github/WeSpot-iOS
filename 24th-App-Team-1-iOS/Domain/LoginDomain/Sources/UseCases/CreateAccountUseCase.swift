//
//  CreateAccountUseCase.swift
//  LoginDomain
//
//  Created by eunseou on 7/30/24.
//

import Foundation

import RxSwift
import RxCocoa

public protocol CreateAccountUseCaseProtocol {
    func execute(body: CreateAccountRequest) -> Single<CreateAccountResponseEntity?>
}

public final class CreateAccountUseCase: CreateAccountUseCaseProtocol {

    public let loginRepository: LoginRepositoryProtocol
    
    public init(loginRepository: LoginRepositoryProtocol) {
        self.loginRepository = loginRepository
    }

    public func execute(body: CreateAccountRequest) -> Single<CreateAccountResponseEntity?> {
        return loginRepository.createAccount(body: body)
    }
}
