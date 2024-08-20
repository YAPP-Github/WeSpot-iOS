//
//  AllMainProfileResignPresentationAssembly.swift
//  wespot
//
//  Created by Kim dohyun on 8/17/24.
//

import Foundation
import AllFeature
import AllDomain

import Swinject

struct AllMainProfileResignPresentationAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(ProfileResignBottomSheetVieReactor.self) { _ in
            return ProfileResignBottomSheetVieReactor()
        }
        
        container.register(ProfileResignBottomSheetView.self) { resolver in
            let reactor = resolver.resolve(ProfileResignBottomSheetVieReactor.self)!
            return ProfileResignBottomSheetView(reactor: reactor)
        }
        
        
        container.register(ProfileResignViewReactor.self) { resolver in
            let createUserResignUseCase = resolver.resolve(CreateUserResignUseCaseProtocol.self)!
            return ProfileResignViewReactor(createUserResignUseCase: createUserResignUseCase)
        }
        
        container.register(ProfileResignViewController.self) { resolver in
            let reactor = resolver.resolve(ProfileResignViewReactor.self)!
            return ProfileResignViewController(reactor: reactor)
        }
    }
}
