//
//  UpdateUserProfileUseCase.swift
//  AllDomain
//
//  Created by Kim dohyun on 8/13/24.
//

import Foundation

import RxSwift
import RxCocoa

public protocol UpdateUserProfileUseCaseProtocol {
    func execute(body: UpdateUserProfileRequest) -> Single<Bool>
}


public final class UpdateUserProfileUseCase: UpdateUserProfileUseCaseProtocol {
    
    public let commonRepository: CommonRepositoryProtocol
    
    public init(commonRepository: CommonRepositoryProtocol) {
        self.commonRepository = commonRepository
    }
    
    public func execute(body: UpdateUserProfileRequest) -> Single<Bool> {
        return commonRepository.updateUserProfileItem(body: body)
    }
}
