//
//  ProfileImageEndPoint.swift
//  Networking
//
//  Created by eunseou on 8/6/24.
//

import UIKit
import Alamofire

public enum ProfileImageEndPoint: WSNetworkEndPoint {
    
    // 프로필 캐릭터 정보 API
    case fetchCharacters
    // 프로필 배경색 정보 API
    case fetchBackground
    
    public var path: String {
        switch self {
        case .fetchCharacters:
            return "/users/signup/characters"
        case .fetchBackground:
            return "/users/signup/backgrounds"
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        case .fetchCharacters:
            return .get
        case .fetchBackground:
            return .get
        }
    }
    
    public var parameters: WSRequestParameters {
        switch self {
        case .fetchCharacters:
            return .none
        case .fetchBackground:
            return .none
        }
    }
    
    public var headers: HTTPHeaders {
        return [
            "Content-Type": "application/json"
        ]
    }
}
