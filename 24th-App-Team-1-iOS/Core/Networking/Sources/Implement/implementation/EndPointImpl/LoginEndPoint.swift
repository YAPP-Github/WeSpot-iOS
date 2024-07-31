//
//  LoginEndPoint.swift
//  Networking
//
//  Created by eunseou on 7/30/24.
//

import Foundation

import Alamofire

public enum LoginEndPoint: WSNetworkEndPoint {
    
    // 소셜로그인 API
    case createSocialLogin(Encodable)
    // 회원가입 API
    case createAccount(Encodable)
    // 토큰 재발행 API
    case createRefreshToken(Encodable)
    // 학교 정보 검색 API
    case fetchSchoolList(Encodable)
    // 비속어 검색 API
    case createProfanityCheck(Encodable)
    
    public var path: String {
        switch self {
        case .createSocialLogin:
            return "/auth/login"
        case .createAccount:
            return "/auth/signup"
        case .createRefreshToken:
            return "/auth/reissue"
        case .fetchSchoolList:
            return "/auth/signup/search"
        case .createProfanityCheck:
            return "/messages/check-profanity"
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        case .createSocialLogin:
            return .post
        case .createAccount:
            return .post
        case .createRefreshToken:
            return .post
        case .fetchSchoolList:
            return .get
        case .createProfanityCheck:
            return .post
        }
    }
    
    public var parameters: WSRequestParameters {
        switch self {
        case .createSocialLogin(let body):
            return .requestBody(body)
        case .createAccount(let body):
            return .requestBody(body)
        case .createRefreshToken(let body):
            return .requestBody(body)
        case .fetchSchoolList(let name):
            return .requestQuery(name)
        case .createProfanityCheck(let messsage):
            return .requestBody(messsage)
        }
    }
    
    public var headers: HTTPHeaders {
        return [
            "Content-Type": "application/json"
        ]
    }
}
