//
//  CreateUserResignUseCase.swift
//  AllDomain
//
//  Created by Kim dohyun on 8/17/24.
//

import Foundation

import RxSwift
import RxCocoa

public protocol CreateUserResignUseCaseProtocol {
    func execute() -> Single<Bool>
}


public final class CreateUserResignUseCase: CreateUserResignUseCaseProtocol {
    
    private let profileRepository: ProfileRepositoryProtocol
    
    public init(profileRepository: ProfileRepositoryProtocol) {
        self.profileRepository = profileRepository
    }
    
    public func execute() -> Single<Bool> {
        return profileRepository.createUserResignItem()
    }
    
}
