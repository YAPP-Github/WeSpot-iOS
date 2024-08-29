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
        
        container.register(SignUpSchoolViewReactor.self) { (resolver, accountRequest: CreateAccountRequest, schoolName: String)  in
            let fetchSchoolListUseCase = resolver.resolve(FetchSchoolListUseCaseProtocol.self)!
            return SignUpSchoolViewReactor(fetchSchoolListUseCase: fetchSchoolListUseCase, accountRequest: accountRequest, schoolName: schoolName)
        }

        container.register(SignUpSchoolViewController.self) { (resolver, accountRequest: CreateAccountRequest, schoolName: String) in
            let reactor = resolver.resolve(SignUpSchoolViewReactor.self, arguments: accountRequest, schoolName)!
            
            return SignUpSchoolViewController(reactor: reactor)
        }

    }
}

/// SignUpGrade DIContainer
struct SignUpGradePresentationAssembly: Assembly {
    func assemble(container: Container) {

        container.register(SignUpGradeViewReactor.self) {(resolver, accountRequest: CreateAccountRequest, schoolName: String) in
            return SignUpGradeViewReactor(accountRequest: accountRequest, schoolName: schoolName)
        }

        container.register(SignUpGradeViewController.self) { (resolver, accountRequest: CreateAccountRequest, schoolName: String) in
            let reactor = resolver.resolve(SignUpGradeViewReactor.self, arguments: accountRequest, schoolName)!
            return SignUpGradeViewController(reactor: reactor)
        }

    }
}

/// SignUpClass DIContainer
struct SignUpClassPresentationAssembly: Assembly {
    func assemble(container: Container) {

        container.register(SignUpClassViewReactor.self) {(resolver, accountRequest: CreateAccountRequest, schoolName: String) in
            return SignUpClassViewReactor(accountRequest: accountRequest, schoolName: schoolName)
        }

        container.register(SignUpClassViewController.self) { (resolver, argument: CreateAccountRequest, schollName: String) in
            let reactor = resolver.resolve(SignUpClassViewReactor.self, arguments: argument, schollName)!
            return SignUpClassViewController(reactor: reactor)
        }

    }
}


/// SignUpGender DIContainer
struct SignUpGenderPresentationAssembly: Assembly {
    func assemble(container: Container) {

        container.register(SignUpGenderViewReactor.self) { (resolver, accountRequest: CreateAccountRequest, schoolName: String) in
            return SignUpGenderViewReactor(accountRequest: accountRequest, schoolName: schoolName)
        }

        container.register(SignUpGenderViewController.self) { (resolver, argument: CreateAccountRequest , schoolName: String) in
            let reactor = resolver.resolve(SignUpGenderViewReactor.self, arguments: argument, schoolName)!
            return SignUpGenderViewController(reactor: reactor)
        }

    }
}

/// SignUpName DIContainer
struct SignUpNamePresentationAssembly: Assembly {
    func assemble(container: Container) {
        container.register(SignUpNameViewReactor.self) { (resolver, accountRequest: CreateAccountRequest, schoolName: String) in
            let createCheckProfanityUseCase = resolver.resolve(CreateCheckProfanityUseCaseProtocol.self)!
            return SignUpNameViewReactor(createCheckProfanityUseCase: createCheckProfanityUseCase, accountRequest: accountRequest, schoolName: schoolName)
        }

        container.register(SignUpNameViewController.self) { (resolver, argument: CreateAccountRequest, schoolName: String) in
            let reactor = resolver.resolve(SignUpNameViewReactor.self, arguments: argument, schoolName)!
            return SignUpNameViewController(reactor: reactor)
        }

    }
}


/// SignUpResult DIContainer
struct SignUpResultPresentationAssembly: Assembly {
    func assemble(container: Container) {
        
        container.register(SignUpInfoBottomSheetViewReactor.self) { (_, accountRequest: CreateAccountRequest, schoolName: String) in
            
            return SignUpInfoBottomSheetViewReactor(accountRequest: accountRequest, schoolName: schoolName)
        }
        
        container.register(SignUpInfoBottomSheetViewController.self) { (resolver, argument: CreateAccountRequest, schoolName: String) in
            let reactor = resolver.resolve(SignUpInfoBottomSheetViewReactor.self, arguments: argument, schoolName)!
            
            return SignUpInfoBottomSheetViewController(reactor: reactor)
        }

        container.register(PolicyAgreementBottomSheetViewReactor.self) { _ in
            return PolicyAgreementBottomSheetViewReactor()
        }
        
        container.register(PolicyAgreementBottomSheetViewController.self) { resolver in
            let reactor = resolver.resolve(PolicyAgreementBottomSheetViewReactor.self)!
            
            return PolicyAgreementBottomSheetViewController(reactor: reactor)
        }
        
        container.register(SignUpResultViewReactor.self) { (resolver, accountRequest: CreateAccountRequest, schoolName: String) in
            let createAccountUseCase = resolver.resolve(CreateAccountUseCaseProtocol.self)!
            return SignUpResultViewReactor(accountRequest: accountRequest, createAccountUseCase: createAccountUseCase, schoolName: schoolName)
        }

        container.register(SignUpResultViewController.self) { (resolver, argument: CreateAccountRequest, schoolName: String) in
            let reactor = resolver.resolve(SignUpResultViewReactor.self, arguments: argument, schoolName)!
            return SignUpResultViewController(reactor: reactor)
        }

    }
}

/// SignUpComplete DIContainer
struct SignUpCompletePresentationAssembly: Assembly {
    func assemble(container: Container) {
        container.register(SignUpCompleteViewReactor.self) { (resolver, accountRequest: CreateAccountRequest) in
            let createAccountUseCase = resolver.resolve(CreateAccountUseCaseProtocol.self)!
            return SignUpCompleteViewReactor(createAccountUseCase: createAccountUseCase, accountRequest: accountRequest)
        }
        
        container.register(SignUpCompleteViewController.self) { (resolver, accountRequest: CreateAccountRequest) in
            let reactor = resolver.resolve(SignUpCompleteViewReactor.self, argument: accountRequest)!
            return SignUpCompleteViewController(reactor: reactor)
        }
        
        container.register(SignUpIntroduceViewReactor.self) { _ in
            return SignUpIntroduceViewReactor()
        }
        
        container.register(SignUpIntroduceViewController.self) { resolver in
            let reactor = resolver.resolve(SignUpIntroduceViewReactor.self)!
            
            return SignUpIntroduceViewController(reactor: reactor)
        }
    }
}
