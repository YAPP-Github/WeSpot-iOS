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
    
    public let profileRepository: ProfileRepositoryProtocol
    
    public init(profileRepository: ProfileRepositoryProtocol) {
        self.profileRepository = profileRepository
    }
    
    public func execute(body: UpdateUserProfileRequest) -> Single<Bool> {
        return profileRepository.updateUserProfileItem(body: body)
    }
}
