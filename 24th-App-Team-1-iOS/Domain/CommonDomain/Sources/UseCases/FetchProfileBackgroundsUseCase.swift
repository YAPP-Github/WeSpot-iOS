//
//  FetchProfileBackgroundsUseCase.swift
//  CommonDomain
//
//  Created by eunseou on 8/6/24.
//

import Foundation

import RxSwift
import RxCocoa

public protocol FetchProfileBackgroundsUseCaseProtocol {
    func execute() -> Single<FetchProfileBackgroundsResponseEntity?>
}

public final class FetchProfileBackgroundsUseCase: FetchProfileBackgroundsUseCaseProtocol {
    
    public let commonRepository : CommonRepositoryProtocol
    
    public init(commonRepository: CommonRepositoryProtocol) {
        self.commonRepository = commonRepository
    }
    
    public func execute() -> Single<FetchProfileBackgroundsResponseEntity?> {
        return commonRepository.fetchProfileBackgrounds()
    }
}
