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
        container.register(VoteCompleteViewReactor.self) { _ in
            return VoteCompleteViewReactor()
        }
        
        container.register(VoteCompleteViewController.self) { resolver in
            let reactor = resolver.resolve(VoteCompleteViewReactor.self)!
            
            return VoteCompleteViewController(reactor: reactor)
        }
    }
    
}
