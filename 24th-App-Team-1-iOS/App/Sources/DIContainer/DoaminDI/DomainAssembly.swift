//
//  DomainAssembly.swift
//  wespot
//
//  Created by Kim dohyun on 7/23/24.
//

import Foundation
import VoteDomain
import LoginDomain

import Swinject

struct DomainAssembly: Assembly {
    func assemble(container: Container) {
        
        // login
        container.register(CreateAccountUseCaseProtocol.self) { resovler in
            let repository = resovler.resolve(LoginRepositoryProtocol.self)!
            return CreateAccountUseCase(loginRepository: repository)
        }
        
        container.register(createProfanityCheckUseCaseProtocol.self) { resovler in
            let repository = resovler.resolve(LoginRepositoryProtocol.self)!
            return createProfanityCheckUseCase(loginRepository: repository)
        }
        
        container.register(CreateRefreshTokenUseCaseProtocol.self) { resovler in
            let repository = resovler.resolve(LoginRepositoryProtocol.self)!
            return createRefreshTokenUseCase(loginRepository: repository)
        }
        
        container.register(CreateNewMemberUseCaseProtocol.self) { resovler in
            let repository = resovler.resolve(LoginRepositoryProtocol.self)!
            return createSignUpTokenUseCase(loginRepository: repository)
        }
        
        container.register(CreateExistingMemberUseCaseProtocol.self) { resovler in
            let repository = resovler.resolve(LoginRepositoryProtocol.self)!
            return createExistingMemberTokenUseCase(loginRepository: repository)
        }
        
        container.register(FetchSchoolListUseCaseProtocol.self) { resovler in
            let repository = resovler.resolve(LoginRepositoryProtocol.self)!
            return FetchSchoolListUseCase(loginRepository: repository)
        }
        
        // vote
        container.register(FetchVoteOptionsUseCaseProtocol.self) { resolver in
            let repository = resolver.resolve(VoteRepositoryProtocol.self)!
            return FetchVoteOptionsUseCase(voteRepository: repository)
        }
        
        container.register(CreateVoteUseCaseProtocol.self) { resolver in
            let repository = resolver.resolve(VoteRepositoryProtocol.self)!
            return CreateVoteUseCase(repository: repository)
        }
        
        container.register(FetchWinnerVoteOptionsUseCaseProtocol.self) { resovler in
            let repository = resovler.resolve(VoteRepositoryProtocol.self)!
            return FetchWinnerVoteOptionsUseCase(voteRepository: repository)
        }
    }
}
