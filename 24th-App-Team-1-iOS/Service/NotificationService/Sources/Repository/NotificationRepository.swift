//
//  NotificationRepository.swift
//  NotificationService
//
//  Created by Kim dohyun on 8/19/24.
//

import Networking
import Foundation
import Util
import NotificationDomain

import RxSwift
import RxCocoa


public final class NotificationRepository: NotificationRepositoryProtocol {
    
    private let networkService: WSNetworkServiceProtocol = WSNetworkService()
    
    public init () { }
    
    
    public func fetchUserNotificationItems(query: NotificationReqeustQuery) -> Single<NotificationEntity?> {
        let endPoint = NotificationEndPoint.fetchNotificationItems(query.cursorId)
        
        return networkService.request(endPoint: endPoint)
            .asObservable()
            .decodeMap(NotificationResponseDTO.self)
            .logErrorIfDetected(category: Network.error)
            .map { $0.toDomain() }
            .asSingle()
    }
    
    
    public func updateUserNotificationItem(path: String) -> Single<Bool> {
        let endPoint = NotificationEndPoint.updateNotification(path)
        
        return networkService.request(endPoint: endPoint)
            .asObservable()
            .debug("notifiaction patch api")
            .map { _ in true }
            .catchAndReturn(false)
            .logErrorIfDetected(category: Network.error)
            .asSingle()
    }
}
