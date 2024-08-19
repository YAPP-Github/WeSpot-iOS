//
//  NotificationPresentationAssembly.swift
//  wespot
//
//  Created by Kim dohyun on 8/19/24.
//

import Foundation
import NotificationFeature
import NotificationDomain

import Swinject


struct NotificationPresentationAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(NotificationViewReactor.self) { resolver in
            let fetchUserNotificationItemUseCase = resolver.resolve(FetchUserNotificationItemUseCaseProtocol.self)!
            let updateUserNotificationItemUseCase = resolver.resolve(UpdateUserNotificationItemUseCaseProtocol.self)!
            return NotificationViewReactor(
                fetchUserNotificationItemsUseCase: fetchUserNotificationItemUseCase,
                updateUserNotifcationItemUseCase: updateUserNotificationItemUseCase
            )
        }
        
        container.register(NotificationViewController.self) { resolver in
            let reactor = resolver.resolve(NotificationViewReactor.self)!
            
            return NotificationViewController(reactor: reactor)
        }
    }
    
}
