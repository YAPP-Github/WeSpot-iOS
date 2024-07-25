//
//  VoteRepository.swift
//  VoteService
//
//  Created by Kim dohyun on 7/22/24.
//

import Extensions
import Foundation
import Networking
import Util
import VoteDomain

import RxSwift
import RxCocoa


public final class VoteRepository: VoteRepositoryProtocol {

    private let networkService: WSNetworkServiceProtocol = WSNetworkService()
    
    public init() { }
    
    public func fetchVoteOptions() -> Single<VoteResponseEntity?> {
        let endPoint = VoteEndPoint.fetchVoteOptions
        return networkService.request(endPoint: endPoint)
            .asObservable()
            .logErrorIfDetected(category: Network.error)
            .decodeMap(VoteResponseDTO.self)
            .map { $0.toDomain() }
            .asSingle()
    }
    
    public func uploadFinalVoteResults(body: [CreateVoteItemReqeuest]) -> Single<CreateVoteEntity?> {
        let itemsBody = body.map { return CreateRequestItemsDTO(userId: $0.userId, voteOptionId: $0.voteOptionId) }
        let body = CreateVoteRequestDTO(votes: itemsBody)
        
        let endPoint = VoteEndPoint.addVotes(body)
        
        return networkService.request(endPoint: endPoint)
            .asObservable()
            .logErrorIfDetected(category: Network.error)
            .decodeMap(CreateVoteResponseDTO.self)
            .map { $0.toDomain() }
            .asSingle()
    }
}
