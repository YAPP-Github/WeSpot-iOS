//
//  UpdateUserBlockUseCase.swift
//  AllDomain
//
//  Created by Kim dohyun on 8/16/24.
//

import Foundation

import RxSwift
import RxCocoa

public protocol UpdateUserBlockUseCaseProtocol {
    func execute(path: String) -> Single<Bool>
}


public final class UpdateUserBlockUseCase: UpdateUserBlockUseCaseProtocol {

    private let profileRepository: ProfileRepositoryProtocol
    
    public init(profileRepository: ProfileRepositoryProtocol) {
        self.profileRepository = profileRepository
    }
    
    public func execute(path: String) -> Single<Bool> {
        return profileRepository.updateUserBlockItem(path: path)
    }
}
