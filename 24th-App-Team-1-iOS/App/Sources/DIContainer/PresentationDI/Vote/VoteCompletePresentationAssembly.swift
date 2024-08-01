//
//  VoteCompletePresentationAssembly.swift
//  wespot
//
//  Created by Kim dohyun on 7/29/24.
//

import Foundation
import VoteFeature
import VoteDomain

import Swinject

struct VoteCompletePresentationAssembly: Assembly {
    func assemble(container: Container) {
        container.register(VoteCompleteViewReactor.self) { resolver in
            let fetchAllVoteUseCase = resolver.resolve(FetchAllVoteOptionsUseCaseProtocol.self)!
            return VoteCompleteViewReactor(fetchAllVoteOptionsUseCase: fetchAllVoteUseCase)
        }
        
        container.register(VoteCompleteViewController.self) { resolver in
            let reactor = resolver.resolve(VoteCompleteViewReactor.self)!
            
            return VoteCompleteViewController(reactor: reactor)
        }
    }
    
}
