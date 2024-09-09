//
//  NotificationEndPoint.swift
//  Networking
//
//  Created by Kim dohyun on 8/19/24.
//

import Foundation
import Storage

import Alamofire


public enum NotificationEndPoint: WSNetworkEndPoint {
    private var accessToken: String {
        guard let accessToken = KeychainManager.shared.get(type: .accessToken) else {
            return ""
        }
        return accessToken
    }
    
    /// 알림 목록 조회 API
    case fetchNotificationItems(Encodable)
    /// 알림 읽음 API
    case updateNotification(String)
    
    public var path: String {
        switch self {
        case .fetchNotificationItems:
            return "/notifications"
        case let .updateNotification(id):
            return "/notifications/\(id)"
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        case .fetchNotificationItems:
            return .get
        case .updateNotification:
            return .put
        }
    }
    
    public var parameters: WSRequestParameters {
        switch self {
        case let .fetchNotificationItems(query):
            return .requestQuery(query)
        default:
            return .none
        }
    }
    
    public var headers: HTTPHeaders {
        return [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(accessToken)"
        ]
    }
}
