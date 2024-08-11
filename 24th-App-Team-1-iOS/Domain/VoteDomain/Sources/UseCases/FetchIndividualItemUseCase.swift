//
//  FetchIndividualItemUseCaseProtocol.swift
//  VoteDomain
//
//  Created by Kim dohyun on 8/10/24.
//

import Foundation

import RxSwift
import RxCocoa

public protocol FetchIndividualItemUseCaseProtocol {
    func execute(id: Int, query: VoteIndividualQuery) -> Single<VoteIndividualEntity?>
}

public final class FetchIndividualItemUseCase: FetchIndividualItemUseCaseProtocol {
    
    public let voteRepository: VoteRepositoryProtocol
    
    public init(voteRepository: VoteRepositoryProtocol) {
        self.voteRepository = voteRepository
    }
    
    public func execute(id: Int, query: VoteIndividualQuery) -> Single<VoteIndividualEntity?> {
        return voteRepository.fetchVoteIndividualItem(id: id, query: query)
    }
}
