//
//  SetUpProfilePresntationAssembly.swift
//  wespot
//
//  Created by eunseou on 8/3/24.
//

import Foundation
import LoginFeature
import CommonDomain

import Swinject

struct SetUpProfilePresntationAssembly: Assembly {
    func assemble(container: Container) {
        container.register(SetUpProfileImageViewReactor.self) { resolver in
            
            let fetchProfileImagesUseCase = resolver.resolve(FetchProfileImagesUseCaseProtocol.self)!
            let fetchProfileBackgroundsUseCase = resolver.resolve(FetchProfileBackgroundsUseCaseProtocol.self)!
            
            return SetUpProfileImageViewReactor(
                fetchProfileImagesUseCase: fetchProfileImagesUseCase,
                fetchProfileBackgroundsUseCase: fetchProfileBackgroundsUseCase
            )
        }
        
        container.register(SetUpProfileImageViewController.self) {  resolver in
            let reactor = resolver.resolve(SetUpProfileImageViewReactor.self)!

            return SetUpProfileImageViewController(reactor: reactor)
        }
    }
}
