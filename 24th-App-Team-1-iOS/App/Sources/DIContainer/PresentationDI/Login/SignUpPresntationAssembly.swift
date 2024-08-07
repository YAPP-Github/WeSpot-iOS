//
//  SignUpPresntationAssembly.swift
//  wespot
//
//  Created by eunseou on 7/31/24.
//

import Foundation
import CommonDomain
import LoginFeature
import LoginDomain

import Swinject


/// SignUpSchool DIContainer
struct SignUpSchoolPresentationAssembly: Assembly {
    func assemble(container: Container) {
        container.register(SignUpSchoolViewReactor.self) { resolver in
            
            let fetchSchoolListUseCase = resolver.resolve(FetchSchoolListUseCaseProtocol.self)!
            return SignUpSchoolViewReactor(fetchSchoolListUseCase: fetchSchoolListUseCase)
        }

        container.register(SignUpSchoolViewController.self) { resolver in
            let reactor = resolver.resolve(SignUpSchoolViewReactor.self)!

            return SignUpSchoolViewController(reactor: reactor)
        }

    }
}

/// SignUpClass DIContainer
struct SignUpClassPresentationAssembly: Assembly {
    func assemble(container: Container) {

        container.register(SignUpClassViewReactor.self) { _ in
            return SignUpClassViewReactor()
        }

        container.register(SignUpClassViewController.self) { resolver in
            let reactor = resolver.resolve(SignUpClassViewReactor.self)!

            return SignUpClassViewController(reactor: reactor)
        }

    }
}

/// SignUpGender DIContainer
struct SignUpGenderPresentationAssembly: Assembly {
    func assemble(container: Container) {

        container.register(SignUpGenderViewReactor.self) { _ in
            return SignUpGenderViewReactor()
        }

        container.register(SignUpGenderViewController.self) { resolver in
            let reactor = resolver.resolve(SignUpGenderViewReactor.self)!

            return SignUpGenderViewController(reactor: reactor)
        }

    }
}

/// SignUpName DIContainer
struct SignUpNamePresentationAssembly: Assembly {
    func assemble(container: Container) {
        container.register(SignUpNameViewReactor.self) { resolver in
            let createCheckProfanityUseCase = resolver.resolve(CreateCheckProfanityUseCaseProtocol.self)!
            return SignUpNameViewReactor(createCheckProfanityUseCase: createCheckProfanityUseCase)
        }

        container.register(SignUpNameViewController.self) { resolver in
            let reactor = resolver.resolve(SignUpNameViewReactor.self)!

            return SignUpNameViewController(reactor: reactor)
        }

    }
}


/// SignUpResult DIContainer
struct SignUpResultPresentationAssembly: Assembly {
    func assemble(container: Container) {

        container.register(SignUpResultViewReactor.self) { _ in
            return SignUpResultViewReactor()
        }

        container.register(SignUpResultViewController.self) { resolver in
            let reactor = resolver.resolve(SignUpResultViewReactor.self)!

            return SignUpResultViewController(reactor: reactor)
        }

    }
}

/// SignUpComplete DIContainer
struct SignUpCompletePresentationAssembly: Assembly {
    func assemble(container: Container) {

        container.register(SignUpClassViewReactor.self) { _ in
            return SignUpClassViewReactor()
        }

        container.register(SignUpClassViewController.self) { resolver in
            let reactor = resolver.resolve(SignUpClassViewReactor.self)!

            return SignUpClassViewController(reactor: reactor)
        }

    }
}
