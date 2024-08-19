//
//  FetchUserNotificationItemUseCase.swift
//  NotificationDomain
//
//  Created by Kim dohyun on 8/19/24.
//

import Foundation

import RxSwift
import RxCocoa

public protocol FetchUserNotificationItemUseCaseProtocol {
    func execute(query: NotificationReqeustQuery) -> Single<NotificationEntity?>
}

public final class FetchUserNotificationItemUseCase: FetchUserNotificationItemUseCaseProtocol {
    
    private let notificationRepository: NotificationRepositoryProtocol
    
    public init(notificationRepository: NotificationRepositoryProtocol) {
        self.notificationRepository = notificationRepository
    }
    
    public func execute(query: NotificationReqeustQuery) -> Single<NotificationEntity?> {
        return notificationRepository.fetchUserNotificationItems(query: query)
    }
}
