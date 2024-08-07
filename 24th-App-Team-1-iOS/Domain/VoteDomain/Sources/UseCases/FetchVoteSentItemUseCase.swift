//
//  FetchVoteSentItemUseCase.swift
//  VoteDomain
//
//  Created by Kim dohyun on 8/7/24.
//

import Foundation

import RxSwift
import RxCocoa

public protocol FetchVoteSentItemUseCaseProtocol {
    func execute() -> Single<VoteSentEntity?>
}

public final class FetchVoteSentItemUseCase: FetchVoteSentItemUseCaseProtocol {
    
    private let voteRepository: VoteRepositoryProtocol
    
    public init(voteRepository: VoteRepositoryProtocol) {
        self.voteRepository = voteRepository
    }
    
    public func execute() -> Single<VoteSentEntity?> {
        return voteRepository.fetchVoteSentItems()
    }
}
