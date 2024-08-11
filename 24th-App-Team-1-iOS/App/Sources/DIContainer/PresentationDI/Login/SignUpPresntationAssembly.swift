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
        
        container.register(SignUpSchoolViewReactor.self) { (resolver, accountRequest: CreateAccountRequest) in
            let fetchSchoolListUseCase = resolver.resolve(FetchSchoolListUseCaseProtocol.self)!
            return SignUpSchoolViewReactor(fetchSchoolListUseCase: fetchSchoolListUseCase, accountRequest: accountRequest)
        }

        container.register(SignUpSchoolViewController.self) { (resolver, argument: CreateAccountRequest) in
            let reactor = resolver.resolve(SignUpSchoolViewReactor.self, argument: argument)!
            
            return SignUpSchoolViewController(reactor: reactor)
        }

    }
}

/// SignUpClass DIContainer
struct SignUpClassPresentationAssembly: Assembly {
    func assemble(container: Container) {

        container.register(SignUpClassViewReactor.self) {(resolver, accountRequest: CreateAccountRequest) in
            return SignUpClassViewReactor(accountRequest: accountRequest)
        }

        container.register(SignUpClassViewController.self) { (resolver, argument: CreateAccountRequest) in
            let reactor = resolver.resolve(SignUpClassViewReactor.self, argument: argument)!

            return SignUpClassViewController(reactor: reactor)
        }

    }
}

/// SignUpClass DIContainer
struct SignUpGradePresentationAssembly: Assembly {
    func assemble(container: Container) {

        container.register(SignUpGradeViewReactor.self) {(resolver, accountRequest: CreateAccountRequest) in
            return SignUpGradeViewReactor(accountRequest: accountRequest)
        }

        container.register(SignUpGradeViewController.self) { (resolver, accountRequest: CreateAccountRequest) in
            let reactor = resolver.resolve(SignUpGradeViewReactor.self, argument: accountRequest)!
            return SignUpGradeViewController(reactor: reactor)
        }

    }
}


/// SignUpGender DIContainer
struct SignUpGenderPresentationAssembly: Assembly {
    func assemble(container: Container) {

        container.register(SignUpGenderViewReactor.self) { (resolver, accountRequest: CreateAccountRequest) in
            return SignUpGenderViewReactor(accountRequest: accountRequest)
        }

        container.register(SignUpGenderViewController.self) { (resolver, argument: CreateAccountRequest) in
            let reactor = resolver.resolve(SignUpGenderViewReactor.self, argument: argument)!
            return SignUpGenderViewController(reactor: reactor)
        }

    }
}

/// SignUpName DIContainer
struct SignUpNamePresentationAssembly: Assembly {
    func assemble(container: Container) {
        container.register(SignUpNameViewReactor.self) { (resolver, accountRequest: CreateAccountRequest) in
            let createCheckProfanityUseCase = resolver.resolve(CreateCheckProfanityUseCaseProtocol.self)!
            return SignUpNameViewReactor(createCheckProfanityUseCase: createCheckProfanityUseCase, accountRequest: accountRequest)
        }

        container.register(SignUpNameViewController.self) { (resolver, argument: CreateAccountRequest) in
            let reactor = resolver.resolve(SignUpNameViewReactor.self, argument: argument)!
            return SignUpNameViewController(reactor: reactor)
        }

    }
}


/// SignUpResult DIContainer
struct SignUpResultPresentationAssembly: Assembly {
    func assemble(container: Container) {

        container.register(SignUpResultViewReactor.self) { (resolver, accountRequest: CreateAccountRequest) in
            return SignUpResultViewReactor(accountRequest: accountRequest)
        }

        container.register(SignUpResultViewController.self) { (resolver, argument: CreateAccountRequest) in
            let reactor = resolver.resolve(SignUpResultViewReactor.self, argument: argument)!
            return SignUpResultViewController(reactor: reactor)
        }

    }
}

/// SignUpComplete DIContainer
struct SignUpCompletePresentationAssembly: Assembly {
    func assemble(container: Container) {

        container.register(SignUpClassViewReactor.self) { (resolver, accountRequest: CreateAccountRequest) in
            return SignUpClassViewReactor(accountRequest: accountRequest)
        }

        container.register(SignUpClassViewController.self) { (resolver, argument: CreateAccountRequest) in
            let reactor = resolver.resolve(SignUpClassViewReactor.self, argument: argument)!
            return SignUpClassViewController(reactor: reactor)
        }

    }
}
