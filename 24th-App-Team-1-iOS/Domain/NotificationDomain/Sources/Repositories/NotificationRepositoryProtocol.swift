//
//  NotificationRepositoryProtocol.swift
//  NotificationDomain
//
//  Created by Kim dohyun on 8/19/24.
//

import Foundation

import RxSwift


public protocol NotificationRepositoryProtocol {
    func fetchUserNotificationItems(query: NotificationReqeustQuery) -> Single<NotificationEntity?>
}
