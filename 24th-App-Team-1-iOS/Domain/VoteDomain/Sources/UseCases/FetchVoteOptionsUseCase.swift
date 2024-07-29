//
//  FetchVoteOptionsUseCase.swift
//  VoteDomain
//
//  Created by Kim dohyun on 7/22/24.
//

import Foundation

import RxSwift
import RxCocoa

public protocol FetchVoteOptionsUseCaseProtocol {
    func execute() -> Single<VoteResponseEntity?>
}

public final class FetchVoteOptionsUseCase: FetchVoteOptionsUseCaseProtocol {
    
    private let voteRepository: VoteRepositoryProtocol
    
    public init(voteRepository: VoteRepositoryProtocol) {
        self.voteRepository = voteRepository
    }
    
    public func execute() -> Single<VoteResponseEntity?> {
        return voteRepository.fetchVoteOptions()
    }
}
