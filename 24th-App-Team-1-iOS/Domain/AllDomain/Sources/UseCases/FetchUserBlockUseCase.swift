//
//  FetchUserBlockUseCase.swift
//  AllDomain
//
//  Created by Kim dohyun on 8/15/24.
//

import Foundation

import RxSwift
import RxCocoa

public protocol FetchUserBlockUseCaseProtocol {
    func execute(query: UserBlockRequestQuery) -> Single<UserBlockEntity?>
}

public final class FetchUserBlockUseCase: FetchUserBlockUseCaseProtocol {
    
    private let profileRepository: ProfileRepositoryProtocol
    
    public init(profileRepository: ProfileRepositoryProtocol) {
        self.profileRepository = profileRepository
    }
    
    
    public func execute(query: UserBlockRequestQuery) -> Single<UserBlockEntity?> {
        return profileRepository.fetchUserBlockItems(query: query)
    }
}
