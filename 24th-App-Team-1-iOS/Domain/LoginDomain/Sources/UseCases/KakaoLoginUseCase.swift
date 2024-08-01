//
//  KakaoLoginUseCase.swift
//  LoginDomain
//
//  Created by eunseou on 8/2/24.
//

import Foundation

import RxSwift
import RxCocoa

public protocol KakaoLoginUseCaseProtocol {
    func execute() -> Single<String>
}

public final class KakaoLoginUseCase: KakaoLoginUseCaseProtocol {

    public let loginRepository: LoginRepositoryProtocol
    
    public init(loginRepository: LoginRepositoryProtocol) {
        self.loginRepository = loginRepository
    }

    public func execute() -> Single<String> {
        return loginRepository.kakaoLogin()
    }
}
