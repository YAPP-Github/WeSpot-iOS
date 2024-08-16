//
//  AllMainProfileUserBlockPresentationAssembly.swift
//  wespot
//
//  Created by Kim dohyun on 8/15/24.
//

import Foundation
import AllFeature
import AllDomain

import Swinject

struct AllMainProfileUserBlockPresentationAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(ProfileUserBlockViewReactor.self) { resolver in
            let fetchUserBlockUseCase = resolver.resolve(FetchUserBlockUseCaseProtocol.self)!
            return ProfileUserBlockViewReactor(fetchUserBlockUseCase: fetchUserBlockUseCase)
        }
        
        container.register(ProfileUserBlockViewController.self) { resolver in
            let reactor = resolver.resolve(ProfileUserBlockViewReactor.self)
            
            return ProfileUserBlockViewController(reactor: reactor)
        }
    }
}
