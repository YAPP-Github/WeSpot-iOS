//
//  VotePresentationAssembly.swift
//  wespot
//
//  Created by Kim dohyun on 7/23/24.
//

import Foundation
import VoteFeature
import VoteDomain
import CommonDomain

import Swinject


struct VotePresentationAssembly: Assembly {
    func assemble(container: Container) {
        container.register(VoteProcessViewReactor.self) { (resolver, voteResponseEntity: VoteResponseEntity, voteOptionStub: [CreateVoteItemReqeuest], processCount: Int) in
            let createVoteUseCase = resolver.resolve(CreateVoteUseCaseProtocol.self)!
            let createUserReportUseCase = resolver.resolve(CreateReportUserUseCaseProtocol.self)!
            
            return VoteProcessViewReactor(
                createVoteUseCase: createVoteUseCase,
                createUserReportUseCase: createUserReportUseCase,
                voteResponseEntity: voteResponseEntity,
                voteOptionStub: voteOptionStub,
                processCount: processCount
            )
        }
        
        container.register(VoteProcessViewController.self) { (resolver, voteResponseEntity: VoteResponseEntity, voteOptionStub: [CreateVoteItemReqeuest], processCount: Int) in
            let reactor = resolver.resolve(VoteProcessViewReactor.self, arguments: voteResponseEntity, voteOptionStub, processCount)!
            
            return VoteProcessViewController(reactor: reactor)
        }
    }
}
