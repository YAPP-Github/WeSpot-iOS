//
//  VoteRepository.swift
//  VoteService
//
//  Created by Kim dohyun on 7/22/24.
//

import Foundation

import RxSwift
import RxCocoa
import Extensions
import Networking
import VoteDomain


public final class VoteRepository: VoteRepositoryProtocol {
    private let networkService: WSNetworkServiceProtocol = WSNetworkService()
    
    
    public func fetchVoteOptions() -> Single<VoteItemEntity?> {
        let endPoint = VoteEndPoint.fetchVoteOptions
        return networkService.request(endPoint: endPoint)
            .asObservable()
            .decodeMap(VoteItemResponseDTO.self)
            .compactMap { $0.toDomain() }
            .asSingle()
    }
}
