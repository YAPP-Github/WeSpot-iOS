//
//  MessageEndPoint.swift
//  Networking
//
//  Created by eunseou on 8/8/24.
//

import Foundation

import Alamofire

public enum MessageEndPoint: WSNetworkEndPoint {
    
    // 예약된 쪽지 조회 API
    case fetchReservedMessages
    // 쪽지 조회 API
    case fetchMessages(Encodable)
    
    public var path: String {
        switch self {
        case .fetchReservedMessages:
            return "/messages/scheduled"
        case .fetchMessages:
            return "/messages"
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        case .fetchReservedMessages:
            return .get
        case .fetchMessages:
            return .get
        }
    }
    
    public var parameters: WSRequestParameters {
        switch self {
        case .fetchReservedMessages:
            return .none
        case .fetchMessages(let body):
            return .requestBody(body)
        }
    }
    
    public var headers: HTTPHeaders {
        return [
            "Content-Type": "application/json",
            "Authorization": "Bearer testToken"
        ]
    }
    
}
