//
//  VoteInventoryPresentationAssembly.swift
//  wespot
//
//  Created by Kim dohyun on 8/7/24.
//

import Foundation
import VoteFeature
import VoteDomain

import Swinject



struct VoteInventoryPresentationAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(VoteInventoryViewReactor.self) { resolver in
            let fetchReceiveUseCase = resolver.resolve(FetchVoteReceiveItemUseCaseProtocol.self)!
            let fetchSentUseCase = resolver.resolve(FetchVoteSentItemUseCaseProtocol.self)!
            
            return VoteInventoryViewReactor(
                fetchVoteReceiveItemUseCase: fetchReceiveUseCase,
                fetchVoteSentItemUseCase: fetchSentUseCase
            )
        }
        
        container.register(VoteInventoryViewController.self) { resolver in
            
            let reactor = container.resolve(VoteInventoryViewReactor.self)!
            
            return VoteInventoryViewController(reactor: reactor)
        }
    }
}
