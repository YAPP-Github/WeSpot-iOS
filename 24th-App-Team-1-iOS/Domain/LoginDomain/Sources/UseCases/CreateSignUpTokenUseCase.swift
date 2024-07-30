//
//  CreateSignUpTokenUseCase.swift
//  LoginDomain
//
//  Created by eunseou on 7/30/24.
//

import Foundation

import RxSwift
import RxCocoa

public protocol CreateSignUpTokenUseCaseProtocol {
    func execute(body: CreateSignUpTokenRequest) -> Single<CreateSignUpTokenResponseEntity?>
}

public final class createSignUpTokenUseCase: CreateSignUpTokenUseCaseProtocol {

    
    public let loginRepository: LoginRepositoryProtocol
    
    public init(loginRepository: LoginRepositoryProtocol) {
        self.loginRepository = loginRepository
    }

    public func execute(body: CreateSignUpTokenRequest) -> Single<CreateSignUpTokenResponseEntity?> {
        return loginRepository.createSignUpToken(body: body)
    }
    
}
