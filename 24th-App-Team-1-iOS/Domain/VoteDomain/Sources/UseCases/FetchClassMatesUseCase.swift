//
//  FetchClassMatesUseCase.swift
//  VoteDomain
//
//  Created by Kim dohyun on 8/21/24.
//

import Foundation

import RxSwift
import RxCocoa

public protocol FetchClassMatesUseCaseProtocol {
    func execute() -> Single<VoteClassMatesEntity?>
}


public final class FetchClassMatesUseCase: FetchClassMatesUseCaseProtocol {
    
    
    private let voteRepository: VoteRepositoryProtocol
    
    public init(voteRepository: VoteRepositoryProtocol) {
        self.voteRepository = voteRepository
    }
    
    public func execute() -> Single<VoteClassMatesEntity?> {
        return voteRepository.fetchClassMateItems()
    }
    
}
