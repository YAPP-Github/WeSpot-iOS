//
//  FetchVoteReceiveItemUseCase.swift
//  VoteDomain
//
//  Created by Kim dohyun on 8/7/24.
//

import Foundation

import RxSwift
import RxCocoa

public protocol FetchVoteReceiveItemUseCaseProtocol {
    func execute() -> Single<VoteRecevieEntity?>
}


public final class FetchVoteReceiveItemUseCase: FetchVoteReceiveItemUseCaseProtocol {
    public let voteRepository: VoteRepositoryProtocol
    
    public init(voteRepository: VoteRepositoryProtocol) {
        self.voteRepository = voteRepository
    }
    
    public func execute() -> Single<VoteRecevieEntity?> {
        return voteRepository.fetchVoteReceiveItems()
    }
}
