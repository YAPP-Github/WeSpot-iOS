//
//  MessageMainPresentationAssembly.swift
//  wespot
//
//  Created by eunseou on 8/7/24.
//

import Foundation
import MessageFeature
import MessageDomain

import Swinject

struct MessageHomePresentationAssembly: Assembly {
    func assemble(container: Container) {
        
        container.register(MessageHomeViewReactor.self) { resolver in
            let fetchMessagesStatusUseCase = resolver.resolve(FetchMessagesStatusUseCaseProtocol.self)!
            let fetchReservedMessageUseCase = resolver.resolve(FetchReservedMessageUseCaseProtocol.self)!
             
            return MessageHomeViewReactor(fetchMessagesStatusUseCase: fetchMessagesStatusUseCase, fetchReservedMessageUseCase: fetchReservedMessageUseCase)
        }
        
        container.register(MessageHomeViewController.self) { resolver in
            let reactor = resolver.resolve(MessageHomeViewReactor.self)!
            
            return MessageHomeViewController(reactor: reactor)
        }
        
    }
}

struct MessagePagePresentationAssembly: Assembly {
    func assemble(container: Container) {
        container.register(MessagePageViewReactor.self) { _ in
            return MessagePageViewReactor()
        }
        
        container.register(MessagePageViewController.self) { resolver in
            let reactor = resolver.resolve(MessagePageViewReactor.self)!
            
            return MessagePageViewController(reactor: reactor)
        }
    }
}

struct MessageMainPresentationAssembly: Assembly {
    func assemble(container: Container) {
        container.register(MessageMainViewReactor.self) { resolver in
            return MessageMainViewReactor()
        }
        
        container.register(MessageMainViewController.self) { resovler in
            let reactor = resovler.resolve(MessageMainViewReactor.self)!
            
            return MessageMainViewController(reactor: reactor)
        }
    }
    
    
}
