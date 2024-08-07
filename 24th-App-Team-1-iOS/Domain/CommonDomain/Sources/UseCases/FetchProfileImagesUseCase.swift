//
//  fetchProfileImagesUseCase.swift
//  CommonDomain
//
//  Created by eunseou on 8/6/24.
//

import Foundation

import RxSwift
import RxCocoa

public protocol FetchProfileImagesUseCaseProtocol {
    func execute() -> Single<FetchProfileImageResponseEntity?>
}

public final class FetchProfileImagesUseCase: FetchProfileImagesUseCaseProtocol {
    
    public let commonRepository : CommonRepositoryProtocol
    
    public init(commonRepository: CommonRepositoryProtocol) {
        self.commonRepository = commonRepository
    }
    
    public func execute() -> Single<FetchProfileImageResponseEntity?> {
        return commonRepository.fetchProfileImages()
    }
}
