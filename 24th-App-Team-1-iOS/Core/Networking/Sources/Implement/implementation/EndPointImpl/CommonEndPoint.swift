//
//  CommonEndPoint.swift
//  Networking
//
//  Created by eunseou on 8/4/24.
//

import Foundation
import Storage

import Alamofire

public enum CommonEndPoint: WSNetworkEndPoint {
    private var accessToken: String {
        guard let accessToken = KeychainManager.shared.get(type: .accessToken) else {
            return ""
        }
        return accessToken
    }
    
    case fetchUserProfile
    // 비속어 검색 API
    case createProfanityCheck(Encodable)
    // 프로필 캐릭터 정보 API
    case fetchCharacters
    // 프로필 배경색 정보 API
    case fetchBackgrounds
    // 유저 신고 API
    case createUserReport(Encodable)
    /// 사용자 프로필 수정 API
    case updateUserProfile(Encodable)
    /// 질문지 조회 API
    case fetchVoteOptions
    
    public var path: String {
        switch self {
        case .fetchUserProfile:
            return "/users/me"
        case .createProfanityCheck:
            return "/check-profanity"
        case .fetchCharacters:
            return "/users/characters"
        case .fetchBackgrounds:
            return "/users/backgrounds"
        case .createUserReport:
            return "/reports"
        case .updateUserProfile:
            return "/users/me"
        case .fetchVoteOptions:
            return "votes/options"
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        case .fetchUserProfile:
            return .get
        case .createProfanityCheck:
            return .post
        case .fetchCharacters:
            return .get
        case .fetchBackgrounds:
            return .get
        case .createUserReport:
            return .post
        case .updateUserProfile:
            return .put
        case .fetchVoteOptions:
            return .get
        }
    }
    
    public var parameters: WSRequestParameters {
        switch self {
        case .createProfanityCheck(let messsage):
            return .requestBody(messsage)
        case .fetchCharacters:
            return .none
        case .fetchBackgrounds:
            return .none
        case let .createUserReport(body):
            return .requestBody(body)
        case let .updateUserProfile(body):
            return .requestBody(body)
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
