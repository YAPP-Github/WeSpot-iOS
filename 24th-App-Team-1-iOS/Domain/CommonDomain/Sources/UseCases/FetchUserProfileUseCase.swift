//
//  FetchUserProfileUseCase.swift
//  CommonDomain
//
//  Created by 김도현 on 10/16/24.
//

import Foundation

import RxSwift
import RxCocoa


public protocol FetchUserProfileUseCaseProtocol {
    func execute() -> Single<UserProfileEntity?>
}


public final class FetchUserProfileUseCase: FetchUserProfileUseCaseProtocol {
    
    private let commonRepository: CommonRepositoryProtocol
    
    public init(commonRepository: CommonRepositoryProtocol) {
        self.commonRepository = commonRepository
    }
    
    
    public func execute() -> Single<UserProfileEntity?> {
        return commonRepository.fetchUserProfileItems()
    }
}
