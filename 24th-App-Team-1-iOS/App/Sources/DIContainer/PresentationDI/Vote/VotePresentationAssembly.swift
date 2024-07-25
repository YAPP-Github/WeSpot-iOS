//
//  VotePresentationAssembly.swift
//  wespot
//
//  Created by Kim dohyun on 7/23/24.
//

import Foundation
import VoteFeature
import VoteDomain

import Swinject

struct VotePresentationAssembly: Assembly {
    func assemble(container: Container) {
        container.register(VoteProcessViewReactor.self) { resolver in
            let fetchVoteOptionsUseCase = resolver.resolve(FetchVoteOptionsUseCaseProtocol.self)!
            let createVoteUseCase = resolver.resolve(CreateVoteUseCaseProtocol.self)!
            
            return VoteProcessViewReactor(fetchVoteOptionsUseCase: fetchVoteOptionsUseCase, createVoteUseCase: createVoteUseCase)
        }
        
        container.register(VoteProcessViewController.self) { resolver in
            let reactor = resolver.resolve(VoteProcessViewReactor.self)!
            return VoteProcessViewController(reactor: reactor)
        }
    }
}
