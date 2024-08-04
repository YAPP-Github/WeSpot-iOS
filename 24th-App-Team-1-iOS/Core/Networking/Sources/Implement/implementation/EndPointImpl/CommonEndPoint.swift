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
    
    public var path: String {
        switch self {
        case .createProfanityCheck:
            return "/messages/check-profanity"
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        case .createProfanityCheck:
            return .post
        }
    }
    
    public var parameters: WSRequestParameters {
        switch self {
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
