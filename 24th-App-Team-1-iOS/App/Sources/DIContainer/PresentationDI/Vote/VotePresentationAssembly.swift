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
        container.register(VoteMainViewReactor.self) { resolver in
            let useCase = resolver.resolve(FetchVoteOptionsUseCaseProtocol.self)!
            return VoteMainViewReactor(fetchVoteOptionsUseCase: useCase)
        }
        
        container.register(VoteMainViewController.self) { resolver in
            let reactor = resolver.resolve(VoteMainViewReactor.self)!
            return VoteMainViewController(reactor: reactor)
        }
    }
}
