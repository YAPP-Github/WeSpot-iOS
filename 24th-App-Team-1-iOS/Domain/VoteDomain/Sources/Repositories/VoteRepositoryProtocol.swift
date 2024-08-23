//
//  VoteRepositoryProtocol.swift
//  VoteDomain
//
//  Created by Kim dohyun on 7/22/24.
//

import Foundation

import RxSwift

public protocol VoteRepositoryProtocol {
    func fetchClassMateItems() -> Single<VoteClassMatesEntity?>
    func fetchVoteOptions() -> Single<VoteResponseEntity?>
    func fetchWinnerVoteOptions(query: VoteWinnerRequestQuery) -> Single<VoteWinnerResponseEntity?>
    func uploadFinalVoteResults(body: [CreateVoteItemReqeuest]) -> Single<CreateVoteEntity?>
    func fetchAllVoteResults(query: VoteWinnerRequestQuery) -> Single<VoteAllReponseEntity?>
    func fetchVoteReceiveItems(query: VoteReceiveRequestQuery) -> Single<VoteRecevieEntity?>
    func fetchVoteSentItems(query: VoteSentRequestQuery) -> Single<VoteSentEntity?>
    func fetchVoteIndividualItem(id: Int, query: VoteIndividualQuery) -> Single<VoteIndividualEntity?>
}
