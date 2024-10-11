//
//  NotificationPresentationAssembly.swift
//  wespot
//
//  Created by Kim dohyun on 8/19/24.
//

import Foundation
import NotificationFeature
import CommonDomain
import NotificationDomain

import Swinject


struct NotificationPresentationAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(NotificationViewReactor.self) { resolver in
            let fetchUserNotificationItemUseCase = resolver.resolve(FetchUserNotificationItemUseCaseProtocol.self)!
            let updateUserNotificationItemUseCase = resolver.resolve(UpdateUserNotificationItemUseCaseProtocol.self)!
            let fetchVoteOptionUseCase = resolver.resolve(FetchVoteOptionsUseCaseProtocol.self)!
            return NotificationViewReactor(
                fetchUserNotificationItemsUseCase: fetchUserNotificationItemUseCase,
                updateUserNotifcationItemUseCase: updateUserNotificationItemUseCase,
                fetchVoteOptionUseCase: fetchVoteOptionUseCase
            )
        }
        
        container.register(NotificationViewController.self) { resolver in
            let reactor = resolver.resolve(NotificationViewReactor.self)!
            
            return NotificationViewController(reactor: reactor)
        }
    }
    
}
