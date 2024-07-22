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
    func execute() -> Single<[VoteItemEntity]?>
}

public final class FetchVoteOptionsUseCase: FetchVoteOptionsUseCaseProtocol {
    public func execute() -> Single<[VoteItemEntity]?> {
        return .never()
    }
}
