//
//  FetchVoteOptionsUseCase.swift
//  CommonDomain
//
//  Created by Kim dohyun on 10/10/24.
//

import Foundation

import RxSwift
import RxCocoa

public protocol FetchVoteOptionsUseCaseProtocol {
    func execute() -> Single<VoteResponseEntity?>
}

public final class FetchVoteOptionsUseCase: FetchVoteOptionsUseCaseProtocol {
    
    private let commonRepository: CommonRepositoryProtocol
    
    public init(commonRepository: CommonRepositoryProtocol) {
        self.commonRepository = commonRepository
    }
    
    public func execute() -> Single<VoteResponseEntity?> {
        return commonRepository.fetchVoteOptions()
    }
}
