//
//  UpdateUserNotificationItemUseCase.swift
//  NotificationDomain
//
//  Created by Kim dohyun on 8/19/24.
//

import Foundation

import RxSwift
import RxCocoa

public protocol UpdateUserNotificationItemUseCaseProtocol {
    func execute(path: String) -> Single<Bool>
}


public final class UpdateUserNotificationItemUseCase: UpdateUserNotificationItemUseCaseProtocol {
    
    private let notificationRepository: NotificationRepositoryProtocol
    
    
    public init(notificationRepository: NotificationRepositoryProtocol) {
        self.notificationRepository = notificationRepository
    }
    
    public func execute(path: String) -> Single<Bool> {
        return notificationRepository.updateUserNotificationItem(path: path)
    }
    
}
