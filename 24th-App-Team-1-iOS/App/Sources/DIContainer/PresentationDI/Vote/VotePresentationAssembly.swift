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
            let useCase = resolver.resolve(FetchVoteOptionsUseCaseProtocol.self)!
            return VoteProcessViewReactor(fetchVoteOptionsUseCase: useCase)
        }
        
        container.register(VoteProcessViewController.self) { resolver in
            let reactor = resolver.resolve(VoteProcessViewReactor.self)!
            return VoteProcessViewController(reactor: reactor)
        }
    }
}
