//
//  CreateProfanityCheckUseCase.swift
//  LoginDomain
//
//  Created by eunseou on 7/31/24.
//

import Foundation

import RxSwift
import RxCocoa

public protocol createProfanityCheckUseCaseProtocol {
    func execute(body: CreateProfanityCheckRequest) -> Single<Void?>
}


public final class createProfanityCheckUseCase: createProfanityCheckUseCaseProtocol {
    
    
    public let loginRepository: LoginRepositoryProtocol
    
    public init(loginRepository: LoginRepositoryProtocol) {
        self.loginRepository = loginRepository
    }

    public func execute(body: CreateProfanityCheckRequest) -> Single<Void?> {
        return loginRepository.createProfanityCheck(body: body)
    }
}
