//
//  ProfileEndPoint.swift
//  Networking
//
//  Created by Kim dohyun on 8/12/24.
//

import Foundation
import Storage

import Alamofire


public enum ProfileEndPoint: WSNetworkEndPoint {
    private var accessToken: String {
        guard let accessToken = KeychainManager.shared.get(type: .accessToken) else {
            return ""
        }
        return accessToken
    }
    
    /// 사용자 프로필 조회 API
    case fetchUserProfile
    /// 사용자 프로필 수정 API
    case updateUserProfile(Encodable)
    /// 알람 설정 API
    case updateNotification(Encodable)
    /// 알람 설정 조회 API
    case fetchNotification
    /// 사용자 차단 목록 API
    case fetchUserBlock(Encodable)
    /// 사용자 차단 해체 API
    case updateUserBlock(String)
    /// 사용자 회원 탈퇴 API
    case updateUserResign
    
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
        case .fetchUserBlock:
            return "/messages/blocked"
        case let .updateUserBlock(messageId):
            return "/messages/\(messageId)/unblock"
        case .updateUserResign:
            return "/auth/revoke"
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
        case .fetchUserBlock:
            return .get
        case .updateUserBlock:
            return .post
        case .updateUserResign:
            return .post
        }
    }
    
    public var parameters: WSRequestParameters {
        switch self {
        case let .updateUserProfile(body):
            return .requestBody(body)
        case let .updateNotification(body):
            return .requestBody(body)
        case let .fetchUserBlock(query):
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
