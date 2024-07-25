//
//  VoteRepositoryProtocol.swift
//  VoteDomain
//
//  Created by Kim dohyun on 7/22/24.
//

import Foundation

import RxSwift

public protocol VoteRepositoryProtocol {
    func fetchVoteOptions() -> Single<VoteResponseEntity?>
    func uploadFinalVoteResults(body: [CreateVoteItemReqeuest]) -> Single<CreateVoteEntity?>
}
