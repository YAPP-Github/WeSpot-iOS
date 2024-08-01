//
//  FetchAllVoteOptionsUseCase.swift
//  VoteDomain
//
//  Created by Kim dohyun on 7/30/24.
//

import Foundation

import RxSwift
import RxCocoa

public protocol FetchAllVoteOptionsUseCaseProtocol {
    func execute(query: VoteWinnerRequestQuery) -> Single<VoteAllReponseEntity?>
}

public final class FetchAllVoteOptionsUseCase: FetchAllVoteOptionsUseCaseProtocol {
    
    public let voteRepositroy: VoteRepositoryProtocol
    
    public init(voteRepositroy: VoteRepositoryProtocol) {
        self.voteRepositroy = voteRepositroy
    }
    
    
    public func execute(query: VoteWinnerRequestQuery) -> Single<VoteAllReponseEntity?> {
        
        return voteRepositroy.fetchAllVoteResults(query: query)
    }
}
