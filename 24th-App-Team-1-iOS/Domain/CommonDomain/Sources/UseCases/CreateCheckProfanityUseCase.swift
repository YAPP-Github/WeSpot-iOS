//
//  CreateCheckProfanityUseCase.swift
//  CommonDomain
//
//  Created by eunseou on 8/4/24.
//

import Foundation

import RxSwift
import RxCocoa

public protocol CreateCheckProfanityUseCaseProtocol {
    func execute(body: CreateCheckProfanityRequest) -> Single<Bool>
}

public final class createCheckProfanityUseCase: CreateCheckProfanityUseCaseProtocol {
    
    public let commonRepository: CommonRepositoryProtocol
    
    public init(commonRepository: CommonRepositoryProtocol) {
        self.commonRepository = commonRepository
    }

    public func execute(body: CreateCheckProfanityRequest) -> Single<Bool> {
        return commonRepository.createCheckProfanity(body: body)
    }
}
