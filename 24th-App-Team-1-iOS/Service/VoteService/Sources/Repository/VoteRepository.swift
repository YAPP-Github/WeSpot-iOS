//
//  VoteRepository.swift
//  VoteService
//
//  Created by Kim dohyun on 7/22/24.
//

import Foundation

import RxSwift
import Networking
import VoteDomain


public final class VoteRepository: VoteRepositoryProtocol {
    private let networkService: WSNetworkServiceProtocol = WSNetworkService()
    
    
    public func fetchVoteOptions() -> Single<[VoteItemEntity]?> {
        let endPoint = VoteEndPoint.fetchVoteOptions
       
        return .never()
    }
}
