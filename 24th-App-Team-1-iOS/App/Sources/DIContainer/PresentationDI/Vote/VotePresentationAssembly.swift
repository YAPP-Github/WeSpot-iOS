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
        container.register(VoteProcessViewReactor.self) { (resolver, voteResponseEntity: VoteResponseEntity?) in
            let createVoteUseCase = resolver.resolve(CreateVoteUseCaseProtocol.self)!
            let createUserReportUseCase = resolver.resolve(CreateReportUserUseCaseProtocol.self)!
            let fetchVoteOptionsUseCase = resolver.resolve(FetchVoteOptionsUseCaseProtocol.self)!
            return VoteProcessViewReactor(
                createVoteUseCase: createVoteUseCase,
                createUserReportUseCase: createUserReportUseCase,
                voteResponseEntity: voteResponseEntity
            )
        }
        
        container.register(VoteProcessViewReactor.self) { resolver in
            let createVoteUseCase = resolver.resolve(CreateVoteUseCaseProtocol.self)!
            let createUserReportUseCase = resolver.resolve(CreateReportUserUseCaseProtocol.self)!
            let fetchVoteOptionsUseCase = resolver.resolve(FetchVoteOptionsUseCaseProtocol.self)!
            
            return VoteProcessViewReactor(
                createVoteUseCase: createVoteUseCase,
                createUserReportUseCase: createUserReportUseCase
            )
        }
        
        container.register(VoteProcessViewController.self) { (resolver, voteResponseEntity: VoteResponseEntity?) in
            let reactor = resolver.resolve(VoteProcessViewReactor.self, argument: voteResponseEntity)!
            
            return VoteProcessViewController(reactor: reactor)
        }
        
        container.register(VoteProcessViewController.self) { resolver in
            let reactor = resolver.resolve(VoteProcessViewReactor.self)!
            
            return VoteProcessViewController(reactor: reactor)
        }
        
        container.register(VoteBeginViewReactor.self) { resolver in
            let fetchUserProfileUseCase = resolver.resolve(FetchUserProfileUseCaseProtocol.self)!
            return VoteBeginViewReactor(fetchUserProfileUseCase: fetchUserProfileUseCase)
        }
        
        container.register(VoteBeginViewController.self) { resolver in
            let reactor = resolver.resolve(VoteBeginViewReactor.self)!
            
            return VoteBeginViewController(reactor: reactor)
        }
    }
}
