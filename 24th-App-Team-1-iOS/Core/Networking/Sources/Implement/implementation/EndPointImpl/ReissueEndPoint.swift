//
//  ReissueEndPoint.swift
//  Networking
//
//  Created by Kim dohyun on 8/24/24.
//

import Foundation

import Alamofire

public enum ReissueEndPoint: WSNetworkEndPoint {
    case createReissueToken(body: Encodable)
    
    public var path: String {
        switch self {
        case .createReissueToken:
            return "/auth/reissue"
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        case .createReissueToken:
            return .post
        }
    }
    
    public var parameters: WSRequestParameters {
        switch self {
        case let .createReissueToken(body):
            return .requestBody(body)
        }
    }
    
    public var headers: HTTPHeaders {
        
        switch self {
        case .createReissueToken:
            return [
                "Content-Type": "application/json",
                "Authorization": "Bearer testToken"
            ]
        }
    }
}
