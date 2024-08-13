//
//  ProfileEndPoint.swift
//  Networking
//
//  Created by Kim dohyun on 8/12/24.
//

import Foundation

import Alamofire


public enum ProfileEndPoint: WSNetworkEndPoint {
    /// 사용자 프로필 조회 API
    case fetchUserProfile
    /// 사용자 프로필 수정 API
    case updateUserProfile(Encodable)
    /// 알람 설정 API
    case updateNotification
    /// 알람 설정 조회 API
    case fetchNotification
    
    
    public var path: String {
        switch self {
        case .fetchUserProfile:
            return "/users/me"
        case .updateUserProfile:
            return "/users/me"
        case .updateNotification:
            return "/users/settings"
        case .fetchNotification:
            return "/users/settings"
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        case .fetchUserProfile:
            return .get
        case .updateUserProfile:
            return .put
        case .updateNotification:
            return .put
        case .fetchNotification:
            return .get
        }
    }
    
    public var parameters: WSRequestParameters {
        switch self {
        case let .updateUserProfile(body):
            return .requestBody(body)
        default:
            return .none
        }
    }
    
    public var headers: HTTPHeaders {
        return [
            "Content-Type": "application/json",
            "Authorization": "Bearer testToken"
        ]
    }
}
