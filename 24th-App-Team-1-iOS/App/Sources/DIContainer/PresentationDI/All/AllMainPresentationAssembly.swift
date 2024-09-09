//
//  AllMainPresentationAssembly.swift
//  wespot
//
//  Created by Kim dohyun on 8/11/24.
//

import Foundation
import AllFeature
import AllDomain

import Swinject


struct AllMainPresentationAssembly: Assembly {
    func assemble(container: Container) {
        container.register(AllMainViewReactor.self) { resolver in
            let fetchUserProfileUseCase = resolver.resolve(FetchUserProfileUseCaseProtocol.self)!
            return AllMainViewReactor(fetchUserProfileUseCase: fetchUserProfileUseCase)
        }
        
        container.register(AllMainViewController.self) { resolver in
            let reactor = resolver.resolve(AllMainViewReactor.self)!
            
            return AllMainViewController(reactor: reactor)
        }
    }
}
