//
//  CommonEndPoint.swift
//  Networking
//
//  Created by eunseou on 8/4/24.
//

import Foundation

import Alamofire

public enum CommonEndPoint: WSNetworkEndPoint {
    
    // 비속어 검색 API
    case createProfanityCheck(Encodable)
    // 프로필 캐릭터 정보 API
    case fetchCharacters
    // 프로필 배경색 정보 API
    case fetchBackgrounds
    // 유저 신고 API
    case createUserReport(Encodable)
    
    public var path: String {
        switch self {
        case .createProfanityCheck:
            return "/messages/check-profanity"
        case .fetchCharacters:
            return "/users/signup/characters"
        case .fetchBackgrounds:
            return "/users/signup/backgrounds"
        case .createUserReport:
            return "/reports"
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        case .createProfanityCheck:
            return .post
        case .fetchCharacters:
            return .get
        case .fetchBackgrounds:
            return .get
        case .createUserReport:
            return .post
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
        }
    }
    
    public var headers: HTTPHeaders {
        return [
            "Content-Type": "application/json"
        ]
    }
}
