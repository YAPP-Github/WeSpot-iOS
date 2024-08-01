//
//  CreateExistingMemberUseCase.swift
//  LoginDomain
//
//  Created by eunseou on 8/1/24.
//

import Foundation

import RxSwift
import RxCocoa

public protocol CreateExistingMemberUseCaseProtocol {
    func execute(body: CreateSignUpTokenRequest) -> Single<CreateAccountResponseEntity?>
}

public final class createExistingMemberTokenUseCase: CreateExistingMemberUseCaseProtocol {

    public let loginRepository: LoginRepositoryProtocol
    
    public init(loginRepository: LoginRepositoryProtocol) {
        self.loginRepository = loginRepository
    }

    public func execute(body: CreateSignUpTokenRequest) -> Single<CreateAccountResponseEntity?> {
        return loginRepository.createExistingMember(body: body)
    }
    
}
