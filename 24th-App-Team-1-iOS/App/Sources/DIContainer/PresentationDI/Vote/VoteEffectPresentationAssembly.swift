//
//  VoteEffectPresentationAssembly.swift
//  wespot
//
//  Created by Kim dohyun on 8/3/24.
//

import Foundation
import VoteFeature
import VoteDomain

import Swinject



struct VoteEffectPresentationAssembly: Assembly {
    func assemble(container: Container) {
        container.register(VoteEffectViewReactor.self) { resolver in
            let fetchEffectUseCase = resolver.resolve(FetchAllVoteOptionsUseCaseProtocol.self)!
            
            return VoteEffectViewReactor(fetchVoteEffectOptionsUseCase: fetchEffectUseCase)
        }
        
        container.register(VoteEffectViewController.self) { resolver in
            let reactor = resolver.resolve(VoteEffectViewReactor.self)!
            
            return VoteEffectViewController(reactor: reactor)
        }
    }
}
