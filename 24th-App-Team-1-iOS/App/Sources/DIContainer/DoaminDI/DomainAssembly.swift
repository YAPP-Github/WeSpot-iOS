//
//  DomainAssembly.swift
//  wespot
//
//  Created by Kim dohyun on 7/23/24.
//

import Foundation
import CommonDomain
import VoteDomain
import LoginDomain
import MessageDomain

import Swinject

struct DomainAssembly: Assembly {
    func assemble(container: Container) {
        
        //common
        container.register(CreateCheckProfanityUseCaseProtocol.self) { resolver in
            let repository = resolver.resolve(CommonRepositoryProtocol.self)!
            return createCheckProfanityUseCase(commonRepository: repository)
        }
        
        container.register(FetchProfileImagesUseCaseProtocol.self) { resolver in
            let repository = resolver.resolve(CommonRepositoryProtocol.self)!
            return FetchProfileImagesUseCase(commonRepository: repository)
        }
        
        container.register(FetchProfileBackgroundsUseCaseProtocol.self) { resolver in
            let repository = resolver.resolve(CommonRepositoryProtocol.self)!
            return FetchProfileBackgroundsUseCase(commonRepository: repository)
        }
        
        container.register(CreateReportUserUseCaseProtocol.self) { resolver in
            let repository = resolver.resolve(CommonRepositoryProtocol.self)!
            return CreateReportUserUseCase(commonRepositroy: repository)
        }
        
        // login
        container.register(CreateAccountUseCaseProtocol.self) { resovler in
            let repository = resovler.resolve(LoginRepositoryProtocol.self)!
            return CreateAccountUseCase(loginRepository: repository)
        }
        
        container.register(CreateRefreshTokenUseCaseProtocol.self) { resovler in
            let repository = resovler.resolve(LoginRepositoryProtocol.self)!
            return CreateRefreshTokenUseCase(loginRepository: repository)
        }
        
        container.register(CreateNewMemberUseCaseProtocol.self) { resovler in
            let repository = resovler.resolve(LoginRepositoryProtocol.self)!
            return CreateSignUpTokenUseCase(loginRepository: repository)
        }
        
        container.register(CreateExistingMemberUseCaseProtocol.self) { resovler in
            let repository = resovler.resolve(LoginRepositoryProtocol.self)!
            return CreateExistingMemberTokenUseCase(loginRepository: repository)
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
        
        container.register(FetchAllVoteOptionsUseCaseProtocol.self) { resovler in
            let repository = resovler.resolve(VoteRepositoryProtocol.self)!
            return FetchAllVoteOptionsUseCase(voteRepositroy: repository)
        }
        
        container.register(FetchVoteReceiveItemUseCaseProtocol.self) { resolver in
            let repository = resolver.resolve(VoteRepositoryProtocol.self)!
            return FetchVoteReceiveItemUseCase(voteRepository: repository)
        }
        
        container.register(FetchVoteSentItemUseCaseProtocol.self) { resolver in
            let repository = resolver.resolve(VoteRepositoryProtocol.self)!
            return FetchVoteSentItemUseCase(voteRepository: repository)
        }
        
        container.register(FetchIndividualItemUseCaseProtocol.self) { resolver in
            let repository = resolver.resolve(VoteRepositoryProtocol.self)!
            
            return FetchIndividualItemUseCase(voteRepository: repository)
        }
        
        // message
        container.register(FetchReservedMessageUseCaseProtocol.self) { resolver in
            let repository = resolver.resolve(MessageRepositoryProtocol.self)!
            return FetchReservedMessageUseCase(repository: repository)
        }
        
        container.register(FetchMessagesStatusUseCaseProtocol.self) { resolver in
            let repository = resolver.resolve(MessageRepositoryProtocol.self)!
            return FetchMessagesStatusUseCase(repository: repository)
        }
        
        container.register(FetchReceivedMessageUseCaseProtocol.self) { resolver in
            let repository = resolver.resolve(MessageRepositoryProtocol.self)!
            return FetchReceivedMessageUseCase(repository: repository)
        }
    }
}
