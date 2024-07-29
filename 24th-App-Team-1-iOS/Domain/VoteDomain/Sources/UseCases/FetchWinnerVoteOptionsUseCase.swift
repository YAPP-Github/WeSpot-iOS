//
//  FetchWinnerVoteOptionsUseCase.swift
//  VoteDomain
//
//  Created by Kim dohyun on 7/28/24.
//

import Foundation

import RxSwift
import RxCocoa

public protocol FetchWinnerVoteOptionsUseCaseProtocol {
    func execute(query: VoteWinnerRequestQuery) -> Single<VoteWinnerResponseEntity?>
}

public final class FetchWinnerVoteOptionsUseCase: FetchWinnerVoteOptionsUseCaseProtocol {
    
    public let voteRepository: VoteRepositoryProtocol
    
    public init(voteRepository: VoteRepositoryProtocol) {
        self.voteRepository = voteRepository
    }
    
    public func execute(query: VoteWinnerRequestQuery) -> Single<VoteWinnerResponseEntity?> {
        return voteRepository.fetchWinnerVoteOptions(query: query)
    }
}
