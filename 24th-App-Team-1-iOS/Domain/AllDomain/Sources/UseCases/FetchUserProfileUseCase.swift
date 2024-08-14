//
//  FetchUserProfileUseCase.swift
//  AllDomain
//
//  Created by Kim dohyun on 8/12/24.
//

import Foundation

import RxSwift
import RxCocoa

public protocol FetchUserProfileUseCaseProtocol {
    func execute() -> Single<UserProfileEntity?>
}

public final class FetchUserProfileUseCase: FetchUserProfileUseCaseProtocol {
    
    
    private let profileRepository: ProfileRepositoryProtocol
    
    public init(profileRepository: ProfileRepositoryProtocol) {
        self.profileRepository = profileRepository
    }
    
    public func execute() -> Single<UserProfileEntity?> {
        return profileRepository.fetchUserProfileItems()
    }
}
