//
//  ReissueEndPoint.swift
//  Networking
//
//  Created by Kim dohyun on 8/24/24.
//

import Foundation
import Storage

import Alamofire

public enum ReissueEndPoint: WSNetworkEndPoint {
    private var accessToken: String {
        guard let accessToken = KeychainManager.shared.get(type: .accessToken) else {
            return ""
        }
        return accessToken
    }
    
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
                "Authorization": "Bearer \(accessToken)"
            ]
        }
    }
}
