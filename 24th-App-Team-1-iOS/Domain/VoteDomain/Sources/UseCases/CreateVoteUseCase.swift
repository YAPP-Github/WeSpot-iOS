//
//  CreateVoteUseCase.swift
//  VoteDomain
//
//  Created by Kim dohyun on 7/25/24.
//

import Foundation

import RxSwift

public protocol CreateVoteUseCaseProtocol {
    func execute(body: [CreateVoteItemReqeuest]) -> Single<CreateVoteEntity?>
}

public final class CreateVoteUseCase: CreateVoteUseCaseProtocol {
    
    private let repository: VoteRepositoryProtocol
    
    public init(repository: VoteRepositoryProtocol) {
        self.repository = repository
    }
    
    public func execute(body: [CreateVoteItemReqeuest]) -> Single<CreateVoteEntity?> {
        return repository.uploadFinalVoteResults(body: body)
    }
}
