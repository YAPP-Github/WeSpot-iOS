//
//  SignInPresentationAssembly.swift
//  wespot
//
//  Created by eunseou on 7/31/24.
//

import Foundation
import LoginFeature
import LoginDomain

import Swinject

/// SignIn DIContainer
struct SignInPresentationAssembly: Assembly {
    func assemble(container: Container) {
        
        container.register(SignInViewReactor.self) { resolver in
            let createSignUpTokenUseCase = resolver.resolve(CreateSignUpTokenUseCaseProtocol.self)!
            return SignInViewReactor(createSignUpTokenUseCase: createSignUpTokenUseCase)
        }
        
        container.register(SignInViewController.self) { resolver in
            let reactor = resolver.resolve(SignInViewReactor.self)!
        
            return SignInViewController(reactor: reactor)
        }
        
    }
}
